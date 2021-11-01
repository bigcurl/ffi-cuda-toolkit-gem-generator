# frozen_string_literal: true

require 'test_helper'

class CudaPrimaryContextTest < Minitest::Test
  @@cuDevice = 0

  def setup
    Cuda::DriverApi.cuInit(0)

    device_pointer = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDeviceGet(device_pointer, 0)
    @@cuDevice = device_pointer.read(:int)
  end

  def test_cu_device_primary_ctx_get_state
    flags = FFI::MemoryPointer.new :pointer
    active = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxGetState(@@cuDevice, flags, active))
  end

  def test_cu_device_primary_ctx_set_flags
    flags = Cuda::DriverApi::CU_CTX_SCHED_SPIN
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxSetFlags_v2(@@cuDevice, flags))

    flags = FFI::MemoryPointer.new :pointer
    active = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDevicePrimaryCtxGetState(@@cuDevice, flags, active)

    assert_equal(Cuda::DriverApi::CU_CTX_SCHED_SPIN, flags.read(:uint))

    # Reset the flag
    Cuda::DriverApi.cuDevicePrimaryCtxSetFlags_v2(@@cuDevice, Cuda::DriverApi::CU_CTX_SCHED_AUTO)
  end

  def test_cu_device_primary_ctx_retain
    p_ctx = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxRetain(p_ctx, @@cuDevice))
  end

  def test_cu_device_primary_ctx_release
    assert_equal(:error_invalid_context, Cuda::DriverApi.cuDevicePrimaryCtxRelease_v2(@@cuDevice))

    p_ctx = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDevicePrimaryCtxRetain(p_ctx, @@cuDevice)
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxRelease_v2(@@cuDevice))
  end

  def test_cu_device_primary_ctx_reset
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxReset_v2(@@cuDevice))
  end
end
