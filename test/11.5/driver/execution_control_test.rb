# frozen_string_literal: true

# Needed
# CUresult cuLaunchHostFunc ( CUstream hStream, CUhostFn fn, void* userData )
# CUresult cuLaunchKernel ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams, void** extra )
# CUresult cuLaunchCooperativeKernel ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams )

# Not Needed
# CUresult cuFuncGetAttribute ( int* pi, CUfunction_attribute attrib, CUfunction hfunc )
# CUresult cuFuncGetModule ( CUmodule* hmod, CUfunction hfunc )
# CUresult cuFuncSetAttribute ( CUfunction hfunc, CUfunction_attribute attrib, int  value )
# CUresult cuFuncSetCacheConfig ( CUfunction hfunc, CUfunc_cache config )
# CUresult cuFuncSetSharedMemConfig ( CUfunction hfunc, CUsharedconfig config )
# CUresult cuLaunchCooperativeKernelMultiDevice ( CUDA_LAUNCH_PARAMS* launchParamsList, unsigned int  numDevices, unsigned int  flags )

require 'test_helper'

class ExecutionControlTest < Minitest::Test
  def setup
    @cu_device = 0
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    # @cu_context = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)

    @cu_stream = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuStreamCreate(@cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT)
  end

  # FIXME: Need help
  # Getting error_invalid_handle
  # Either Call back function is not passed correctly or user_data
  def test_cu_launch_host_func
    callback = Proc.new do |buf_ptr|
      puts 'Callback called'
    end

    user_data = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuLaunchHostFunc(@cu_stream.read_pointer, callback, user_data))
  end

  # FIXME: Need help
  #  ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams, void** extra )
  def test_cu_launch_kernel
    assert_equal(false , true, "Not implemented")
  end

  # FIXME: Need help
  # CUresult cuLaunchCooperativeKernel ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams )
  def test_cu_launch_cooperative_kernel
    assert_equal(false , true, "Not implemented")
  end

end
