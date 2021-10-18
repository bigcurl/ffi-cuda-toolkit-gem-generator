# frozen_string_literal: true

module Cuda
  module DriverApi
    module EglInteroperability
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuEGLStreamConsumerAcquireFrame, %i[pointer pointer pointer uint], :CUresult
      attach_function :cuEGLStreamConsumerConnect, %i[pointer pointer], :CUresult
      attach_function :cuEGLStreamConsumerConnectWithFlags, %i[pointer pointer uint], :CUresult
      attach_function :cuEGLStreamConsumerDisconnect, [:pointer], :CUresult
      attach_function :cuEGLStreamConsumerReleaseFrame, %i[pointer pointer pointer], :CUresult
      attach_function :cuEGLStreamProducerConnect, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuEGLStreamProducerDisconnect, [:pointer], :CUresult
      attach_function :cuEGLStreamProducerPresentFrame, %i[pointer pointer pointer], :CUresult
      attach_function :cuEGLStreamProducerReturnFrame, %i[pointer pointer pointer], :CUresult
      attach_function :cuEventCreateFromEGLSync, %i[pointer pointer uint], :CUresult
      attach_function :cuGraphicsEGLRegisterImage, %i[pointer pointer uint], :CUresult
      attach_function :cuGraphicsResourceGetMappedEglFrame, %i[pointer pointer uint uint], :CUresult
    end
  end
end
