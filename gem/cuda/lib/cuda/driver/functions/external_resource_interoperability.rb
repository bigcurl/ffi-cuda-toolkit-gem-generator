# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExternalResourceInteroperability
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuDestroyExternalMemory, [:pointer], :CUresult
      attach_function :cuDestroyExternalSemaphore, [:pointer], :CUresult
      attach_function :cuExternalMemoryGetMappedBuffer, %i[pointer pointer pointer], :CUresult
      attach_function :cuExternalMemoryGetMappedMipmappedArray, %i[pointer pointer pointer], :CUresult
      attach_function :cuImportExternalMemory, %i[pointer pointer], :CUresult
      attach_function :cuImportExternalSemaphore, %i[pointer pointer], :CUresult
      attach_function :cuSignalExternalSemaphoresAsync, %i[pointer pointer uint pointer], :CUresult
      attach_function :cuWaitExternalSemaphoresAsync, %i[pointer pointer uint pointer], :CUresult
    end
  end
end
