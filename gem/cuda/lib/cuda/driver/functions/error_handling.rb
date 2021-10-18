# frozen_string_literal: true

module Cuda
  module DriverApi
    module ErrorHandling
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGetErrorName, %i[CUresult pointer], :CUresult
      attach_function :cuGetErrorString, %i[CUresult pointer], :CUresult
    end
  end
end
