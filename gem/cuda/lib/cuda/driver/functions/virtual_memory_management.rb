# frozen_string_literal: true

module Cuda
  module DriverApi
    module VirtualMemoryManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuMemAddressFree, %i[pointer size_t], :int
      attach_function :cuMemAddressReserve, %i[pointer size_t size_t pointer ulong_long], :int
      attach_function :cuMemCreate, %i[pointer size_t pointer ulong_long], :int
      attach_function :cuMemExportToShareableHandle, %i[pointer pointer pointer ulong_long], :int
      attach_function :cuMemGetAccess, %i[pointer pointer pointer], :int
      attach_function :cuMemGetAllocationGranularity, %i[pointer pointer pointer], :int
      attach_function :cuMemGetAllocationPropertiesFromHandle, %i[pointer pointer], :int
      attach_function :cuMemImportFromShareableHandle, %i[pointer pointer pointer], :int
      attach_function :cuMemMap, %i[pointer size_t size_t pointer ulong_long], :int
      attach_function :cuMemMapArrayAsync, %i[pointer uint pointer], :int
      attach_function :cuMemRelease, [:pointer], :int
      attach_function :cuMemRetainAllocationHandle, %i[pointer pointer], :int
      attach_function :cuMemSetAccess, %i[pointer size_t pointer size_t], :int
      attach_function :cuMemUnmap, %i[pointer size_t], :int
    end
  end
end
