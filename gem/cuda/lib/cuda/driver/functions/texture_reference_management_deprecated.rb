# frozen_string_literal: true

module Cuda
  module DriverApi
    module TextureReferenceManagementDeprecated
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuTexRefCreate, [:pointer], :CUresult
      attach_function :cuTexRefDestroy, [:pointer], :CUresult
      attach_function :cuTexRefGetAddress, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetAddressMode, %i[pointer pointer int], :CUresult
      attach_function :cuTexRefGetArray, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetBorderColor, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetFilterMode, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetFlags, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetFormat, %i[pointer pointer pointer], :CUresult
      attach_function :cuTexRefGetMaxAnisotropy, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetMipmapFilterMode, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetMipmapLevelBias, %i[pointer pointer], :CUresult
      attach_function :cuTexRefGetMipmapLevelClamp, %i[pointer pointer pointer], :CUresult
      attach_function :cuTexRefGetMipmappedArray, %i[pointer pointer], :CUresult
      attach_function :cuTexRefSetAddress, %i[pointer pointer pointer size_t], :CUresult
      attach_function :cuTexRefSetAddress2D, %i[pointer pointer pointer size_t], :CUresult
      attach_function :cuTexRefSetAddressMode, %i[pointer int CUaddress_mode], :CUresult
      attach_function :cuTexRefSetArray, %i[pointer pointer uint], :CUresult
      attach_function :cuTexRefSetBorderColor, %i[pointer pointer], :CUresult
      attach_function :cuTexRefSetFilterMode, %i[pointer CUfilter_mode], :CUresult
      attach_function :cuTexRefSetFlags, %i[pointer uint], :CUresult
      attach_function :cuTexRefSetFormat, %i[pointer CUarray_format int], :CUresult
      attach_function :cuTexRefSetMaxAnisotropy, %i[pointer uint], :CUresult
      attach_function :cuTexRefSetMipmapFilterMode, %i[pointer CUfilter_mode], :CUresult
      attach_function :cuTexRefSetMipmapLevelBias, %i[pointer float], :CUresult
      attach_function :cuTexRefSetMipmapLevelClamp, %i[pointer float float], :CUresult
      attach_function :cuTexRefSetMipmappedArray, %i[pointer pointer uint], :CUresult
    end
  end
end
