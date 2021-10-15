# frozen_string_literal: true

module Cuda
  module DriverApi
    module ContextManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuCtxCreate, %i[pointer uint pointer], :int
      attach_function :cuCtxCreate_v3, %i[pointer pointer int uint pointer], :int
      attach_function :cuCtxDestroy, [:pointer], :int
      attach_function :cuCtxGetApiVersion, %i[pointer pointer], :int
      attach_function :cuCtxGetCacheConfig, [:pointer], :int
      attach_function :cuCtxGetCurrent, [:pointer], :int
      attach_function :cuCtxGetDevice, [:pointer], :int
      attach_function :cuCtxGetExecAffinity, %i[pointer pointer], :int
      attach_function :cuCtxGetFlags, [:pointer], :int
      attach_function :cuCtxGetLimit, %i[pointer pointer], :int
      attach_function :cuCtxGetSharedMemConfig, [:pointer], :int
      attach_function :cuCtxGetStreamPriorityRange, %i[pointer pointer], :int
      attach_function :cuCtxPopCurrent, [:pointer], :int
      attach_function :cuCtxPushCurrent, [:pointer], :int
      attach_function :cuCtxResetPersistingL2Cache, [], :int
      attach_function :cuCtxSetCacheConfig, [:pointer], :int
      attach_function :cuCtxSetCurrent, [:pointer], :int
      attach_function :cuCtxSetLimit, %i[pointer size_t], :int
      attach_function :cuCtxSetSharedMemConfig, [:pointer], :int
      attach_function :cuCtxSynchronize, [], :int
    end
  end
end
