# frozen_string_literal: true

module Cuda
  module DriverApi
    module ProfilerControlDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuProfilerInitialize, %i[pointer pointer pointer], :int
    end
  end
end
