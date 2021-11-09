# frozen_string_literal: true

require 'test_helper'

# Needed
# CUresult cuDevicePrimaryCtxGetState ( CUdevice dev, unsigned int* flags, int* active )
# CUresult cuDevicePrimaryCtxRelease ( CUdevice dev )
# CUresult cuDevicePrimaryCtxReset ( CUdevice dev )
# CUresult cuDevicePrimaryCtxRetain ( CUcontext* pctx, CUdevice dev )
# CUresult cuDevicePrimaryCtxSetFlags ( CUdevice dev, unsigned int  flags ) 

class CudaPrimaryContextTest < Minitest::Test
  def setup
    @cu_device = 0

    Cuda::DriverApi.cuInit(0)

    device_pointer = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDeviceGet(device_pointer, 0)
    @cu_device = device_pointer.read(:int)
  end

  def test_cu_device_primary_ctx_get_state
    flags = FFI::MemoryPointer.new :pointer
    active = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxGetState(@cu_device, flags, active))
  end

  def test_cu_device_primary_ctx_set_flags
    flags = Cuda::DriverApi::CU_CTX_SCHED_SPIN
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxSetFlags_v2(@cu_device, flags))

    flags = FFI::MemoryPointer.new :pointer
    active = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDevicePrimaryCtxGetState(@cu_device, flags, active)

    assert_equal(Cuda::DriverApi::CU_CTX_SCHED_SPIN, flags.read(:uint))

    # Reset the flag
    Cuda::DriverApi.cuDevicePrimaryCtxSetFlags_v2(@cu_device, Cuda::DriverApi::CU_CTX_SCHED_AUTO)
  end

  def test_cu_device_primary_ctx_retain
    p_ctx = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxRetain(p_ctx, @cu_device))
  end

  def test_cu_device_primary_ctx_release
    # Calling the release will provide invalid context if there is no context initialized
    # assert_equal(:error_invalid_context, Cuda::DriverApi.cuDevicePrimaryCtxRelease_v2(@cu_device))

    p_ctx = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDevicePrimaryCtxRetain(p_ctx, @cu_device)
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxRelease_v2(@cu_device))
  end

  def test_cu_device_primary_ctx_reset
    assert_equal(:success, Cuda::DriverApi.cuDevicePrimaryCtxReset_v2(@cu_device))
  end
end
