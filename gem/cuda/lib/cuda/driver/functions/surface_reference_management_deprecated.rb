# frozen_string_literal: true

module Cuda
  module DriverApi
    module SurfaceReferenceManagementDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuSurfRefGetArray, %i[pointer pointer], :int
      attach_function :cuSurfRefSetArray, %i[pointer pointer uint], :int
    end
  end
end
