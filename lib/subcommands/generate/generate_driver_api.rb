# frozen_string_literal: true

class GenerateDriverApi < ApplicationSubcommand
  option ['--cuda-version'],
         'N',
         'version of cuda to parse',
         default: '11.4.2'

  def execute
    @logger = Logger.new($stdout)
    @logger.info 'Start generate-driver-api subcommand'

    # Parse required html documentation
    cuda_docu_path = File.join(__dir__, "../../../vendor/nvidia/cuda-documentation/#{cuda_version}/cuda-driver-api")

    # parse_structs_from_documentation(cuda_docu_path)
    # parse_unions_from_documentation(cuda_docu_path)
    # parse_typedefs_from_documentation(cuda_docu_path)
    # parse_defines_from_documentation(cuda_docu_path)
    enums = parse_enums_from_documentation(cuda_docu_path)
    functions = parse_functions_from_documentation(cuda_docu_path)
    store_ffi_types_on_disk(enums, functions)

    @logger.info 'End generate-driver-api subcommand'
  end

  private

  # def parse_structs_from_documentation(cuda_docu_path)
  #   struct_html_pages_paths = Dir[File.join(cuda_docu_path, 'struct*')].sort
  #   struct_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

  #   c_type_structs = parse_struct_html_pages(struct_html_pages_paths)
  #   ffi_type_structs = transform_struct_c_types_into_ffi_types(c_type_structs)
  #   store_ffi_type_structs_on_disk(ffi_type_structs)
  # end

  # def parse_unions_from_documentation(cuda_docu_path)
  #   union_html_pages_paths = Dir[File.join(cuda_docu_path, 'union*')].sort

  #   ### Parse from html
  #   # union = {name: "", layout: [{name: "", type: ""}]}

  #   ### Transform c types output into ffi types

  #   ### Generate class from template

  #   # class InputEvent < FFI::Union
  #   #   layout :mi, MouseInput
  #   # end
  # end

  def parse_enums_from_documentation(cuda_docu_path)
    enum_html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    enum_html_pages_paths.select! { |name| name.include? 'group__CUDA__TYPES.html' }

    c_type_enums = parse_enum_html_pages(enum_html_pages_paths)
    stringify_enum_types(c_type_enums)
  end

  def parse_enum_html_pages(enum_html_pages_paths)
    c_type_enums = []

    enum_html_pages_paths.each do |enum_html_pages_path|
      doc = File.open(enum_html_pages_path) { |f| Nokogiri::HTML(f) }

      enum_name = ''
      values = []
      doc.css('.description~ .description+ .description dt').each do |description|
        if description.text.include? 'enum'
          c_type_enums << { enum_name: enum_name, values: values } unless values.empty?
          enum_name = ''
          values = []
          enum_name = description.text.strip.split[1]
        else
          name = description.text.split('=')[0]
          value = description.text.split('=')[1]
          values << { name: name, value: value }
        end
      end
    end
    c_type_enums
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

  def parse_functions_from_documentation(cuda_docu_path)
    function_html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    # Filtered out until the lib has been found where this is in
    # Seems to be different from the driver lib binary
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__GRAPHICS.html' }
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__EGL.html' }
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__GL.html' }

    # struct = {module_name: "", functions: [{function_name: "", return_type: "type", arguments: ["type"]}]}
    c_type_functions = parse_function_html_pages(function_html_pages_paths)
    ffi_type_functions = transform_function_c_types_into_ffi_types(c_type_functions)
    stringify_function_types(ffi_type_functions)
  end

  def parse_function_html_pages(function_html_pages_paths)
    c_type_modules = []
    function_html_pages_paths.each do |function_html_pages_path|
      c_type_functions = []
      function_name = ''

      doc = File.open(function_html_pages_path) { |f| Nokogiri::HTML(f) }

      module_name = doc.css('.topictitle2').text.split(' ')[1].gsub('[', '').gsub(']', '')
      doc.css('dt.description').each do |description|
        # "CUresult cuCtxCreate (  CUcontext* pctx, unsigned int  flags, CUdevice dev )"
        next if description.text.include? 'enum' # some pages also mention enums

        return_type = description.text.strip.split('(')[0].split[0..-2].join(' ')
        function_name = description.text.strip.split('(')[0].split[-1]

        args = []
        description.text.strip.split('(')[1].split(')')[0].split(',').each do |arg|
          name = arg.split(' ')[-1].strip # special blank character
          type = arg.split(' ')[0..-2].join(' ').strip # special blank character

          next if name.include?('void') && type.empty? # skip when no args

          args << { type: type, name: name }
        end

        c_type_functions << { return_type: return_type, function_name: function_name, args: args }
      end
      c_type_modules << { module_name: module_name, functions: c_type_functions }
    end
    c_type_modules
  end

  def transform_function_c_types_into_ffi_types(c_type_modules)
    ffi_type_modules = []

    c_type_modules.each do |c_type_module|
      ffi_type_functions = []
      c_type_module[:functions].each do |c_type_function|
        function_name = c_type_function[:function_name]
        return_type = ffi_types(c_type_function[:return_type])
        puts "Problem while parsing function return type: #{c_type_function[:return_type]}" if return_type.nil?

        args = c_type_function[:args].map do |args_pair|
          type = ffi_types(args_pair[:type])
          puts "Problem while parsing function return type: #{args_pair[:type]}" if type.nil?
          args_pair[:type] = type
          args_pair
        end

        ffi_type_functions << { function_name: function_name, return_type: return_type, args: args }
      end
      ffi_type_modules << { module_name: c_type_module[:module_name], functions: ffi_type_functions }
    end

    ffi_type_modules
  end

  def stringify_function_types(ffi_type_modules)
    functions = []
    ffi_type_modules.each do |ffi_type_module|
      functions << ffi_type_module[:functions].map do |ffi_type_function|
        args = ffi_type_function[:args].map { |x| ":#{x[:type]}" }.join(', ') # ugly to get sym but works
        name = ffi_type_function[:function_name]
        return_type = (ffi_type_function[:return_type]).to_s
        { name: name, args: args, return_type: return_type }
      end
    end
    functions.flatten
  end

  # def parse_struct_html_pages(struct_html_pages_paths)
  #   c_type_structs = []
  #   struct_html_pages_paths.each do |struct_html_pages_path|
  #     struct_name = ''
  #     layout = []

  #     doc = File.open(struct_html_pages_path) { |f| Nokogiri::HTML(f) }
  #     doc.css('.description span').each do |description|
  #       # "size_t  CUDA_ARRAY3D_DESCRIPTOR_v2::Height [inherited] "
  #       case description.elements.count
  #       when 3
  #         return_type = description.elements[0].text.strip.split('\n').join(' ')
  #         struct_name = description.elements[1].text.strip
  #         function_name = description.elements[2].text.strip
  #       when 2
  #         return_type = description.child.text.split("\n").join('').strip.split.join(' ')
  #         struct_name = description.elements[0].text.strip
  #         function_name = description.elements[1].text.strip
  #       end

  #       # Fix errors in documents from nvidia
  #       return_type = 'void *' if return_type == '*'
  #       return_type = 'void *' if return_type.include? '[MAX_PLANES]'

  #       # TODO: Still problems with:
  #       # CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1::@12::@13
  #       # CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1::@14::@15
  #       # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@17
  #       # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@19
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@21
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@23
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@22

  #       layout << { function_name: function_name, return_type: return_type }
  #     end

  #     c_type_structs << { struct_name: struct_name, layout: layout } unless layout.empty?
  #   end
  #   c_type_structs
  # end

  # def transform_struct_c_types_into_ffi_types(c_type_structs)
  #   ffi_type_structs = []

  #   c_type_structs.each do |c_type_struct|
  #     struct_name = c_type_struct[:struct_name]
  #     layout = c_type_struct[:layout].map do |layout_pair|
  #       return_type = ffi_types(layout_pair[:return_type])
  #       if return_type.nil?
  #         puts "Problem while parsing struct return type: #{layout_pair[:return_type]}"
  #         nil
  #       else
  #         layout_pair[:return_type] = return_type
  #         layout_pair
  #       end
  #     end

  #     next if layout.nil? || layout.any?(&:nil?)

  #     ffi_type_structs << { struct_name: struct_name, layout: layout }
  #   end
  #   ffi_type_structs
  # end

  # def store_ffi_type_structs_on_disk(ffi_type_structs)
  #   ### Generate class from template
  #   # class InputEvent < FFI::Struct
  #   #   layout :mi, MouseInput
  #   # end

  #   struct_template = %(
  #     class <%= struct_name %> < FFI::Struct
  #     layout <%= layout %>
  #     end
  #   )

  #   # create module folder
  #   FileUtils.mkdir_p File.join('gem', 'cuda', 'lib', 'cuda', 'driver', 'structs')

  #   a = Erubi::Engine.new(struct_template).src
  #   ffi_type_structs.each do |ffi_type_struct|
  #     layout = ffi_type_struct[:layout].map { |x| ":#{x[:function_name]}, :#{x[:return_type]}" }.join(",\n ")
  #     name = ffi_type_struct[:struct_name]

  #     splitted_name = name.split('_v').first

  #     struct_name = if splitted_name == splitted_name.upcase
  #                     name.downcase.pascal_case
  #                   else
  #                     name.pascal_case
  #                   end
  #     br = OpenStruct.new(name: struct_name, layout: layout).instance_eval(a)

  #     file_name = if splitted_name == splitted_name.upcase
  #                   name.downcase.snake_case
  #                 else
  #                   name.snake_case.gsub('c_u', 'cu_')
  #                 end

  #     file_name = "#{file_name}.rb"
  #     File.open(File.join('gem', 'cuda', 'lib', 'cuda', 'driver', 'structs', file_name), 'w') { |file| file.write(br) }
  #   end
  # end

  def store_ffi_types_on_disk(enums, functions)
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

            # Enums
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

    br = OpenStruct.new(functions: functions, enums: enums).instance_eval(template)

    file_name = 'wrapper.rb'
    File.open(File.join('gem', 'cuda', 'lib', 'cuda', 'driver', file_name), 'w') do |file|
      file.write(br)
    end
  end

  def ffi_types(ffi_type)
    {
      'int' => :int,
      'float' => :float,
      'double' => :double,
      'unsigned short' => :ushort,
      'unsigned char' => :uchar,
      'unsigned int' => :uint,
      'unsigned long long' => :ulong_long,
      'size_t' => :size_t,
      'void *' => :pointer,
      'const void *' => :pointer,
      'CUDA_ARRAY3D_DESCRIPTOR' => :pointer,
      'CUexternalSemaphore*' => :pointer,
      'CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS' => :pointer,
      'CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS' => :pointer,
      'CUhostFn' => :pointer,
      'CUfunction' => :pointer,
      'CUstream' => :pointer,
      'CUarray' => :pointer,
      'CUdeviceptr' => :pointer,
      'CUcontext' => :pointer,
      'CUmemAccessDesc' => :pointer,
      'CUmemPoolProps' => :pointer,
      'CUmipmappedArray' => :pointer,
      'CUmemLocation' => :pointer,
      # functions
      'CUcontext*' => :pointer,
      'CUdevice' => :pointer,
      'CUexecAffinityParam*' => :pointer,
      'unsigned int*' => :pointer,
      'CUfunc_cache*' => :pointer,
      'CUdevice*' => :pointer,
      'size_t*' => :pointer,
      'CUsharedconfig*' => :pointer,
      'int*' => :pointer,
      'CUmemoryPool*' => :pointer,
      'char*' => :pointer,
      'void*' => :pointer,
      'unsigned' => :pointer,
      'CUuuid*' => :pointer,
      'CUmemoryPool' => :pointer,
      'CUdevprop*' => :pointer,
      'const char*' => :pointer,
      'void**' => :pointer,
      'cuuint64_t' => :pointer,
      'cuuint64_t*' => :pointer,
      'CUeglStreamConnection*' => :pointer,
      'CUgraphicsResource*' => :pointer,
      'CUstream*' => :pointer,
      'EGLStreamKHR' => :pointer,
      'CUgraphicsResource' => :pointer,
      'EGLint' => :pointer,
      'CUeglFrame' => :pointer,
      'CUeglFrame*' => :pointer,
      'CUevent*' => :pointer,
      'EGLSyncKHR' => :pointer,
      'EGLImageKHR' => :pointer,
      'const char**' => :pointer,
      'CUevent' => :pointer,
      'float*' => :pointer,
      'CUmodule*' => :pointer,
      'CUDA_LAUNCH_PARAMS*' => :pointer,
      'CUtexref' => :pointer,
      'CUexternalMemory' => :pointer,
      'CUexternalSemaphore' => :pointer,
      'CUdeviceptr*' => :pointer,
      'const CUDA_EXTERNAL_MEMORY_BUFFER_DESC*' => :pointer,
      'CUmipmappedArray*' => :pointer,
      'const CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC*' => :pointer,
      'CUexternalMemory*' => :pointer,
      'const CUDA_EXTERNAL_MEMORY_HANDLE_DESC*' => :pointer,
      'const CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC*' => :pointer,
      'const CUexternalSemaphore*' => :pointer,
      'const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS*' => :pointer,
      'const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS*' => :pointer,
      'CUGLDeviceList' => :pointer,
      'GLuint' => :pointer,
      'HGPUNV' => :pointer,
      'CUgraphMem_attribute' => :pointer,
      'CUgraphNode*' => :pointer,
      'CUgraph' => :pointer,
      'const CUgraphNode*' => :pointer,
      'const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS*' => :pointer,
      'const CUDA_EXT_SEM_WAIT_NODE_PARAMS*' => :pointer,
      'const CUDA_HOST_NODE_PARAMS*' => :pointer,
      'const CUDA_KERNEL_NODE_PARAMS*' => :pointer,
      'CUDA_MEM_ALLOC_NODE_PARAMS*' => :pointer,
      'const CUDA_MEMCPY3D*' => :pointer,
      'const CUDA_MEMSET_NODE_PARAMS*' => :pointer,
      'CUgraphNode' => :pointer,
      'CUgraph*' => :pointer,
      'CUgraphExec' => :pointer,
      'CUgraphExecUpdateResult*' => :pointer,
      'CUDA_EXT_SEM_SIGNAL_NODE_PARAMS*' => :pointer,
      'CUDA_EXT_SEM_WAIT_NODE_PARAMS*' => :pointer,
      'CUDA_HOST_NODE_PARAMS*' => :pointer,
      'CUgraphExec*' => :pointer,
      'CUkernelNodeAttrValue*' => :pointer,
      'CUDA_KERNEL_NODE_PARAMS*' => :pointer,
      'const CUkernelNodeAttrValue*' => :pointer,
      'CUDA_MEMCPY3D*' => :pointer,
      'CUDA_MEMSET_NODE_PARAMS*' => :pointer,
      'CUgraphNodeType*' => :pointer,
      'CUuserObject' => :pointer,
      'CUuserObject*' => :pointer,
      'CUarray*' => :pointer,
      'const CUmemPoolProps*' => :pointer,
      'CUmemPoolPtrExportData*' => :pointer,
      'CUmemAccess_flags*' => :pointer,
      'CUmemLocation*' => :pointer,
      'const CUmemAccessDesc*' => :pointer,
      'const CUDA_ARRAY3D_DESCRIPTOR*' => :pointer,
      'CUDA_ARRAY3D_DESCRIPTOR*' => :pointer,
      'const CUDA_ARRAY_DESCRIPTOR*' => :pointer,
      'CUDA_ARRAY_DESCRIPTOR*' => :pointer,
      'CUDA_ARRAY_SPARSE_PROPERTIES*' => :pointer,
      'CUipcEventHandle*' => :pointer,
      'CUipcMemHandle*' => :pointer,
      'CUipcEventHandle' => :pointer,
      'CUipcMemHandle' => :pointer,
      'const CUDA_MEMCPY2D*' => :pointer,
      'const CUDA_MEMCPY3D_PEER*' => :pointer,
      'const void*' => :pointer,
      'CUstreamBatchMemOpParams*' => :pointer,
      'cuuint32_t' => :pointer,
      'CUlinkState' => :pointer,
      'CUjit_option*' => :pointer,
      'CUlinkState*' => :pointer,
      'CUfunction*' => :pointer,
      'CUmodule' => :pointer,
      'CUsurfref*' => :pointer,
      'CUtexref*' => :pointer,
      'CUoccupancyB2DSize' => :pointer,
      'CUoutput_mode' => :pointer,
      'CUstreamCallback' => :pointer,
      'CUstreamAttrValue*' => :pointer,
      'CUstreamCaptureStatus*' => :pointer,
      'const CUgraphNode**' => :pointer,
      'const CUstreamAttrValue*' => :pointer,
      'CUstreamCaptureMode*' => :pointer,
      'CUsurfObject*' => :pointer,
      'const CUDA_RESOURCE_DESC*' => :pointer,
      'CUsurfObject' => :pointer,
      'CUDA_RESOURCE_DESC*' => :pointer,
      'CUsurfref' => :pointer,
      'CUtexObject*' => :pointer,
      'const CUDA_TEXTURE_DESC*' => :pointer,
      'const CUDA_RESOURCE_VIEW_DESC*' => :pointer,
      'CUtexObject' => :pointer,
      'CUDA_RESOURCE_VIEW_DESC*' => :pointer,
      'CUDA_TEXTURE_DESC*' => :pointer,
      'CUaddress_mode*' => :pointer,
      'CUfilter_mode*' => :pointer,
      'CUarray_format*' => :pointer,
      'CUmem_range_attribute' => :pointer,
      'CUmem_range_attribute*' => :pointer,
      'CUpointer_attribute*' => :pointer,
      'CUmemGenericAllocationHandle*' => :pointer,
      'const CUmemAllocationProp*' => :pointer,
      'CUmemGenericAllocationHandle' => :pointer,
      'unsigned long long*' => :pointer,
      'const CUmemLocation*' => :pointer,
      'CUmemAllocationProp*' => :pointer,
      'CUarrayMapInfo*' => :pointer,
      'VdpOutputSurface' => :pointer,
      'VdpVideoSurface' => :pointer,
      'VdpDevice' => :pointer,
      'VdpGetProcAddress*' => :pointer,
      # # enums
      'CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS' => :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS,
      'CUGPUDirectRDMAWritesOrdering' => :CUGPUDirectRDMAWritesOrdering,
      'CUaccessProperty' => :CUaccessProperty,
      'CUaddress_mode' => :CUaddress_mode,
      'CUarraySparseSubresourceType' => :CUarraySparseSubresourceType,
      'CUarray_cubemap_face' => :CUarray_cubemap_face,
      'CUarray_format' => :CUarray_format,
      'CUcomputemode' => :CUcomputemode,
      'CUctx_flags' => :CUctx_flags,
      'CUdevice_P2PAttribute' => :CUdevice_P2PAttribute,
      'CUdevice_attribute' => :CUdevice_attribute,
      'CUdriverProcAddress_flags' => :CUdriverProcAddress_flags,
      'CUeglColorFormat' => :CUeglColorFormat,
      'CUeglFrameType' => :CUeglFrameType,
      'CUeglResourceLocationFlags' => :CUeglResourceLocationFlags,
      'CUevent_flags' => :CUevent_flags,
      'CUevent_record_flags' => :CUevent_record_flags,
      'CUevent_wait_flags' => :CUevent_wait_flags,
      'CUexecAffinityType' => :CUexecAffinityType,
      'CUexternalMemoryHandleType' => :CUexternalMemoryHandleType,
      'CUexternalSemaphoreHandleType' => :CUexternalSemaphoreHandleType,
      'CUfilter_mode' => :CUfilter_mode,
      'CUflushGPUDirectRDMAWritesOptions' => :CUflushGPUDirectRDMAWritesOptions,
      'CUflushGPUDirectRDMAWritesScope' => :CUflushGPUDirectRDMAWritesScope,
      'CUflushGPUDirectRDMAWritesTarget' => :CUflushGPUDirectRDMAWritesTarget,
      'CUfunc_cache' => :CUfunc_cache,
      'CUfunction_attribute' => :CUfunction_attribute,
      'CUgraphDebugDot_flags' => :CUgraphDebugDot_flags,
      'CUgraphInstantiate_flags' => :CUgraphInstantiate_flags,
      'CUgraphNodeType' => :CUgraphNodeType,
      'CUgraphicsMapResourceFlags' => :CUgraphicsMapResourceFlags,
      'CUgraphicsRegisterFlags' => :CUgraphicsRegisterFlags,
      'CUipcMem_flags' => :CUipcMem_flags,
      'CUjitInputType' => :CUjitInputType,
      'CUjit_cacheMode' => :CUjit_cacheMode,
      'CUjit_fallback' => :CUjit_fallback,
      'CUjit_option' => :CUjit_option,
      'CUjit_target' => :CUjit_target,
      'CUkernelNodeAttrID' => :CUkernelNodeAttrID,
      'CUlimit' => :CUlimit,
      'CUmemAccess_flags' => :CUmemAccess_flags,
      'CUmemAllocationCompType' => :CUmemAllocationCompType,
      'CUmemAllocationGranularity_flags' => :CUmemAllocationGranularity_flags,
      'CUmemAllocationHandleType' => :CUmemAllocationHandleType,
      'CUmemAllocationType' => :CUmemAllocationType,
      'CUmemAttach_flags' => :CUmemAttach_flags,
      'CUmemHandleType' => :CUmemHandleType,
      'CUmemLocationType' => :CUmemLocationType,
      'CUmemOperationType' => :CUmemOperationType,
      'CUmemPool_attribute' => :CUmemPool_attribute,
      'CUmem_advise' => :CUmem_advise,
      'CUmemorytype' => :CUmemorytype,
      'CUoccupancy_flags' => :CUoccupancy_flags,
      'CUpointer_attribute' => :CUpointer_attribute,
      'CUresourceViewFormat' => :CUresourceViewFormat,
      'CUresourcetype' => :CUresourcetype,
      'CUresult' => :CUresult,
      'CUshared_carveout' => :CUshared_carveout,
      'CUsharedconfig' => :CUsharedconfig,
      'CUstreamAttrID' => :CUstreamAttrID,
      'CUstreamBatchMemOpType' => :CUstreamBatchMemOpType,
      'CUstreamCaptureMode' => :CUstreamCaptureMode,
      'CUstreamCaptureStatus' => :CUstreamCaptureStatus,
      'CUstreamUpdateCaptureDependencies_flags' => :CUstreamUpdateCaptureDependencies_flags,
      'CUstreamWaitValue_flags' => :CUstreamWaitValue_flags,
      'CUstreamWriteValue_flags' => :CUstreamWriteValue_flags,
      'CUstream_flags' => :CUstream_flags,
      'CUuserObjectRetain_flags' => :CUuserObjectRetain_flags,
      'CUuserObject_flags' => :CUuserObject_flags
    }[ffi_type]
  end
end
