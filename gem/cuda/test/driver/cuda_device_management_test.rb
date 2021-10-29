# frozen_string_literal: true

require 'test_helper'

# problems with driver_api
# cuDeviceGetName ( char* name, int  len, CUdevice dev ) => name is a returned pointer from CUDA API. In ruby it also should be pointer instead of string
# cuDeviceGetLuid ( char* luid, unsigned int* deviceNodeMask, CUdevice dev )
# cuFlushGPUDirectRDMAWrites ( CUflushGPUDirectRDMAWritesTarget target, CUflushGPUDirectRDMAWritesScope scope )

# TODO: needs working structs
# cuDeviceGetAttribute ( int* pi, CUdevice_attribute attrib, CUdevice dev )
# cuDeviceGetDefaultMemPool ( CUmemoryPool* pool_out, CUdevice dev )
# cuDeviceGetLuid ( char* luid, unsigned int* deviceNodeMask, CUdevice dev )
# cuDeviceGetMemPool ( CUmemoryPool* pool, CUdevice dev )
# cuDeviceGetNvSciSyncAttributes ( void* nvSciSyncAttrList, CUdevice dev, int  flags )
# cuDeviceGetTexture1DLinearMaxWidth ( size_t* maxWidthInElements, CUarray_format format, unsigned numChannels, CUdevice dev )

# TODO: Not done
# cuDeviceSetMemPool ( CUdevice dev, CUmemoryPool pool )

class CudaDeviceManagementTest < Minitest::Test
  @@device_pointer = FFI::MemoryPointer.new(:int, 1)

  def setup
    Cuda::DriverApi.cuInit(0)
    Cuda::DriverApi.cuDeviceGet(@@device_pointer, 0)
  end

  def test_cu_device_get_count
    count_pointer = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetCount(count_pointer))
    refute_equal(0, count_pointer.read(:int))
  end

  def test_cu_device_get_success
    device_pointer = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGet(device_pointer, 0))
    assert_equal(0, device_pointer.read(:int))
  end

  def test_cu_device_get_invalid_device
    device_pointer = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:error_invalid_device, Cuda::DriverApi.cuDeviceGet(device_pointer, -1)) # invalid device number
    assert_equal(0, device_pointer.read(:int))
  end

  def test_cu_device_total_mem
    size_pointer = FFI::MemoryPointer.new(:size_t, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceTotalMem_v2(size_pointer, @@device_pointer.read(:int)))
    refute_equal(0, size_pointer.read(:size_t))
  end

  def test_cu_device_get_name
    len = 100
    name = FFI::MemoryPointer.new(100)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetName(name, len, @@device_pointer.read(:int)))
    refute_equal(0, name.read_string.size)
    # puts "CUDA driver name: #{name.read_string()}"
  end

  def test_cu_device_get_uuid
    device_uuid_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetUuid(device_uuid_ptr, @@device_pointer.read(:int)))
    refute_nil(device_uuid_ptr.read_pointer)
  end

  def test_cu_device_get_uuid_v2
    device_uuid_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetUuid_v2(device_uuid_ptr, @@device_pointer.read(:int)))
    refute_nil(device_uuid_ptr.read_pointer)
  end

  def test_cu_device_get_luid
    device_node_mask_ptr = FFI::MemoryPointer.new :pointer
    luid = FFI::MemoryPointer.new :pointer
    # FIXME: returns error_not_supported.
    # Sam: Same for me, it is also not supported on my device
    # assert_equal(:success, Cuda::DriverApi.cuDeviceGetLuid(luid, device_node_mask_ptr, @@device_pointer.read(:int)))
    assert_equal(:error_not_supported, Cuda::DriverApi.cuDeviceGetLuid(luid, device_node_mask_ptr, @@device_pointer.read(:int)))
  end

  def test_cu_device_get_default_mem_pool
    cu_memory_pool_ptr = FFI::MemoryPointer.new :pointer

    # FIXME: returns error_not_supported
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetDefaultMemPool(cu_memory_pool_ptr, @@device_pointer.read(:int)))
  end

  def test_cu_device_get_mem_pool
    cu_memory_pool_ptr = FFI::MemoryPointer.new :pointer

    # FIXME: returns error_not_supported
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetMemPool(cu_memory_pool_ptr, @@device_pointer.read(:int)))
  end

  def test_cu_device_get_texture_1d_linear_max_width
    max_width_in_elements_ptr = FFI::MemoryPointer.new(:size_t, 1)
    # FIXME: returns error_not_supported
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetTexture1DLinearMaxWidth(max_width_in_elements_ptr, Cuda::DriverApi::CUarray_format_enum[:unsigned_int8], 2, @@device_pointer.read(:int)))
  end

  def test_cu_device_get_attribute
    pi_ptr = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetAttribute(pi_ptr, :max_threads_per_block, @@device_pointer.read(:int)))

    # Try to check all the attributes under CUdevice_attribute
  end
end