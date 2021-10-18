# frozen_string_literal: true

module Cuda
  module DriverApi
    module GraphicsInteroperability
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuGraphicsMapResources, %i[uint pointer pointer], :CUresult
      attach_function :cuGraphicsResourceGetMappedMipmappedArray, %i[pointer pointer], :CUresult
      attach_function :cuGraphicsResourceGetMappedPointer, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphicsResourceSetMapFlags, %i[pointer uint], :CUresult
      attach_function :cuGraphicsSubResourceGetMappedArray, %i[pointer pointer uint uint], :CUresult
      attach_function :cuGraphicsUnmapResources, %i[uint pointer pointer], :CUresult
      attach_function :cuGraphicsUnregisterResource, [:pointer], :CUresult
    end
  end
end
