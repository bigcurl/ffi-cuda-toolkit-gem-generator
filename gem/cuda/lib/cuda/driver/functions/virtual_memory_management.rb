# frozen_string_literal: true

module Cuda
  module DriverApi
    module VirtualMemoryManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuMemAddressFree, %i[pointer size_t], :CUresult
      attach_function :cuMemAddressReserve, %i[pointer size_t size_t pointer ulong_long], :CUresult
      attach_function :cuMemCreate, %i[pointer size_t pointer ulong_long], :CUresult
      attach_function :cuMemExportToShareableHandle,
                      %i[pointer pointer CUmemAllocationHandleType ulong_long], :CUresult
      attach_function :cuMemGetAccess, %i[pointer pointer pointer], :CUresult
      attach_function :cuMemGetAllocationGranularity, %i[pointer pointer CUmemAllocationGranularity_flags],
                      :CUresult
      attach_function :cuMemGetAllocationPropertiesFromHandle, %i[pointer pointer], :CUresult
      attach_function :cuMemImportFromShareableHandle, %i[pointer pointer CUmemAllocationHandleType], :CUresult
      attach_function :cuMemMap, %i[pointer size_t size_t pointer ulong_long], :CUresult
      attach_function :cuMemMapArrayAsync, %i[pointer uint pointer], :CUresult
      attach_function :cuMemRelease, [:pointer], :CUresult
      attach_function :cuMemRetainAllocationHandle, %i[pointer pointer], :CUresult
      attach_function :cuMemSetAccess, %i[pointer size_t pointer size_t], :CUresult
      attach_function :cuMemUnmap, %i[pointer size_t], :CUresult
    end
  end
end
