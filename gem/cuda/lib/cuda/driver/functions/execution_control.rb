# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExecutionControl
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuFuncGetAttribute, %i[pointer CUfunction_attribute pointer], :CUresult
      attach_function :cuFuncGetModule, %i[pointer pointer], :CUresult
      attach_function :cuFuncSetAttribute, %i[pointer CUfunction_attribute int], :CUresult
      attach_function :cuFuncSetCacheConfig, %i[pointer CUfunc_cache], :CUresult
      attach_function :cuFuncSetSharedMemConfig, %i[pointer CUsharedconfig], :CUresult
      attach_function :cuLaunchCooperativeKernel,
                      %i[pointer uint uint uint uint uint uint uint pointer pointer], :CUresult
      attach_function :cuLaunchCooperativeKernelMultiDevice, %i[pointer uint uint], :CUresult
      attach_function :cuLaunchHostFunc, %i[pointer pointer pointer], :CUresult
      attach_function :cuLaunchKernel,
                      %i[pointer uint uint uint uint uint uint uint pointer pointer pointer], :CUresult
    end
  end
end
