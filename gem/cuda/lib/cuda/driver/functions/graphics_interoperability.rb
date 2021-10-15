# frozen_string_literal: true

module Cuda
  module DriverApi
    module GraphicsInteroperability
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGraphicsMapResources, %i[uint pointer pointer], :int
      attach_function :cuGraphicsResourceGetMappedMipmappedArray, %i[pointer pointer], :int
      attach_function :cuGraphicsResourceGetMappedPointer, %i[pointer pointer pointer], :int
      attach_function :cuGraphicsResourceSetMapFlags, %i[pointer uint], :int
      attach_function :cuGraphicsSubResourceGetMappedArray, %i[pointer pointer uint uint], :int
      attach_function :cuGraphicsUnmapResources, %i[uint pointer pointer], :int
      attach_function :cuGraphicsUnregisterResource, [:pointer], :int
    end
  end
end
