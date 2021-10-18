# frozen_string_literal: true

module Cuda
  module DriverApi
    module StreamManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuStreamAddCallback, %i[pointer pointer pointer uint], :CUresult
      attach_function :cuStreamAttachMemAsync, %i[pointer pointer size_t uint], :CUresult
      attach_function :cuStreamBeginCapture, %i[pointer CUstreamCaptureMode], :CUresult
      attach_function :cuStreamCopyAttributes, %i[pointer pointer], :CUresult
      attach_function :cuStreamCreate, %i[pointer uint], :CUresult
      attach_function :cuStreamCreateWithPriority, %i[pointer uint int], :CUresult
      attach_function :cuStreamDestroy, [:pointer], :CUresult
      attach_function :cuStreamEndCapture, %i[pointer pointer], :CUresult
      attach_function :cuStreamGetAttribute, %i[pointer CUstreamAttrID pointer], :CUresult
      attach_function :cuStreamGetCaptureInfo, %i[pointer pointer pointer], :CUresult
      attach_function :cuStreamGetCaptureInfo_v2, %i[pointer pointer pointer pointer pointer pointer],
                      :CUresult
      attach_function :cuStreamGetCtx, %i[pointer pointer], :CUresult
      attach_function :cuStreamGetFlags, %i[pointer pointer], :CUresult
      attach_function :cuStreamGetPriority, %i[pointer pointer], :CUresult
      attach_function :cuStreamIsCapturing, %i[pointer pointer], :CUresult
      attach_function :cuStreamQuery, [:pointer], :CUresult
      attach_function :cuStreamSetAttribute, %i[pointer CUstreamAttrID pointer], :CUresult
      attach_function :cuStreamSynchronize, [:pointer], :CUresult
      attach_function :cuStreamUpdateCaptureDependencies, %i[pointer pointer size_t uint], :CUresult
      attach_function :cuStreamWaitEvent, %i[pointer pointer uint], :CUresult
      attach_function :cuThreadExchangeStreamCaptureMode, [:pointer], :CUresult
    end
  end
end
