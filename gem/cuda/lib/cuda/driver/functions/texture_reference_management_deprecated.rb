# frozen_string_literal: true

module Cuda
  module DriverApi
    module TextureReferenceManagementDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuTexRefCreate, [:pointer], :int
      attach_function :cuTexRefDestroy, [:pointer], :int
      attach_function :cuTexRefGetAddress, %i[pointer pointer], :int
      attach_function :cuTexRefGetAddressMode, %i[pointer pointer int], :int
      attach_function :cuTexRefGetArray, %i[pointer pointer], :int
      attach_function :cuTexRefGetBorderColor, %i[pointer pointer], :int
      attach_function :cuTexRefGetFilterMode, %i[pointer pointer], :int
      attach_function :cuTexRefGetFlags, %i[pointer pointer], :int
      attach_function :cuTexRefGetFormat, %i[pointer pointer pointer], :int
      attach_function :cuTexRefGetMaxAnisotropy, %i[pointer pointer], :int
      attach_function :cuTexRefGetMipmapFilterMode, %i[pointer pointer], :int
      attach_function :cuTexRefGetMipmapLevelBias, %i[pointer pointer], :int
      attach_function :cuTexRefGetMipmapLevelClamp, %i[pointer pointer pointer], :int
      attach_function :cuTexRefGetMipmappedArray, %i[pointer pointer], :int
      attach_function :cuTexRefSetAddress, %i[pointer pointer pointer size_t], :int
      attach_function :cuTexRefSetAddress2D, %i[pointer pointer pointer size_t], :int
      attach_function :cuTexRefSetAddressMode, %i[pointer int pointer], :int
      attach_function :cuTexRefSetArray, %i[pointer pointer uint], :int
      attach_function :cuTexRefSetBorderColor, %i[pointer pointer], :int
      attach_function :cuTexRefSetFilterMode, %i[pointer pointer], :int
      attach_function :cuTexRefSetFlags, %i[pointer uint], :int
      attach_function :cuTexRefSetFormat, %i[pointer pointer int], :int
      attach_function :cuTexRefSetMaxAnisotropy, %i[pointer uint], :int
      attach_function :cuTexRefSetMipmapFilterMode, %i[pointer pointer], :int
      attach_function :cuTexRefSetMipmapLevelBias, %i[pointer float], :int
      attach_function :cuTexRefSetMipmapLevelClamp, %i[pointer float float], :int
      attach_function :cuTexRefSetMipmappedArray, %i[pointer pointer uint], :int
    end
  end
end
