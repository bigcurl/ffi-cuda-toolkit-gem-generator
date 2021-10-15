# frozen_string_literal: true

module Cuda
  module DriverApi
    module OpenglInteroperability
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGLGetDevices, %i[pointer pointer uint pointer], :int
      attach_function :cuGraphicsGLRegisterBuffer, %i[pointer pointer uint], :int
      attach_function :cuWGLGetDevice, %i[pointer pointer], :int
    end
  end
end
