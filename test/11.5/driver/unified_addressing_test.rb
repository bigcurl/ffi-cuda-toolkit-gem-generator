# frozen_string_literal: true
# Needed
# CUresult cuMemAdvise ( CUdeviceptr devPtr, size_t count, CUmem_advise advice, CUdevice device )
# CUresult cuMemPrefetchAsync ( CUdeviceptr devPtr, size_t count, CUdevice dstDevice, CUstream hStream )
# CUresult cuMemRangeGetAttribute ( void* data, size_t dataSize, CUmem_range_attribute attribute, CUdeviceptr devPtr, size_t count )
# CUresult cuMemRangeGetAttributes ( void** data, size_t* dataSizes, CUmem_range_attribute* attributes, size_t numAttributes, CUdeviceptr devPtr, size_t count )
# CUresult cuPointerGetAttribute ( void* data, CUpointer_attribute attribute, CUdeviceptr ptr )
# CUresult cuPointerGetAttributes ( unsigned int  numAttributes, CUpointer_attribute* attributes, void** data, CUdeviceptr ptr )
# CUresult cuPointerSetAttribute ( const void* value, CUpointer_attribute attribute, CUdeviceptr ptr )

require 'test_helper'

class CudaUnifiedAddressingTest < Minitest::Test
  def setup
    @cu_device = 0
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    # @cu_context = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    value_ptr = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDeviceGetAttribute(pi_ptr, :unified_addressing, @cu_device)

    @isUnifiedAddressingSupported = value_ptr.read_int

    # Context and stream required
    # Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)
  end

end
