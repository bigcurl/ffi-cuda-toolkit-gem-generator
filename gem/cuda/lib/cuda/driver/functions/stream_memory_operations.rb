# frozen_string_literal: true

module Cuda
  module DriverApi
    module StreamMemoryOperations
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuStreamBatchMemOp, %i[pointer uint pointer uint], :CUresult
      attach_function :cuStreamWaitValue32, %i[pointer pointer pointer uint], :CUresult
      attach_function :cuStreamWaitValue64, %i[pointer pointer pointer uint], :CUresult
      attach_function :cuStreamWriteValue32, %i[pointer pointer pointer uint], :CUresult
      attach_function :cuStreamWriteValue64, %i[pointer pointer pointer uint], :CUresult
    end
  end
end
