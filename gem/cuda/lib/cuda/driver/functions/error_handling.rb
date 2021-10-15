# frozen_string_literal: true

module Cuda
  module DriverApi
    module ErrorHandling
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGetErrorName, %i[int pointer], :int
      attach_function :cuGetErrorString, %i[int pointer], :int
    end
  end
end