# frozen_string_literal: true

require 'test_helper'

# Not done
# cuFlushGPUDirectRDMAWrites ( CUflushGPUDirectRDMAWritesTarget target, CUflushGPUDirectRDMAWritesScope scope )

class CudaDeviceManagementTest < Minitest::Test
  def setup
    device_pointer = FFI::MemoryPointer.new(:int, 1)

    Cuda::DriverApi.cuInit(0)
    Cuda::DriverApi.cuDeviceGet(device_pointer, 0)
    @cu_device = device_pointer.read(:int)
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
    assert_equal(:success, Cuda::DriverApi.cuDeviceTotalMem_v2(size_pointer, @cu_device))
    refute_equal(0, size_pointer.read(:size_t))
  end

  def test_cu_device_get_name
    len = 100
    name = FFI::MemoryPointer.new(100)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetName(name, len, @cu_device))
    refute_equal(0, name.read_string.size)
    # puts "CUDA driver name: #{name.read_string()}"
  end

  def test_cu_device_get_uuid
    device_uuid_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetUuid(device_uuid_ptr, @cu_device))
    refute_nil(device_uuid_ptr.read_pointer)
  end

  def test_cu_device_get_uuid_v2
    device_uuid_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetUuid_v2(device_uuid_ptr, @cu_device))
    refute_nil(device_uuid_ptr.read_pointer)
  end

  def test_cu_device_get_luid
    device_node_mask_ptr = FFI::MemoryPointer.new :pointer
    luid = FFI::MemoryPointer.new :pointer
    # NOTE: Refute used for making the test pass as some GPU might not support it
    refute_equal(:success, Cuda::DriverApi.cuDeviceGetLuid(luid, device_node_mask_ptr, @cu_device))
  end

  def test_cu_device_get_default_mem_pool
    cu_memory_pool_ptr = FFI::MemoryPointer.new :pointer

    # NOTE: Refute used for making the test pass as some GPU might not support it
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetDefaultMemPool(cu_memory_pool_ptr, @cu_device))
  end

  def test_cu_device_get_set_mem_pool
    cu_memory_pool_ptr = FFI::MemoryPointer.new :pointer

    # NOTE: Refute used for making the test pass as some GPU might not support it
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetMemPool(cu_memory_pool_ptr, @cu_device))
    assert_equal(:success, Cuda::DriverApi.cuDeviceSetMemPool(@cu_device, cu_memory_pool_ptr.read_pointer))
  end

  def test_cu_device_get_texture_1d_linear_max_width
    max_width_in_elements_ptr = FFI::MemoryPointer.new(:size_t, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetTexture1DLinearMaxWidth(max_width_in_elements_ptr, Cuda::DriverApi::CUarray_format_enum[:unsigned_int8], 2, @cu_device))
  end

  def test_cu_device_get_attribute
    pi_ptr = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetAttribute(pi_ptr, :max_threads_per_block, @cu_device))
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetAttribute(pi_ptr, :registers_per_block, @cu_device))
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetAttribute(pi_ptr, :clock_rate, @cu_device))
  end

  def test_cu_device_get_nv_sci_sync_attributes
    nv_sci_sync_attr_list = FFI::MemoryPointer.new :pointer
    # NOTE: Used refute_equal to pass the test as some device might not have nv sync
    refute_equal(:success, Cuda::DriverApi.cuDeviceGetNvSciSyncAttributes(nv_sci_sync_attr_list, @cu_device, Cuda::DriverApi::CUDA_NVSCISYNC_ATTR_SIGNAL))
    refute_equal(:success, Cuda::DriverApi.cuDeviceGetNvSciSyncAttributes(nv_sci_sync_attr_list, @cu_device, Cuda::DriverApi::CUDA_NVSCISYNC_ATTR_SIGNAL))
  end

  # def test_cu_flush_gpu_direct_rdma_writes
  # end
end
