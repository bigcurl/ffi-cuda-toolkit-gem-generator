# frozen_string_literal: true

require 'test_helper'

# Missing
# cuDeviceTotalMem ( size_t* bytes, CUdevice dev )
# cuDeviceGetUuid ( CUuuid* uuid, CUdevice dev )
# cuDeviceGetUuid_v2 ( CUuuid* uuid, CUdevice dev )
# cuDeviceGetName ( char* name, int  len, CUdevice dev )

# TODO: needs working structs
# cuDeviceGetAttribute ( int* pi, CUdevice_attribute attrib, CUdevice dev )
# cuDeviceGetDefaultMemPool ( CUmemoryPool* pool_out, CUdevice dev )
# cuDeviceGetLuid ( char* luid, unsigned int* deviceNodeMask, CUdevice dev )
# cuDeviceGetMemPool ( CUmemoryPool* pool, CUdevice dev )
# cuDeviceGetNvSciSyncAttributes ( void* nvSciSyncAttrList, CUdevice dev, int  flags )
# cuDeviceGetTexture1DLinearMaxWidth ( size_t* maxWidthInElements, CUarray_format format, unsigned numChannels, CUdevice dev )
# cuDeviceSetMemPool ( CUdevice dev, CUmemoryPool pool )
# cuFlushGPUDirectRDMAWrites ( CUflushGPUDirectRDMAWritesTarget target, CUflushGPUDirectRDMAWritesScope scope )

class CudaDeviceManagementTest < Minitest::Test
  def setup
    Cuda::DriverApi.cuInit(0)
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
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuDeviceGet(device_pointer, -1)) # invalid device number
    assert_equal(0, device_pointer.read(:int))
  end

  def test_cu_device_total_mem
    device_pointer = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDeviceGet(device_pointer, 0)

    size_pointer = FFI::MemoryPointer.new(:size_t, 1)
    assert_equal(:success, Cuda::DriverApi.cuDeviceTotalMem(size_pointer, device_pointer.read(:int)))
    assert_equal(0, size_pointer.read(:size_t))
  end
end
