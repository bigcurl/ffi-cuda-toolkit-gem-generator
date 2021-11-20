# frozen_string_literal: true

# Needed
# CUresult cuModuleGetFunction ( CUfunction* hfunc, CUmodule hmod, const char* name )
# CUresult cuModuleGetGlobal ( CUdeviceptr* dptr, size_t* bytes, CUmodule hmod, const char* name )
# CUresult cuModuleLoad ( CUmodule* module, const char* fname )
# CUresult cuModuleLoadData ( CUmodule* module, const void* image )
# CUresult cuModuleLoadDataEx ( CUmodule* module, const void* image, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuModuleLoadFatBinary ( CUmodule* module, const void* fatCubin )
# CUresult cuModuleUnload ( CUmodule hmod )

# Not needed
# CUresult cuLinkAddData ( CUlinkState state, CUjitInputType type, void* data, size_t size, const char* name, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuLinkAddFile ( CUlinkState state, CUjitInputType type, const char* path, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuLinkComplete ( CUlinkState state, void** cubinOut, size_t* sizeOut )
# CUresult cuLinkCreate ( unsigned int  numOptions, CUjit_option* options, void** optionValues, CUlinkState* stateOut )
# CUresult cuLinkDestroy ( CUlinkState state )
# CUresult cuModuleGetSurfRef ( CUsurfref* pSurfRef, CUmodule hmod, const char* name )
# CUresult cuModuleGetTexRef ( CUtexref* pTexRef, CUmodule hmod, const char* name )

require 'test_helper'

class CudaModuleManagementTest < Minitest::Test
  def setup
    @cu_device = 0
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    @cu_context = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    # For testing the memory we need to have a context created
    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)
  end

  def test_cu_link_create_destroy
    num_options = 1
    options = FFI::MemoryPointer.new(:int, num_options)
    options.write_array_of_int([Cuda::DriverApi::CU_JIT_WALL_TIME])
    # Cuda::DriverApi::CU_JIT_INFO_LOG_BUFFER,
    # Cuda::DriverApi::CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES,
    # Cuda::DriverApi::CU_JIT_ERROR_LOG_BUFFER,
    # Cuda::DriverApi::CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES,
    # Cuda::DriverApi::CU_JIT_LOG_VERBOSE

    wall_time = FFI::MemoryPointer.new(:pointer, 1)
    wall_time.write(:float, 3)

    option_values = FFI::MemoryPointer.new(:pointer, num_options)
    option_values.write_array_of_pointer([wall_time.read_pointer])

    state_out = FFI::MemoryPointer.new :pointer

    assert_equal(:success, Cuda::DriverApi.cuLinkCreate_v2(num_options, options, option_values, state_out))
    assert_equal(:success, Cuda::DriverApi.cuLinkDestroy(state_out.read_pointer))
  end

  def test_cu_module_load
    cu_module = FFI::MemoryPointer.new :pointer
    filepath = ('./test/11.5/driver/vectorAdd_kernel64.fatbin')

    assert_equal(:success, Cuda::DriverApi.cuModuleLoad(cu_module, filepath))
    refute_nil(cu_module.read_pointer)
  end

  def test_cu_module_load_data
    cu_module = FFI::MemoryPointer.new :pointer
    fatbin = File.open('./test/11.5/driver/vectorAdd_kernel64.fatbin', 'rb')
    image = FFI::MemoryPointer.from_string(fatbin.read) # A data such as ptx, fatbin or cubin required to load into module

    assert_equal(:success, Cuda::DriverApi.cuModuleLoadData(cu_module, image))
    refute_nil(cu_module.read_pointer)
  end

  def test_cu_module_load_data_ex
    num_options = 1
    options = FFI::MemoryPointer.new(:int, num_options)
    options.write_array_of_int([Cuda::DriverApi::CU_JIT_WALL_TIME])
    # Cuda::DriverApi::CU_JIT_INFO_LOG_BUFFER,
    # Cuda::DriverApi::CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES,
    # Cuda::DriverApi::CU_JIT_ERROR_LOG_BUFFER,
    # Cuda::DriverApi::CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES,
    # Cuda::DriverApi::CU_JIT_LOG_VERBOSE

    wall_time = FFI::MemoryPointer.new(:pointer, 1)
    wall_time.write(:float, 3)

    option_values = FFI::MemoryPointer.new(:pointer, num_options)
    option_values.write_array_of_pointer([wall_time.read_pointer])

    cu_module = FFI::MemoryPointer.new :pointer
    fatbin = File.open('./test/11.5/driver/vectorAdd_kernel64.fatbin', 'rb')
    image = FFI::MemoryPointer.from_string(fatbin.read) # A data such as ptx, fatbin or cubin required to load into module

    assert_equal(:success, Cuda::DriverApi.cuModuleLoadDataEx(cu_module, image, num_options, options, option_values))
    refute_nil(cu_module.read_pointer)
  end

  def test_cu_module_load_fat_binary_and_unload
    cu_module = FFI::MemoryPointer.new :pointer
    fatbin = File.open('./test/11.5/driver/vectorAdd_kernel64.fatbin', 'rb')
    image = FFI::MemoryPointer.from_string(fatbin.read) # A data such as ptx, fatbin or cubin required to load into module

    assert_equal(:success, Cuda::DriverApi.cuModuleLoadData(cu_module, image))
    refute_nil(cu_module.read_pointer)

    assert_equal(:success, Cuda::DriverApi.cuModuleUnload(cu_module.read_pointer))
  end

  def test_cu_module_get_function
    h_func = FFI::MemoryPointer.new(:pointer)
    cu_module = FFI::MemoryPointer.new :pointer
    fatbin = File.open('./test/11.5/driver/vectorAdd_kernel64.fatbin', 'rb')
    image = FFI::MemoryPointer.from_string(fatbin.read) # A data such as ptx, fatbin or cubin required to load into module

    assert_equal(:success, Cuda::DriverApi.cuModuleLoadData(cu_module, image))

    assert_equal(:success, Cuda::DriverApi.cuModuleGetFunction(h_func, cu_module.read_pointer, "VecAdd_kernel"))
    assert_equal(:error_not_found, Cuda::DriverApi.cuModuleGetFunction(h_func, cu_module.read_pointer, "empty"))
  end

  def test_cu_module_get_global
    cu_module = FFI::MemoryPointer.new :pointer
    fatbin = File.open('./test/11.5/driver/vectorAdd_kernel64.fatbin', 'rb')
    image = FFI::MemoryPointer.from_string(fatbin.read) # A data such as ptx, fatbin or cubin required to load into module

    assert_equal(:success, Cuda::DriverApi.cuModuleLoadData(cu_module, image))

    d_ptr = FFI::MemoryPointer.new(:ulong_long)
    bytes = FFI::MemoryPointer.new(:size_t)
    # vector kernel fatbin has no global variable
    assert_equal(:error_not_found, Cuda::DriverApi.cuModuleGetGlobal_v2(d_ptr, bytes, cu_module.read_pointer, "error"))
  end

end
