# frozen_string_literal: true

module Cuda
  module DriverApi
    module StreamOrderedMemoryAllocator
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuMemAllocAsync, %i[pointer size_t pointer], :int
      attach_function :cuMemAllocFromPoolAsync, %i[pointer size_t pointer pointer], :int
      attach_function :cuMemFreeAsync, %i[pointer pointer], :int
      attach_function :cuMemPoolCreate, %i[pointer pointer], :int
      attach_function :cuMemPoolDestroy, [:pointer], :int
      attach_function :cuMemPoolExportPointer, %i[pointer pointer], :int
      attach_function :cuMemPoolExportToShareableHandle, %i[pointer pointer pointer ulong_long], :int
      attach_function :cuMemPoolGetAccess, %i[pointer pointer pointer], :int
      attach_function :cuMemPoolGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuMemPoolImportFromShareableHandle, %i[pointer pointer pointer ulong_long], :int
      attach_function :cuMemPoolImportPointer, %i[pointer pointer pointer], :int
      attach_function :cuMemPoolSetAccess, %i[pointer pointer size_t], :int
      attach_function :cuMemPoolSetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuMemPoolTrimTo, %i[pointer size_t], :int
    end
  end
end
