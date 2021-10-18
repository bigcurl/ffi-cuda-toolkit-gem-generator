# frozen_string_literal: true

module Cuda
  module DriverApi
    module MemoryManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuArray3DCreate, %i[pointer pointer], :CUresult
      attach_function :cuArray3DGetDescriptor, %i[pointer pointer], :CUresult
      attach_function :cuArrayCreate, %i[pointer pointer], :CUresult
      attach_function :cuArrayDestroy, [:pointer], :CUresult
      attach_function :cuArrayGetDescriptor, %i[pointer pointer], :CUresult
      attach_function :cuArrayGetPlane, %i[pointer pointer uint], :CUresult
      attach_function :cuArrayGetSparseProperties, %i[pointer pointer], :CUresult
      attach_function :cuDeviceGetByPCIBusId, %i[pointer pointer], :CUresult
      attach_function :cuDeviceGetPCIBusId, %i[pointer int pointer], :CUresult
      attach_function :cuIpcCloseMemHandle, [:pointer], :CUresult
      attach_function :cuIpcGetEventHandle, %i[pointer pointer], :CUresult
      attach_function :cuIpcGetMemHandle, %i[pointer pointer], :CUresult
      attach_function :cuIpcOpenEventHandle, %i[pointer pointer], :CUresult
      attach_function :cuIpcOpenMemHandle, %i[pointer pointer uint], :CUresult
      attach_function :cuMemAlloc, %i[pointer size_t], :CUresult
      attach_function :cuMemAllocHost, %i[pointer size_t], :CUresult
      attach_function :cuMemAllocManaged, %i[pointer size_t uint], :CUresult
      attach_function :cuMemAllocPitch, %i[pointer pointer size_t size_t uint], :CUresult
      attach_function :cuMemFree, [:pointer], :CUresult
      attach_function :cuMemFreeHost, [:pointer], :CUresult
      attach_function :cuMemGetAddressRange, %i[pointer pointer pointer], :CUresult
      attach_function :cuMemGetInfo, %i[pointer pointer], :CUresult
      attach_function :cuMemHostAlloc, %i[pointer size_t uint], :CUresult
      attach_function :cuMemHostGetDevicePointer, %i[pointer pointer uint], :CUresult
      attach_function :cuMemHostGetFlags, %i[pointer pointer], :CUresult
      attach_function :cuMemHostRegister, %i[pointer size_t uint], :CUresult
      attach_function :cuMemHostUnregister, [:pointer], :CUresult
      attach_function :cuMemcpy, %i[pointer pointer size_t], :CUresult
      attach_function :cuMemcpy2D, [:pointer], :CUresult
      attach_function :cuMemcpy2DAsync, %i[pointer pointer], :CUresult
      attach_function :cuMemcpy2DUnaligned, [:pointer], :CUresult
      attach_function :cuMemcpy3D, [:pointer], :CUresult
      attach_function :cuMemcpy3DAsync, %i[pointer pointer], :CUresult
      attach_function :cuMemcpy3DPeer, [:pointer], :CUresult
      attach_function :cuMemcpy3DPeerAsync, %i[pointer pointer], :CUresult
      attach_function :cuMemcpyAsync, %i[pointer pointer size_t pointer], :CUresult
      attach_function :cuMemcpyAtoA, %i[pointer size_t pointer size_t size_t], :CUresult
      attach_function :cuMemcpyAtoD, %i[pointer pointer size_t size_t], :CUresult
      attach_function :cuMemcpyAtoH, %i[pointer pointer size_t size_t], :CUresult
      attach_function :cuMemcpyAtoHAsync, %i[pointer pointer size_t size_t pointer], :CUresult
      attach_function :cuMemcpyDtoA, %i[pointer size_t pointer size_t], :CUresult
      attach_function :cuMemcpyDtoD, %i[pointer pointer size_t], :CUresult
      attach_function :cuMemcpyDtoDAsync, %i[pointer pointer size_t pointer], :CUresult
      attach_function :cuMemcpyDtoH, %i[pointer pointer size_t], :CUresult
      attach_function :cuMemcpyDtoHAsync, %i[pointer pointer size_t pointer], :CUresult
      attach_function :cuMemcpyHtoA, %i[pointer size_t pointer size_t], :CUresult
      attach_function :cuMemcpyHtoAAsync, %i[pointer size_t pointer size_t pointer], :CUresult
      attach_function :cuMemcpyHtoD, %i[pointer pointer size_t], :CUresult
      attach_function :cuMemcpyHtoDAsync, %i[pointer pointer size_t pointer], :CUresult
      attach_function :cuMemcpyPeer, %i[pointer pointer pointer pointer size_t], :CUresult
      attach_function :cuMemcpyPeerAsync, %i[pointer pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuMemsetD16, %i[pointer ushort size_t], :CUresult
      attach_function :cuMemsetD16Async, %i[pointer ushort size_t pointer], :CUresult
      attach_function :cuMemsetD2D16, %i[pointer size_t ushort size_t size_t], :CUresult
      attach_function :cuMemsetD2D16Async, %i[pointer size_t ushort size_t size_t pointer], :CUresult
      attach_function :cuMemsetD2D32, %i[pointer size_t uint size_t size_t], :CUresult
      attach_function :cuMemsetD2D32Async, %i[pointer size_t uint size_t size_t pointer], :CUresult
      attach_function :cuMemsetD2D8, %i[pointer size_t uchar size_t size_t], :CUresult
      attach_function :cuMemsetD2D8Async, %i[pointer size_t uchar size_t size_t pointer], :CUresult
      attach_function :cuMemsetD32, %i[pointer uint size_t], :CUresult
      attach_function :cuMemsetD32Async, %i[pointer uint size_t pointer], :CUresult
      attach_function :cuMemsetD8, %i[pointer uchar size_t], :CUresult
      attach_function :cuMemsetD8Async, %i[pointer uchar size_t pointer], :CUresult
      attach_function :cuMipmappedArrayCreate, %i[pointer pointer uint], :CUresult
      attach_function :cuMipmappedArrayDestroy, [:pointer], :CUresult
      attach_function :cuMipmappedArrayGetLevel, %i[pointer pointer uint], :CUresult
      attach_function :cuMipmappedArrayGetSparseProperties, %i[pointer pointer], :CUresult
    end
  end
end
