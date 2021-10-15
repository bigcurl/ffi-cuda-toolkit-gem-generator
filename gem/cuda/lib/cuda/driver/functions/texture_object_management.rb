# frozen_string_literal: true

module Cuda
  module DriverApi
    module TextureObjectManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuTexObjectCreate, %i[pointer pointer pointer pointer], :int
      attach_function :cuTexObjectDestroy, [:pointer], :int
      attach_function :cuTexObjectGetResourceDesc, %i[pointer pointer], :int
      attach_function :cuTexObjectGetResourceViewDesc, %i[pointer pointer], :int
      attach_function :cuTexObjectGetTextureDesc, %i[pointer pointer], :int
    end
  end
end
