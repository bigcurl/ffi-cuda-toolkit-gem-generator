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

class ExecutionControlTest < Minitest::Test
  def setup
    Cuda::DriverApi.cuInit(0)
  end

  def test_cu_launch_host_func
    callback = FFI::Function.new(:void, [:pointer]) do |_buf_ptr|
      assert(_buf_ptr)
    end

    assert_equal(:success, Cuda::DriverApi.cuLaunchHostFunc(nil, callback, nil))
    sleep 1
  end
end
