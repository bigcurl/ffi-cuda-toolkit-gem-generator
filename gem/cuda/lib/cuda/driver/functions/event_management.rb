# frozen_string_literal: true

module Cuda
  module DriverApi
    module EventManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuEventCreate, %i[pointer uint], :int
      attach_function :cuEventDestroy, [:pointer], :int
      attach_function :cuEventElapsedTime, %i[pointer pointer pointer], :int
      attach_function :cuEventQuery, [:pointer], :int
      attach_function :cuEventRecord, %i[pointer pointer], :int
      attach_function :cuEventRecordWithFlags, %i[pointer pointer uint], :int
      attach_function :cuEventSynchronize, [:pointer], :int
    end
  end
end
