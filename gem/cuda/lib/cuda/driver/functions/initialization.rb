# frozen_string_literal: true

module Cuda
  module DriverApi
    module Initialization
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuInit, [:uint], :CUresult
    end
  end
end
