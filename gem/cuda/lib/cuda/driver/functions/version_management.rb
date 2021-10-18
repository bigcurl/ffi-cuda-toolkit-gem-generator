# frozen_string_literal: true

module Cuda
  module DriverApi
    module VersionManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuDriverGetVersion, [:pointer], :CUresult
    end
  end
end
