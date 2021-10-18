# frozen_string_literal: true

module Cuda
  module DriverApi
    module SurfaceObjectManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuSurfObjectCreate, %i[pointer pointer], :CUresult
      attach_function :cuSurfObjectDestroy, [:pointer], :CUresult
      attach_function :cuSurfObjectGetResourceDesc, %i[pointer pointer], :CUresult
    end
  end
end
