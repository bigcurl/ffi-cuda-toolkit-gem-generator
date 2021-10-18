# frozen_string_literal: true

module Cuda
  module DriverApi
    module ContextManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuCtxCreate, %i[pointer uint pointer], :CUresult
      attach_function :cuCtxCreate_v3, %i[pointer pointer int uint pointer], :CUresult
      attach_function :cuCtxDestroy, [:pointer], :CUresult
      attach_function :cuCtxGetApiVersion, %i[pointer pointer], :CUresult
      attach_function :cuCtxGetCacheConfig, [:pointer], :CUresult
      attach_function :cuCtxGetCurrent, [:pointer], :CUresult
      attach_function :cuCtxGetDevice, [:pointer], :CUresult
      attach_function :cuCtxGetExecAffinity, %i[pointer CUexecAffinityType], :CUresult
      attach_function :cuCtxGetFlags, [:pointer], :CUresult
      attach_function :cuCtxGetLimit, %i[pointer CUlimit], :CUresult
      attach_function :cuCtxGetSharedMemConfig, [:pointer], :CUresult
      attach_function :cuCtxGetStreamPriorityRange, %i[pointer pointer], :CUresult
      attach_function :cuCtxPopCurrent, [:pointer], :CUresult
      attach_function :cuCtxPushCurrent, [:pointer], :CUresult
      attach_function :cuCtxResetPersistingL2Cache, [], :CUresult
      attach_function :cuCtxSetCacheConfig, [:CUfunc_cache], :CUresult
      attach_function :cuCtxSetCurrent, [:pointer], :CUresult
      attach_function :cuCtxSetLimit, %i[CUlimit size_t], :CUresult
      attach_function :cuCtxSetSharedMemConfig, [:CUsharedconfig], :CUresult
      attach_function :cuCtxSynchronize, [], :CUresult
    end
  end
end
