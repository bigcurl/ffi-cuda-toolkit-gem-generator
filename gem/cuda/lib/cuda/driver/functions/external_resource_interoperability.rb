# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExternalResourceInteroperability
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuDestroyExternalMemory, [:pointer], :int
      attach_function :cuDestroyExternalSemaphore, [:pointer], :int
      attach_function :cuExternalMemoryGetMappedBuffer, %i[pointer pointer pointer], :int
      attach_function :cuExternalMemoryGetMappedMipmappedArray, %i[pointer pointer pointer], :int
      attach_function :cuImportExternalMemory, %i[pointer pointer], :int
      attach_function :cuImportExternalSemaphore, %i[pointer pointer], :int
      attach_function :cuSignalExternalSemaphoresAsync, %i[pointer pointer uint pointer], :int
      attach_function :cuWaitExternalSemaphoresAsync, %i[pointer pointer uint pointer], :int
    end
  end
end
