# frozen_string_literal: true

class GenerateDriverApi < ApplicationSubcommand
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

      # Parse required html documentation
      c_type_structs = Parser.parse_structs_from_documentation(cuda_docu_path)
      c_type_defines = Parser.parse_define_from_documentation(cuda_docu_path)
      c_type_enums = Parser.parse_enums_from_documentation(cuda_docu_path)
      c_type_functions = Parser.parse_functions_from_documentation(cuda_docu_path)
      c_type_typedefs = Parser.parse_typedefs_from_documentation(cuda_docu_path)

      # Store everything to disk into the gem folder
      store_ffi_types_on_disk(cuda_version, c_type_defines, c_type_structs, c_type_typedefs, c_type_enums, c_type_functions)
      @logger.info "End parsing CUDA version #{cuda_version}"
    end

      # Parse Enum
      enums_definition = Parser.parse_enums_definition(xml_doc, file_id)

      # Parse FundamentalTypes
      fundamental_type_definition = Parser.parse_fundamental_type_definition(xml_doc, file_id)

      # Parse Typedefs
      typedefs_definition = Parser.parse_typedefs_definition(xml_doc, file_id)

      # TODO: Parse Union
      unions_definition = Parser.parse_unions_definition(xml_doc, file_id)

      # TODO: Parse Struct
      structs_definition = Parser.parse_structs_definition(xml_doc, file_id)

      # TODO: Parse FunctionTypes
      # structs_definition = Parser.parse_structs_definition(xml_doc, file_id)

      # Store on disk
      store_definitions_on_disk(cuda_version, functions_definition, enums_definition, fundamental_type_definition,
                                typedefs_definition, unions_definition)

      @logger.info "End parsing CUDA version #{cuda_version}"
    end
    converted_types
  end

  def store_ffi_types_on_disk(cuda_version, c_defines, c_structs, typedefs, c_type_enums, c_type_functions)
    enums = stringify_enum_types(c_type_enums)
    functions = stringify_function_types(c_type_functions)
    ### Generate enum from template
    #  enum :letters, [:a, 1, :b, :c, :y, 25, :z]

    @logger.info 'End generate-driver-api subcommand'
  end

    index = 1
    count = 2
    sep = ''
    sep = ',' if index != count

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

            # TODO: Missing Structs, FunctionTypes

            # Unions
            <% for union in unions %>
            class <%= union[:name] %> < FFI::Union
              layout <%= union[:fields_string] %>
            end

            <% end %>

            # Fundamental Typedefs
            <% for fundamental_type in fundamental_types %>
            typedef :<%= fundamental_type[:ffi_type] %>, :<%= fundamental_type[:name].gsub(' ', '_') %>
            <% end %>

            # Typedefs
            <% for typedef in typedefs %>
            typedef :<%= typedef[:type_name].gsub(' ', '_') %>, :<%= typedef[:name].gsub(' ', '_') %>
            <% end %>

            # Unions and structs

            class StreamMemOpValueStruct_U < FFI::Union
              layout :value, :cuuint32_t,
                     :value64, :cuuint64_t
            end

            class StreamMemOpValue_Struct < FFI::Struct
              layout :operation, :CUstreamBatchMemOpType,
                     :address, :CUdeviceptr,
                     :unionValue, StreamMemOpValueStruct_U,
                     :flags, :uint,
                     :alias, :CUdeviceptr
            end

            class FlushRemoteWrites_Struct < FFI::Struct
              layout :operation, :CUstreamBatchMemOpType,
                     :flags, :uint
            end

            class CUstreamBatchMemOpParams_v1 < FFI::Struct
              layout :operation, :CUstreamBatchMemOpType,
                     :waitValue, StreamMemOpValue_Struct,
                     :writeValue, StreamMemOpValue_Struct,
                     :flushRemoteWrites, FlushRemoteWrites_Struct,
                     :pad, [:cuuint64_t, 6]
            end

            typedef :CUstreamBatchMemOpParams_v1, :CUstreamBatchMemOpParams

            class CUkernelNodeAttrValue_v1 < FFI::Union
              layout :accessPolicyWindow, :CUaccessPolicyWindow,
                     :cooperative, :int
            end
            typedef :CUkernelNodeAttrValue_v1, :CUkernelNodeAttrValue

            class CUkernelNodeAttrValue_v1 < FFI::Union
              layout :accessPolicyWindow, :CUaccessPolicyWindow,
                     :cooperative, :int
            end
            typedef :CUkernelNodeAttrValue_v1, :CUkernelNodeAttrValue

            # DEFINES
            <% for define in defines %>
            <%= define[:name] %> = <%= define[:value] %>
            <% end %>

            # Structs
            <% for struct in c_structs %>
              <% struct_name = struct[:name] %>
              class <%= struct_name %> < FFI::Struct
                <% unless struct[:members].empty? %>
                  <% sep = ',' if struct[:members].count > 1 %>
                  <% name = struct[:members][0][:name] %>
                  <% type = struct[:members][0][:type] %>
                  <% if name.include?('[') && name.include?(']') %>
                    <% size_match = name.match(/\\[[0-9]+\\]/).to_s %>
                    <% size = size_match.to_s.gsub(/\\[/, '').gsub(/\\]/, '') %>
                    <% name = name.gsub(/\\[[0-9]+\\]/, '') %>
                    layout :<%= name %>, [:<%= type %>, <%= size %>]<%= ',' if struct[:members].count > 1 %>
                  <% else %>
                    layout :<%= name %>, :<%= type %><%= ',' if struct[:members].count > 1 %>
                  <% end %>
                  <% index = 1 %>
                  <% count = struct[:members].count %>
                  <% for member in struct[:members] %>
                    <% if index == 1 %>
                      <% index += 1 %>
                      <% next %>
                    <% end %>
                    <% name = member[:name] %>
                    <% type = member[:type] %>
                    <% if name.include?('[') && name.include?(']') %>
                      <% size_match = name.match(/\\[[0-9]+\\]/).to_s %>
                      <% size = size_match.gsub(/\\[/, '').gsub(/\\]/, '') %>
                      <% name = name.gsub(/\\[[0-9]+\\]/, '') %>
                      :<%= name %>, [:<%= type %>, <%= size %>]<%= ',' if index != count %>
                    <% else %>
                      :<%= name %>, :<%= type %><%= ',' if index != count %>
                    <% end %>
                    <% index += 1 %>
                  <% end %>
                <% end %>
              end
              <% new_struct_name = struct_name.split('_v') %>
              typedef :<%= struct_name %>, :<%= new_struct_name[0] %>
            <% end %>

            # Functions
            <% for function in functions %>
            attach_function :<%= function[:name] %>, [<%= function[:arguments_string] %>], :<%= function[:return_type_name] %>
            <% end %>
        end
      end

      # rubocop:enable Style/NumericLiterals
      # rubocop:enable Metrics/ModuleLength
      # rubocop:enable Naming/VariableNumber
    )

    # create module folder
    gem_folder_path = File.join('gem', 'cuda', 'lib', 'cuda', cuda_version)
    FileUtils.mkdir_p gem_folder_path

    template = Erubi::Engine.new(wrapper_template).src

    enums = stringify_enum_types(enums)
    functions = stringify_function_types(functions)
    unions = stringify_union_types(unions)

    br = OpenStruct.new(
      fundamental_types: fundamental_types,
      functions: functions,
      enums: enums,
      typedefs: typedefs,
      unions: unions
    ).instance_eval(template)

    file_name = 'driver_api.rb'
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

    c_type_enums
  end

  def stringify_function_types(functions)
    functions.each do |ffi_type_function|
      args_string = ffi_type_function[:arguments].map do |x|
        arg = ":#{x[:type_name].tr(' ', '_')}" # colon in string is an ugly way to get sym but works
        arg = ':pointer' if arg.include? 'void'
        arg
      end
      ffi_type_function[:arguments_string] = args_string.join(', ')
    end
    functions
  end

  def stringify_union_types(unions)
    unions.each do |union|
      fields = union[:fields].map do |union_field|
        line = ''
        line += ":#{union_field[:name]}"
        line += ", #{union_field[:type_name]}"
        line
      end
      union[:fields_string] = fields.join(",\n")
    end

    unions
  end
end
