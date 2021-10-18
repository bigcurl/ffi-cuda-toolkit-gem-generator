# frozen_string_literal: true

module Cuda
  module DriverApi
    module PrimaryContextManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuDevicePrimaryCtxGetState, %i[pointer pointer pointer], :CUresult
      attach_function :cuDevicePrimaryCtxRelease, [:pointer], :CUresult
      attach_function :cuDevicePrimaryCtxReset, [:pointer], :CUresult
      attach_function :cuDevicePrimaryCtxRetain, %i[pointer pointer], :CUresult
      attach_function :cuDevicePrimaryCtxSetFlags, %i[pointer uint], :CUresult
    end
  end
end
