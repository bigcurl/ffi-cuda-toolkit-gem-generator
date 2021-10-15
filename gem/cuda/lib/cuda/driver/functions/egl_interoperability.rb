# frozen_string_literal: true

module Cuda
  module DriverApi
    module EglInteroperability
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuEGLStreamConsumerAcquireFrame, %i[pointer pointer pointer uint], :int
      attach_function :cuEGLStreamConsumerConnect, %i[pointer pointer], :int
      attach_function :cuEGLStreamConsumerConnectWithFlags, %i[pointer pointer uint], :int
      attach_function :cuEGLStreamConsumerDisconnect, [:pointer], :int
      attach_function :cuEGLStreamConsumerReleaseFrame, %i[pointer pointer pointer], :int
      attach_function :cuEGLStreamProducerConnect, %i[pointer pointer pointer pointer], :int
      attach_function :cuEGLStreamProducerDisconnect, [:pointer], :int
      attach_function :cuEGLStreamProducerPresentFrame, %i[pointer pointer pointer], :int
      attach_function :cuEGLStreamProducerReturnFrame, %i[pointer pointer pointer], :int
      attach_function :cuEventCreateFromEGLSync, %i[pointer pointer uint], :int
      attach_function :cuGraphicsEGLRegisterImage, %i[pointer pointer uint], :int
      attach_function :cuGraphicsResourceGetMappedEglFrame, %i[pointer pointer uint uint], :int
    end
  end
end
