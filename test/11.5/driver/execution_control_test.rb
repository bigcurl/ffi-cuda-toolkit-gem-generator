# frozen_string_literal: true
# Needed
# CUresult cuFuncGetAttribute ( int* pi, CUfunction_attribute attrib, CUfunction hfunc )
# CUresult cuFuncGetModule ( CUmodule* hmod, CUfunction hfunc )
# CUresult cuFuncSetAttribute ( CUfunction hfunc, CUfunction_attribute attrib, int  value )
# CUresult cuFuncSetCacheConfig ( CUfunction hfunc, CUfunc_cache config )
# CUresult cuFuncSetSharedMemConfig ( CUfunction hfunc, CUsharedconfig config )
# CUresult cuLaunchCooperativeKernel ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams )
# CUresult cuLaunchCooperativeKernelMultiDevice ( CUDA_LAUNCH_PARAMS* launchParamsList, unsigned int  numDevices, unsigned int  flags )
# CUresult cuLaunchHostFunc ( CUstream hStream, CUhostFn fn, void* userData )
# CUresult cuLaunchKernel ( CUfunction f, unsigned int  gridDimX, unsigned int  gridDimY, unsigned int  gridDimZ, unsigned int  blockDimX, unsigned int  blockDimY, unsigned int  blockDimZ, unsigned int  sharedMemBytes, CUstream hStream, void** kernelParams, void** extra )
