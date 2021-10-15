# frozen_string_literal: true

module Cuda
  module DriverApi
    module StreamManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuStreamAddCallback, %i[pointer pointer pointer uint], :int
      attach_function :cuStreamAttachMemAsync, %i[pointer pointer size_t uint], :int
      attach_function :cuStreamBeginCapture, %i[pointer pointer], :int
      attach_function :cuStreamCopyAttributes, %i[pointer pointer], :int
      attach_function :cuStreamCreate, %i[pointer uint], :int
      attach_function :cuStreamCreateWithPriority, %i[pointer uint int], :int
      attach_function :cuStreamDestroy, [:pointer], :int
      attach_function :cuStreamEndCapture, %i[pointer pointer], :int
      attach_function :cuStreamGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuStreamGetCaptureInfo, %i[pointer pointer pointer], :int
      attach_function :cuStreamGetCaptureInfo_v2, %i[pointer pointer pointer pointer pointer pointer],
                      :int
      attach_function :cuStreamGetCtx, %i[pointer pointer], :int
      attach_function :cuStreamGetFlags, %i[pointer pointer], :int
      attach_function :cuStreamGetPriority, %i[pointer pointer], :int
      attach_function :cuStreamIsCapturing, %i[pointer pointer], :int
      attach_function :cuStreamQuery, [:pointer], :int
      attach_function :cuStreamSetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuStreamSynchronize, [:pointer], :int
      attach_function :cuStreamUpdateCaptureDependencies, %i[pointer pointer size_t uint], :int
      attach_function :cuStreamWaitEvent, %i[pointer pointer uint], :int
      attach_function :cuThreadExchangeStreamCaptureMode, [:pointer], :int
    end
  end
end
