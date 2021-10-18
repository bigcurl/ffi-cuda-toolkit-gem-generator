# frozen_string_literal: true

module Cuda
  module DriverApi
    module TextureObjectManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuTexObjectCreate, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuTexObjectDestroy, [:pointer], :CUresult
      attach_function :cuTexObjectGetResourceDesc, %i[pointer pointer], :CUresult
      attach_function :cuTexObjectGetResourceViewDesc, %i[pointer pointer], :CUresult
      attach_function :cuTexObjectGetTextureDesc, %i[pointer pointer], :CUresult
    end
  end
end
