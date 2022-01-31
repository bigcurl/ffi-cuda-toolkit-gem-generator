# frozen_string_literal: true
# Needed
# CUresult cuMemAllocAsync ( CUdeviceptr* dptr, size_t bytesize, CUstream hStream )
# CUresult cuMemAllocFromPoolAsync ( CUdeviceptr* dptr, size_t bytesize, CUmemoryPool pool, CUstream hStream )
# CUresult cuMemFreeAsync ( CUdeviceptr dptr, CUstream hStream )
# CUresult cuMemPoolCreate ( CUmemoryPool* pool, const CUmemPoolProps* poolProps )
# CUresult cuMemPoolDestroy ( CUmemoryPool pool )
# CUresult cuMemPoolExportPointer ( CUmemPoolPtrExportData* shareData_out, CUdeviceptr ptr )
# CUresult cuMemPoolExportToShareableHandle ( void* handle_out, CUmemoryPool pool, CUmemAllocationHandleType handleType, unsigned long long flags )
# CUresult cuMemPoolGetAccess ( CUmemAccess_flags* flags, CUmemoryPool memPool, CUmemLocation* location )
# CUresult cuMemPoolGetAttribute ( CUmemoryPool pool, CUmemPool_attribute attr, void* value )
# CUresult cuMemPoolImportFromShareableHandle ( CUmemoryPool* pool_out, void* handle, CUmemAllocationHandleType handleType, unsigned long long flags )
# CUresult cuMemPoolImportPointer ( CUdeviceptr* ptr_out, CUmemoryPool pool, CUmemPoolPtrExportData* shareData )
# CUresult cuMemPoolSetAccess ( CUmemoryPool pool, const CUmemAccessDesc* map, size_t count )
# CUresult cuMemPoolSetAttribute ( CUmemoryPool pool, CUmemPool_attribute attr, void* value )
# CUresult cuMemPoolTrimTo ( CUmemoryPool pool, size_t minBytesToKeep )

require 'test_helper'

class CudaStreamOrderedMemoryAllocatorTest < Minitest::Test
  def setup
    @cu_device = 0
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    @cu_context = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    # Context required for
    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)

    @cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(@cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
  end

  # TODO: Check whether it is supported or not
  def test_cu_mem_alloc_async
    assert_equal(:success, Cuda::DriverApi::cuMemAllocAsync(@device_pointer, 4, @cu_stream.read_pointer))
  end

  # FIXME: Failed
  def test_cu_mem_alloc_from_pool_async
    pool = FFI::MemoryPointer.new(:pointer, 4)
    assert_equal(:success, Cuda::DriverApi::cuMemAllocFromPoolAsync(@device_pointer, 4, pool.read_pointer, @cu_stream.read_pointer))
  end
end
