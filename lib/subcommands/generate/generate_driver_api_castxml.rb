# frozen_string_literal: true

class GenerateDriverApiCastxml < ApplicationSubcommand
  def execute
    @logger = Logger.new($stdout)
    @logger.info 'Start generate-driver-api-xml subcommand'

    cuda_version_path = File.join(__dir__, '..', '..', '..', 'vendor', 'nvidia', 'cuda-documentation')
    cuda_versions = Dir.entries(cuda_version_path).select do |entry|
      File.directory? File.join(cuda_version_path, entry) and !['.', '..'].include?(entry)
    end

    cuda_versions.each do |cuda_version|
      @logger.info "Start parsing CUDA version #{cuda_version}"

      cuda_header_path = File.join(
        __dir__,
        '..',
        '..',
        '..',
        'vendor',
        'nvidia',
        'cuda-documentation',
        cuda_version,
        'cuda.h.xml'
      )

      xml_doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }

      # Parse File
      file_id = Parser.parse_file_definition(xml_doc)

      # Parse Function
      functions_definition = Parser.parse_functions_definition(xml_doc, file_id)

      # Parse Enum
      enums_definition = Parser.parse_enums_definition(xml_doc, file_id)

      # Parse FundamentalTypes
      fundamental_type_definition = Parser.parse_fundamental_type_definition(xml_doc, file_id)

      # Parse Typedefs
      typedefs_definition = Parser.parse_typedefs_definition(xml_doc, file_id)

      # TODO: Parse Union
      # unions_definition = Parser.parse_unions_definition(xml_doc, file_id)

      # TODO: Parse Struct
      # structs_definition = Parser.parse_structs_definition(xml_doc, file_id)

      # Store on disk
      store_definitions_on_disk(cuda_version, functions_definition, enums_definition, fundamental_type_definition, typedefs_definition)

      @logger.info "End parsing CUDA version #{cuda_version}"
    end

    @logger.info 'End generate-driver-api subcommand'
  end

  def store_definitions_on_disk(cuda_version, functions, enums, fundamental_type, typedefs)

    wrapper_template = %(
      # rubocop:disable Naming/VariableNumber
      # rubocop:disable Metrics/ModuleLength
      # rubocop:disable Style/NumericLiterals

      module Cuda
        module DriverApi
            extend FFI::Library
            binary_list = `whereis -b libcuda`.strip.split('libcuda: ')
            binary_path = '/usr/lib/x86_64-linux-gnu/libcuda.so'
            binary_path = binary_list[1] unless binary_list[1].nil?
            ffi_lib binary_path

            # Typedefs
            <% for types in fundament_types %>
            typedef :<%= types[:type_name] %>, :<%= typedef[:name] %>
            <% end %>

            <% for typedef in typedefs %>
            typedef :<%= typedef[:type_name] %>, :<%= typedef[:name] %>
            <% end %>

            # Enums
            <% for enum in enums %>
            enum :<%= enum[:enum_name] %>, [<%= enum[:values_string] %>]
            <% end %>

            # Functions
            <% for function in functions %>
            attach_function :<%= function[:name] %>, [<%= function[:args] %>], :<%= function[:return_type] %>
            <% end %>
        end
      end

      # rubocop:enable Style/NumericLiterals
      # rubocop:enable Metrics/ModuleLength
      # rubocop:enable Naming/VariableNumber
    )

    # create module folder
    gem_folder_path = File.join('gem', 'cuda', 'lib', 'cuda', cuda_version, 'driver')
    FileUtils.mkdir_p gem_folder_path

    template = Erubi::Engine.new(wrapper_template).src

    enums = stringify_enum_types(enums)
    functions = stringify_function_types(functions)
 
    br = OpenStruct.new(
      fundamental_types: fundamental_types,
      functions: functions,
      enums: enums,
      typedefs: typedefs
    ).instance_eval(template)

    file_name = 'wrapper.rb'
    File.open(File.join(gem_folder_path, file_name), 'w') do |file|
      file.write(br)
    end
  end

  def stringify_enum_types(c_type_enums)
    c_type_enums.each do |c_type_enum|
      values = c_type_enum[:values].map do |c_type_value|
        line = ''
        line += ":#{c_type_value[:value]}"
        line += ", #{c_type_value[:init]}" unless c_type_value[:init].nil?
        line
      end
      c_type_enum[:values_string] = values.join(",\n")
    end
    debugger
    c_type_enums
  end

  def stringify_function_types(functions)
      functions.each do |ffi_type_function|
        args_string = ffi_type_function[:arguments].map do |x|
          target = :pointer if x[:type].include? '*'
          target = x[:type].gsub(' ', '_').to_sym if target.nil?
          ":#{target}" # colon in string is an ugly way to get sym but works
        end
        ffi_type_function[:arguments_string] = args_string.join(', ')
      end
    end
    functions
  end
end
