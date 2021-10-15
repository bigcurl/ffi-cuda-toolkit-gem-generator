# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExecutionControl
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuFuncGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuFuncGetModule, %i[pointer pointer], :int
      attach_function :cuFuncSetAttribute, %i[pointer pointer int], :int
      attach_function :cuFuncSetCacheConfig, %i[pointer pointer], :int
      attach_function :cuFuncSetSharedMemConfig, %i[pointer pointer], :int
      attach_function :cuLaunchCooperativeKernel,
                      %i[pointer uint uint uint uint uint uint uint pointer pointer], :int
      attach_function :cuLaunchCooperativeKernelMultiDevice, %i[pointer uint uint], :int
      attach_function :cuLaunchHostFunc, %i[pointer pointer pointer], :int
      attach_function :cuLaunchKernel,
                      %i[pointer uint uint uint uint uint uint uint pointer pointer pointer], :int
    end
  end
end
