# frozen_string_literal: true

module Cuda
  module DriverApi
    module EventManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuEventCreate, %i[pointer uint], :CUresult
      attach_function :cuEventDestroy, [:pointer], :CUresult
      attach_function :cuEventElapsedTime, %i[pointer pointer pointer], :CUresult
      attach_function :cuEventQuery, [:pointer], :CUresult
      attach_function :cuEventRecord, %i[pointer pointer], :CUresult
      attach_function :cuEventRecordWithFlags, %i[pointer pointer uint], :CUresult
      attach_function :cuEventSynchronize, [:pointer], :CUresult
    end
  end
end
