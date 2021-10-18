# frozen_string_literal: true

module Cuda
  module DriverApi
    module DeviceManagementDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuDeviceComputeCapability, %i[pointer pointer pointer], :CUresult
      attach_function :cuDeviceGetProperties, %i[pointer pointer], :CUresult
    end
  end
end
