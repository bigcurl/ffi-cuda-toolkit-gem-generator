# frozen_string_literal: true

module Cuda
  module DriverApi
    module DeviceManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuDeviceGet, %i[pointer int], :int
      attach_function :cuDeviceGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuDeviceGetCount, [:pointer], :int
      attach_function :cuDeviceGetDefaultMemPool, %i[pointer pointer], :int
      attach_function :cuDeviceGetLuid, %i[pointer pointer pointer], :int
      attach_function :cuDeviceGetMemPool, %i[pointer pointer], :int
      attach_function :cuDeviceGetName, %i[pointer int pointer], :int
      attach_function :cuDeviceGetNvSciSyncAttributes, %i[pointer pointer int], :int
      attach_function :cuDeviceGetTexture1DLinearMaxWidth, %i[pointer pointer pointer pointer], :int
      attach_function :cuDeviceGetUuid, %i[pointer pointer], :int
      attach_function :cuDeviceGetUuid_v2, %i[pointer pointer], :int
      attach_function :cuDeviceSetMemPool, %i[pointer pointer], :int
      attach_function :cuDeviceTotalMem, %i[pointer pointer], :int
      attach_function :cuFlushGPUDirectRDMAWrites, %i[pointer pointer], :int
    end
  end
end
