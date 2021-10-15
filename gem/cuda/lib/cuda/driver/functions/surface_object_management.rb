# frozen_string_literal: true

module Cuda
  module DriverApi
    module SurfaceObjectManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuSurfObjectCreate, %i[pointer pointer], :int
      attach_function :cuSurfObjectDestroy, [:pointer], :int
      attach_function :cuSurfObjectGetResourceDesc, %i[pointer pointer], :int
    end
  end
end
