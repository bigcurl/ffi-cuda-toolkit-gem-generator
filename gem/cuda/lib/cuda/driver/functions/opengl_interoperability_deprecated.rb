# frozen_string_literal: true

module Cuda
  module DriverApi
    module OpenglInteroperabilityDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGLCtxCreate, %i[pointer uint pointer], :int
      attach_function :cuGLInit, [], :int
      attach_function :cuGLMapBufferObject, %i[pointer pointer pointer], :int
      attach_function :cuGLMapBufferObjectAsync, %i[pointer pointer pointer pointer], :int
      attach_function :cuGLRegisterBufferObject, [:pointer], :int
      attach_function :cuGLSetBufferObjectMapFlags, %i[pointer uint], :int
      attach_function :cuGLUnmapBufferObject, [:pointer], :int
      attach_function :cuGLUnmapBufferObjectAsync, %i[pointer pointer], :int
      attach_function :cuGLUnregisterBufferObject, [:pointer], :int
    end
  end
end
