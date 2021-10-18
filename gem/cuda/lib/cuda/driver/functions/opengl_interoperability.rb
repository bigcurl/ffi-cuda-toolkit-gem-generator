# frozen_string_literal: true

module Cuda
  module DriverApi
    module OpenglInteroperability
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuGLGetDevices, %i[pointer pointer uint pointer], :CUresult
      attach_function :cuGraphicsGLRegisterBuffer, %i[pointer pointer uint], :CUresult
      attach_function :cuWGLGetDevice, %i[pointer pointer], :CUresult
    end
  end
end
