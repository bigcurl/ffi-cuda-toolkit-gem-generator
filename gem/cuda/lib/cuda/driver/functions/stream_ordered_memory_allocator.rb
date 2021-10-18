# frozen_string_literal: true

module Cuda
  module DriverApi
    module StreamOrderedMemoryAllocator
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuMemAllocAsync, %i[pointer size_t pointer], :CUresult
      attach_function :cuMemAllocFromPoolAsync, %i[pointer size_t pointer pointer], :CUresult
      attach_function :cuMemFreeAsync, %i[pointer pointer], :CUresult
      attach_function :cuMemPoolCreate, %i[pointer pointer], :CUresult
      attach_function :cuMemPoolDestroy, [:pointer], :CUresult
      attach_function :cuMemPoolExportPointer, %i[pointer pointer], :CUresult
      attach_function :cuMemPoolExportToShareableHandle,
                      %i[pointer pointer CUmemAllocationHandleType ulong_long], :CUresult
      attach_function :cuMemPoolGetAccess, %i[pointer pointer pointer], :CUresult
      attach_function :cuMemPoolGetAttribute, %i[pointer CUmemPool_attribute pointer], :CUresult
      attach_function :cuMemPoolImportFromShareableHandle,
                      %i[pointer pointer CUmemAllocationHandleType ulong_long], :CUresult
      attach_function :cuMemPoolImportPointer, %i[pointer pointer pointer], :CUresult
      attach_function :cuMemPoolSetAccess, %i[pointer pointer size_t], :CUresult
      attach_function :cuMemPoolSetAttribute, %i[pointer CUmemPool_attribute pointer], :CUresult
      attach_function :cuMemPoolTrimTo, %i[pointer size_t], :CUresult
    end
  end
end
