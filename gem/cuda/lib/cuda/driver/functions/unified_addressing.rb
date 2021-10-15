# frozen_string_literal: true

module Cuda
  module DriverApi
    module UnifiedAddressing
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuMemAdvise, %i[pointer size_t pointer pointer], :int
      attach_function :cuMemPrefetchAsync, %i[pointer size_t pointer pointer], :int
      attach_function :cuMemRangeGetAttribute, %i[pointer size_t pointer pointer size_t], :int
      attach_function :cuMemRangeGetAttributes, %i[pointer pointer pointer size_t pointer size_t], :int
      attach_function :cuPointerGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuPointerGetAttributes, %i[uint pointer pointer pointer], :int
      attach_function :cuPointerSetAttribute, %i[pointer pointer pointer], :int
    end
  end
end
