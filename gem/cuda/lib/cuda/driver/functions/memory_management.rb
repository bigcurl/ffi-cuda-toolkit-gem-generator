# frozen_string_literal: true

module Cuda
  module DriverApi
    module MemoryManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuArray3DCreate, %i[pointer pointer], :int
      attach_function :cuArray3DGetDescriptor, %i[pointer pointer], :int
      attach_function :cuArrayCreate, %i[pointer pointer], :int
      attach_function :cuArrayDestroy, [:pointer], :int
      attach_function :cuArrayGetDescriptor, %i[pointer pointer], :int
      attach_function :cuArrayGetPlane, %i[pointer pointer uint], :int
      attach_function :cuArrayGetSparseProperties, %i[pointer pointer], :int
      attach_function :cuDeviceGetByPCIBusId, %i[pointer pointer], :int
      attach_function :cuDeviceGetPCIBusId, %i[pointer int pointer], :int
      attach_function :cuIpcCloseMemHandle, [:pointer], :int
      attach_function :cuIpcGetEventHandle, %i[pointer pointer], :int
      attach_function :cuIpcGetMemHandle, %i[pointer pointer], :int
      attach_function :cuIpcOpenEventHandle, %i[pointer pointer], :int
      attach_function :cuIpcOpenMemHandle, %i[pointer pointer uint], :int
      attach_function :cuMemAlloc, %i[pointer size_t], :int
      attach_function :cuMemAllocHost, %i[pointer size_t], :int
      attach_function :cuMemAllocManaged, %i[pointer size_t uint], :int
      attach_function :cuMemAllocPitch, %i[pointer pointer size_t size_t uint], :int
      attach_function :cuMemFree, [:pointer], :int
      attach_function :cuMemFreeHost, [:pointer], :int
      attach_function :cuMemGetAddressRange, %i[pointer pointer pointer], :int
      attach_function :cuMemGetInfo, %i[pointer pointer], :int
      attach_function :cuMemHostAlloc, %i[pointer size_t uint], :int
      attach_function :cuMemHostGetDevicePointer, %i[pointer pointer uint], :int
      attach_function :cuMemHostGetFlags, %i[pointer pointer], :int
      attach_function :cuMemHostRegister, %i[pointer size_t uint], :int
      attach_function :cuMemHostUnregister, [:pointer], :int
      attach_function :cuMemcpy, %i[pointer pointer size_t], :int
      attach_function :cuMemcpy2D, [:pointer], :int
      attach_function :cuMemcpy2DAsync, %i[pointer pointer], :int
      attach_function :cuMemcpy2DUnaligned, [:pointer], :int
      attach_function :cuMemcpy3D, [:pointer], :int
      attach_function :cuMemcpy3DAsync, %i[pointer pointer], :int
      attach_function :cuMemcpy3DPeer, [:pointer], :int
      attach_function :cuMemcpy3DPeerAsync, %i[pointer pointer], :int
      attach_function :cuMemcpyAsync, %i[pointer pointer size_t pointer], :int
      attach_function :cuMemcpyAtoA, %i[pointer size_t pointer size_t size_t], :int
      attach_function :cuMemcpyAtoD, %i[pointer pointer size_t size_t], :int
      attach_function :cuMemcpyAtoH, %i[pointer pointer size_t size_t], :int
      attach_function :cuMemcpyAtoHAsync, %i[pointer pointer size_t size_t pointer], :int
      attach_function :cuMemcpyDtoA, %i[pointer size_t pointer size_t], :int
      attach_function :cuMemcpyDtoD, %i[pointer pointer size_t], :int
      attach_function :cuMemcpyDtoDAsync, %i[pointer pointer size_t pointer], :int
      attach_function :cuMemcpyDtoH, %i[pointer pointer size_t], :int
      attach_function :cuMemcpyDtoHAsync, %i[pointer pointer size_t pointer], :int
      attach_function :cuMemcpyHtoA, %i[pointer size_t pointer size_t], :int
      attach_function :cuMemcpyHtoAAsync, %i[pointer size_t pointer size_t pointer], :int
      attach_function :cuMemcpyHtoD, %i[pointer pointer size_t], :int
      attach_function :cuMemcpyHtoDAsync, %i[pointer pointer size_t pointer], :int
      attach_function :cuMemcpyPeer, %i[pointer pointer pointer pointer size_t], :int
      attach_function :cuMemcpyPeerAsync, %i[pointer pointer pointer pointer size_t pointer], :int
      attach_function :cuMemsetD16, %i[pointer ushort size_t], :int
      attach_function :cuMemsetD16Async, %i[pointer ushort size_t pointer], :int
      attach_function :cuMemsetD2D16, %i[pointer size_t ushort size_t size_t], :int
      attach_function :cuMemsetD2D16Async, %i[pointer size_t ushort size_t size_t pointer], :int
      attach_function :cuMemsetD2D32, %i[pointer size_t uint size_t size_t], :int
      attach_function :cuMemsetD2D32Async, %i[pointer size_t uint size_t size_t pointer], :int
      attach_function :cuMemsetD2D8, %i[pointer size_t uchar size_t size_t], :int
      attach_function :cuMemsetD2D8Async, %i[pointer size_t uchar size_t size_t pointer], :int
      attach_function :cuMemsetD32, %i[pointer uint size_t], :int
      attach_function :cuMemsetD32Async, %i[pointer uint size_t pointer], :int
      attach_function :cuMemsetD8, %i[pointer uchar size_t], :int
      attach_function :cuMemsetD8Async, %i[pointer uchar size_t pointer], :int
      attach_function :cuMipmappedArrayCreate, %i[pointer pointer uint], :int
      attach_function :cuMipmappedArrayDestroy, [:pointer], :int
      attach_function :cuMipmappedArrayGetLevel, %i[pointer pointer uint], :int
      attach_function :cuMipmappedArrayGetSparseProperties, %i[pointer pointer], :int
    end
  end
end
