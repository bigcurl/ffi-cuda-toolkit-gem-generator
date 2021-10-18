# frozen_string_literal: true

module Cuda
  module DriverApi
    module OpenglInteroperabilityDeprecated
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuGLCtxCreate, %i[pointer uint pointer], :CUresult
      attach_function :cuGLInit, [], :CUresult
      attach_function :cuGLMapBufferObject, %i[pointer pointer pointer], :CUresult
      attach_function :cuGLMapBufferObjectAsync, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuGLRegisterBufferObject, [:pointer], :CUresult
      attach_function :cuGLSetBufferObjectMapFlags, %i[pointer uint], :CUresult
      attach_function :cuGLUnmapBufferObject, [:pointer], :CUresult
      attach_function :cuGLUnmapBufferObjectAsync, %i[pointer pointer], :CUresult
      attach_function :cuGLUnregisterBufferObject, [:pointer], :CUresult
    end
  end
end
