# frozen_string_literal: true

class GenerateDriverApi < ApplicationSubcommand
  option ['--cuda-version'],
         'N',
         'version of cuda to parse',
         default: '11.4.2'

  def execute
    @logger = Logger.new($stdout)
    @logger.info 'Start generate-driver-api subcommand'

    cuda_docu_path = File.join(__dir__, "../../../vendor/nvidia/cuda-documentation/#{cuda_version}/cuda-driver-api")

    # Parse required html documentation
    # Parser.parse_unions_from_documentation(cuda_docu_path)
    # Parser.parse_defines_from_documentation(cuda_docu_path)
    c_type_enums = Parser.parse_enums_from_documentation(cuda_docu_path)

    # Parser.parse_structs_from_documentation(cuda_docu_path)
    c_type_functions = Parser.parse_functions_from_documentation(cuda_docu_path)
    c_type_typedefs = Parser.parse_typedefs_from_documentation(cuda_docu_path)

    # Store everything to disk into the gem folder
    store_ffi_types_on_disk(c_type_typedefs, c_type_enums, c_type_functions)

    @logger.info 'End generate-driver-api subcommand'
  end

  private

  def extract_typedefs_from_c_types(c_type_functions, c_type_typedefs)
    cuda_types = []

    c_type_functions.each do |c_type_function|
      functions = c_type_function[:functions]
      functions.each do |function|
        cuda_types << function[:return_type]
        function[:args].each do |arg|
          cuda_types << arg[:type]
        end
      end
    end

    c_type_typedefs.each do |c_type_typedef|
      # types[:name] = snake_case
    end

    converted_types = []
    cuda_types.uniq.each do |cuda_type|
      next if cuda_type == 'int'
      next if cuda_type == 'size_t'
      next if cuda_type == 'double'
      next if cuda_type == 'float'
      next if cuda_type == 'unsigned short'
      next if cuda_type == 'unsigned int'
      next if cuda_type == 'unsigned long long'
      next if cuda_type == 'unsigned char'
      next if cuda_type.include? '*'

      type = type_symbol = cuda_type.gsub(' ', '_').to_sym

      # for now the easiest thing, can be refined later

      converted_types << { ffi_type: type, cuda_type: type_symbol }
    end
    converted_types
  end

  def store_ffi_types_on_disk(typedefs, c_type_enums, c_type_functions)
    enums = stringify_enum_types(c_type_enums)
    functions = stringify_function_types(c_type_functions)
    ### Generate enum from template
    #  enum :letters, [:a, 1, :b, :c, :y, 25, :z]

    ### Generate class from template
    #  module A
    #   extend FFI::Library
    #   ffi_lib 'c'
    #   attach_function :strlen, [:string], :int
    # end

    wrapper_template = %(
      # rubocop:disable Naming/VariableNumber
      # rubocop:disable Metrics/ModuleLength

      module Cuda
        module DriverApi
            extend FFI::Library
            binary_list = `whereis -b libcuda`.strip.split('libcuda: ')
            binary_path = '/usr/lib/x86_64-linux-gnu/libcuda.so'
            binary_path = binary_list[1] unless binary_list[1].nil?
            ffi_lib binary_path

            # Structs
            # TODO

            # Typedefs
            typedef :ushort, :unsigned_short
            typedef :uchar, :unsigned_char
            typedef :uint, :unsigned_int
            typedef :ulong_long, :unsigned_long_long
            typedef :uint64, :cuuint64_t
            typedef :pointer, :CUhostFn
            typedef :uint, :GLuint

            typedef :pointer, :CUipcEventHandle
            typedef :CUipcEventHandle, :CUipcEventHandle_v1
            typedef :pointer, :CUipcMemHandle
            typedef :CUipcMemHandle, :CUipcMemHandle_v1
            typedef :uint32, :cuuint32_t
            typedef :pointer, :CUlinkState
            typedef :pointer, :CUoccupancyB2DSize
            typedef :int, :CUoutput_mode
            typedef :pointer, :CUstreamCallback
            typedef :pointer, :CUmem_range_attribute
            typedef :unsigned_long_long, :CUmemGenericAllocationHandle_v1
            typedef :CUmemGenericAllocationHandle_v1, :CUmemGenericAllocationHandle
            typedef :pointer, :VdpOutputSurface
            typedef :pointer, :VdpVideoSurface
            typedef :int, :VdpDevice

            <% for typedef in typedefs %>
            typedef :<%= typedef[:ffi_type] %>, :<%= typedef[:cuda_type] %>
            <% end %>

            # Enums
            enum :CUgraphMem_attribute, [:CU_GRAPH_MEM_ATTR_USED_MEM_CURRENT, :CU_GRAPH_MEM_ATTR_USED_MEM_HIGH, :CU_GRAPH_MEM_ATTR_RESERVED_MEM_CURRENT, :CU_GRAPH_MEM_ATTR_RESERVED_MEM_HIGH]

            <% for enum in enums %>
            enum :<%= enum[:enum_name] %>, [<%= enum[:values] %>]

            <% end %>

            # Functions

            <% for function in functions %>
            attach_function :<%= function[:name] %>, [<%= function[:args] %>], :<%= function[:return_type] %>
            <% end %>
        end
      end

      # rubocop:enable Metrics/ModuleLength
      # rubocop:enable Naming/VariableNumber
    )

    # create module folder
    FileUtils.mkdir_p File.join('gem', 'cuda', 'lib', 'cuda', 'driver')

    template = Erubi::Engine.new(wrapper_template).src

    br = OpenStruct.new(functions: functions, enums: enums, typedefs: typedefs).instance_eval(template)

    file_name = 'wrapper.rb'
    File.open(File.join('gem', 'cuda', 'lib', 'cuda', 'driver', file_name), 'w') do |file|
      file.write(br)
    end
  end

  def stringify_enum_types(c_type_enums)
    enums = []
    c_type_enums.each do |c_type_enum|
      values = c_type_enum[:values].map do |c_type_value|
        line = ''
        line += ":#{c_type_value[:name]}"
        line += ", #{c_type_value[:value]}" unless c_type_value[:value].nil?
        line
      end
      enums << { enum_name: c_type_enum[:enum_name], values: values.join(",\n") }
    end
    enums
  end

  def stringify_function_types(ffi_type_modules)
    functions = []
    ffi_type_modules.each do |ffi_type_module|
      functions << ffi_type_module[:functions].map do |ffi_type_function|
        args = ffi_type_function[:args].map do |x|
          target = :pointer if x[:type].include? '*'
          target = x[:type].gsub(' ', '_').to_sym if target.nil?
          ":#{target}" # colon in string is an ugly way to get sym but works
        end
        args = args.join(', ')
        name = ffi_type_function[:function_name]
        return_type = (ffi_type_function[:return_type]).to_s
        { name: name, args: args, return_type: return_type }
      end
    end
    functions.flatten
  end
end
