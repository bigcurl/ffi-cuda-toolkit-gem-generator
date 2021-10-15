# frozen_string_literal: true

module Cuda
  module DriverApi
    module ProfilerControl
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuProfilerStart, [], :int
      attach_function :cuProfilerStop, [], :int
    end
  end
end
