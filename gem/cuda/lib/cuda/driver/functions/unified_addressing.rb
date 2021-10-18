# frozen_string_literal: true

module Cuda
  module DriverApi
    module UnifiedAddressing
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuMemAdvise, %i[pointer size_t CUmem_advise pointer], :CUresult
      attach_function :cuMemPrefetchAsync, %i[pointer size_t pointer pointer], :CUresult
      attach_function :cuMemRangeGetAttribute, %i[pointer size_t pointer pointer size_t], :CUresult
      attach_function :cuMemRangeGetAttributes, %i[pointer pointer pointer size_t pointer size_t],
                      :CUresult
      attach_function :cuPointerGetAttribute, %i[pointer CUpointer_attribute pointer], :CUresult
      attach_function :cuPointerGetAttributes, %i[uint pointer pointer pointer], :CUresult
      attach_function :cuPointerSetAttribute, %i[pointer CUpointer_attribute pointer], :CUresult
    end
  end
end
