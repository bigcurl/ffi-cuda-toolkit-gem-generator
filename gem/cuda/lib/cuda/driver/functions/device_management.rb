# frozen_string_literal: true

module Cuda
  module DriverApi
    module DeviceManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuDeviceGet, %i[pointer int], :CUresult
      attach_function :cuDeviceGetAttribute, %i[pointer CUdevice_attribute pointer], :CUresult
      attach_function :cuDeviceGetCount, [:pointer], :CUresult
      attach_function :cuDeviceGetDefaultMemPool, %i[pointer pointer], :CUresult
      attach_function :cuDeviceGetLuid, %i[pointer pointer pointer], :CUresult
      attach_function :cuDeviceGetMemPool, %i[pointer pointer], :CUresult
      attach_function :cuDeviceGetName, %i[pointer int pointer], :CUresult
      attach_function :cuDeviceGetNvSciSyncAttributes, %i[pointer pointer int], :CUresult
      attach_function :cuDeviceGetTexture1DLinearMaxWidth, %i[pointer CUarray_format pointer pointer],
                      :CUresult
      attach_function :cuDeviceGetUuid, %i[pointer pointer], :CUresult
      attach_function :cuDeviceGetUuid_v2, %i[pointer pointer], :CUresult
      attach_function :cuDeviceSetMemPool, %i[pointer pointer], :CUresult
      attach_function :cuDeviceTotalMem, %i[pointer pointer], :CUresult
      attach_function :cuFlushGPUDirectRDMAWrites,
                      %i[CUflushGPUDirectRDMAWritesTarget CUflushGPUDirectRDMAWritesScope], :CUresult
    end
  end
end
