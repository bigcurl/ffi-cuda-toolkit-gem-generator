class GenerateDriverApi < ApplicationSubcommand
  option ['--cuda-version'],
         'N',
         'version of cuda to parse',
         default: '11.4.2'

  def execute
    @logger = Logger.new(STDOUT)
    @logger.info 'Start generate-driver-api subcommand'

    # Parse required html documentation
    cuda_docu_path = File.join(__dir__, "../../../vendor/nvidia/cuda-documentation/#{cuda_version}/cuda-driver-api")

    parse_structs_from_documentation(cuda_docu_path)
    # parse_unions_from_documentation(cuda_docu_path)
    # parse_typedefs_from_documentation(cuda_docu_path)
    # parse_defines_from_documentation(cuda_docu_path)
    # parse_enums_from_documentation(cuda_docu_path)
    parse_functions_from_documentation(cuda_docu_path)

    @logger.info 'End generate-driver-api subcommand'
  end

  private

  def parse_structs_from_documentation(cuda_docu_path)
    ## Generate structs
    ### Garther html pages
    struct_html_pages_paths = Dir[File.join(cuda_docu_path, 'struct*')].sort
    # remove Data types used by CUDA driver from list
    struct_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    ### Parse structs from html
    # struct = {name: "", layout: [{name: "", type: ""}]}
    c_type_structs = parse_struct_html_pages(struct_html_pages_paths)

    ### Transform parsed output to ffi code
    ffi_type_structs = transform_struct_c_types_into_ffi_types(c_type_structs)

    store_ffi_type_structs_on_disk(ffi_type_structs)
  end

  def parse_unions_from_documentation(cuda_docu_path)
    ## Generate unions
    ### Garther html pages
    union_html_pages_paths = Dir[File.join(cuda_docu_path, 'union*')].sort

    ### Parse from html
    # union = {name: "", layout: [{name: "", type: ""}]}

    ### Transform c types output into ffi types

    ### Generate class from template

    # class InputEvent < FFI::Union
    #   layout :mi, MouseInput
    # end
  end

  def parse_enums_from_documentation(cuda_docu_path)
    ## Generate enum
    ### Garther html pages
    ### Parse typedefs from html
    ### Transform parsed output to ffi code
    ### Genrate class from template
  end

  def parse_functions_from_documentation(cuda_docu_path)
    ## Generate structs
    ### Garther html pages
    function_html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    # remove Data types used by CUDA driver from list
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    ### Parse structs from html
    # struct = {module_name: "", functions: [{function_name: "", return_type: "type", arguments: ["type"]}]}
    c_type_functions = parse_function_html_pages(function_html_pages_paths)

    ### Transform parsed output to ffi code
    ffi_type_functions = transform_function_c_types_into_ffi_types(c_type_functions)

    store_ffi_type_functions_on_disk(ffi_type_functions)
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
        puts 'Problem while parsing function return type: ' + c_type_function[:return_type] if return_type.nil?

        args = []

        args = c_type_function[:args].map do |args_pair|
          type = ffi_types(args_pair[:type])
          puts 'Problem while parsing function return type: ' + args_pair[:type] if type.nil?
          args_pair[:type] = type
          args_pair
        end

        ffi_type_functions << { function_name: function_name, return_type: return_type, args: args }
      end
      ffi_type_modules << { module_name: c_type_module[:module_name], functions: ffi_type_functions }
    end

    ffi_type_modules
  end

  def store_ffi_type_functions_on_disk(ffi_type_modules)
    ### Generate class from template
    #  module A
    #   extend FFI::Library
    #   ffi_lib 'c'
    #   attach_function :strlen, [:string], :int
    # end

    function_template = %(
      module Cuda
        module DriverApi
          module <%= module_name %>
            extend FFI::Library
            ffi_lib '/usr/lib/x86_64-linux-gnu/libcuda.so'
            <% for function in functions %>
            attach_function :<%= function[:name].to_sym %>, [<%= function[:args] %>], <%= function[:return_type] %>
            <% end %>
          end
        end
      end
    )

    # create module folder
    FileUtils.mkdir_p 'modules/functions'

    template = Erubi::Engine.new(function_template).src
    ffi_type_modules.each do |ffi_type_module|
      functions = ffi_type_module[:functions].map do |ffi_type_function|
        args = ffi_type_function[:args].map { |x| x[:type].to_sym.to_s }.join(', ')
        name = ffi_type_function[:function_name].to_sym
        return_type = ":#{ffi_type_function[:return_type].to_sym}"
        { name: name, args: args, return_type: return_type }
      end

      module_name = ffi_type_module[:module_name].downcase.pascal_case

      br = OpenStruct.new(module_name: module_name, functions: functions).instance_eval(template)

      file_name = ffi_type_module[:module_name].downcase.snake_case

      file_name = "#{file_name}.rb"
      File.open(File.join('modules', 'functions', file_name), 'w') { |file| file.write(br) }
    end
  end

  def parse_struct_html_pages(struct_html_pages_paths)
    c_type_structs = []
    struct_html_pages_paths.each do |struct_html_pages_path|
      struct_name = ''
      layout = []

      doc = File.open(struct_html_pages_path) { |f| Nokogiri::HTML(f) }
      doc.css('.description span').each do |description|
        # "size_t  CUDA_ARRAY3D_DESCRIPTOR_v2::Height [inherited] "
        if description.elements.count == 3
          return_type = description.elements[0].text.strip.split('\n').join(' ')
          struct_name = description.elements[1].text.strip
          function_name = description.elements[2].text.strip
        elsif description.elements.count == 2
          return_type = description.child.text.split("\n").join('').strip.split.join(' ')
          struct_name = description.elements[0].text.strip
          function_name = description.elements[1].text.strip
        end

        # Fix errors in documents from nvidia
        return_type = 'void *' if return_type == '*'
        return_type = 'void *' if return_type.include? '[MAX_PLANES]'

        # TODO: Still problems with:
        # CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1::@12::@13
        # CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1::@14::@15
        # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@17
        # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@19
        # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@21
        # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@23
        # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@22

        layout << { function_name: function_name, return_type: return_type }
      end

      c_type_structs << { struct_name: struct_name, layout: layout } unless layout.empty?
    end
    c_type_structs
  end

  def transform_struct_c_types_into_ffi_types(c_type_structs)
    ffi_type_structs = []

    c_type_structs.each do |c_type_struct|
      struct_name = c_type_struct[:struct_name]
      layout = []

      layout = c_type_struct[:layout].map do |layout_pair|
        return_type = ffi_types(layout_pair[:return_type])
        if return_type.nil?
          puts 'Problem while parsing struct return type: ' + layout_pair[:return_type]
          nil
        else
          layout_pair[:return_type] = return_type
          layout_pair
        end
      end

      next if layout.nil? || layout.any? { |x| x.nil? }

      ffi_type_structs << { struct_name: struct_name, layout: layout }
    end
    ffi_type_structs
  end

  def store_ffi_type_structs_on_disk(ffi_type_structs)
    ### Generate class from template
    # class InputEvent < FFI::Struct
    #   layout :mi, MouseInput
    # end

    struct_template = %(
      class <%= struct_name %> < FFI::Struct
      layout <%= layout %>
      end
    )

    # create module folder
    FileUtils.mkdir_p 'modules/structs'

    a = Erubi::Engine.new(struct_template).src
    ffi_type_structs.each do |ffi_type_struct|
      layout = ffi_type_struct[:layout].map { |x| ":#{x[:function_name]}, :#{x[:return_type]}" }.join(",\n ")
      name = ffi_type_struct[:struct_name]

      splitted_name = name.split('_v').first

      struct_name = if splitted_name == splitted_name.upcase
                      name.downcase.pascal_case
                    else
                      name.pascal_case
                    end
      br = OpenStruct.new(name: struct_name, layout: layout).instance_eval(a)

      file_name = if splitted_name == splitted_name.upcase
                    name.downcase.snake_case
                  else
                    name.snake_case.gsub('c_u', 'cu_')
                  end

      file_name = "#{file_name}.rb"
      File.open(File.join('modules', 'structs', file_name), 'w') { |file| file.write(br) }
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
      'CUarray_format' => :pointer,
      'CUDA_ARRAY3D_DESCRIPTOR' => :pointer,
      'CUexternalSemaphoreHandleType' => :pointer,
      'CUexternalSemaphore*' => :pointer,
      'CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS' => :pointer,
      'CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS' => :pointer,
      'CUhostFn' => :pointer,
      'CUfunction' => :pointer,
      'CUstream' => :pointer,
      'CUarray' => :pointer,
      'CUdeviceptr' => :pointer,
      'CUmemorytype' => :pointer,
      'CUcontext' => :pointer,
      'CUmemAccessDesc' => :pointer,
      'CUmemPoolProps' => :pointer,
      'CUmipmappedArray' => :pointer,
      'CUresourcetype' => :pointer,
      'CUresourceViewFormat' => :pointer,
      'CUaddress_mode' => :pointer,
      'CUfilter_mode' => :pointer,
      'CUaccessProperty' => :pointer,
      'CUmemHandleType' => :pointer,
      'CUmemOperationType' => :pointer,
      'CUarraySparseSubresourceType' => :pointer,
      'CUeglColorFormat' => :pointer,
      'CUeglFrameType' => :pointer,
      'CUmemAccess_flags' => :pointer,
      'CUmemLocation' => :pointer,
      'CUmemLocationType' => :pointer,
      'CUmemAllocationType' => :pointer,
      'CUmemAllocationHandleType' => :pointer,
      'CUexternalMemoryHandleType' => :pointer,
      # functions
      'CUresult' => :int,
      'CUcontext*' => :pointer,
      'CUdevice' => :pointer,
      'CUexecAffinityParam*' => :pointer,
      'unsigned int*' => :pointer,
      'CUfunc_cache*' => :pointer,
      'CUdevice*' => :pointer,
      'CUexecAffinityType' => :pointer,
      'size_t*' => :pointer,
      'CUlimit' => :pointer,
      'CUsharedconfig*' => :pointer,
      'int*' => :pointer,
      'CUfunc_cache' => :pointer,
      'CUsharedconfig' => :pointer,
      'CUdevice_attribute' => :pointer,
      'CUmemoryPool*' => :pointer,
      'char*' => :pointer,
      'void*' => :pointer,
      'unsigned' => :pointer,
      'CUuuid*' => :pointer,
      'CUmemoryPool' => :pointer,
      'CUflushGPUDirectRDMAWritesTarget' => :pointer,
      'CUflushGPUDirectRDMAWritesScope' => :pointer,
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
      'CUfunction_attribute' => :pointer,
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
      'CUkernelNodeAttrID' => :pointer,
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
      'CUmemPool_attribute' => :pointer,
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
      'CUjitInputType' => :pointer,
      'CUjit_option*' => :pointer,
      'CUlinkState*' => :pointer,
      'CUfunction*' => :pointer,
      'CUmodule' => :pointer,
      'CUsurfref*' => :pointer,
      'CUtexref*' => :pointer,
      'CUoccupancyB2DSize' => :pointer,
      'CUdevice_P2PAttribute' => :pointer,
      'CUoutput_mode' => :pointer,
      'CUstreamCallback' => :pointer,
      'CUstreamCaptureMode' => :pointer,
      'CUstreamAttrID' => :pointer,
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
      'CUmem_advise' => :pointer,
      'CUmem_range_attribute' => :pointer,
      'CUmem_range_attribute*' => :pointer,
      'CUpointer_attribute' => :pointer,
      'CUpointer_attribute*' => :pointer,
      'CUmemGenericAllocationHandle*' => :pointer,
      'const CUmemAllocationProp*' => :pointer,
      'CUmemGenericAllocationHandle' => :pointer,
      'unsigned long long*' => :pointer,
      'const CUmemLocation*' => :pointer,
      'CUmemAllocationGranularity_flags' => :pointer,
      'CUmemAllocationProp*' => :pointer,
      'CUarrayMapInfo*' => :pointer,
      'VdpOutputSurface' => :pointer,
      'VdpVideoSurface' => :pointer,
      'VdpDevice' => :pointer,
      'VdpGetProcAddress*' => :pointer
    }[ffi_type]
  end
end
