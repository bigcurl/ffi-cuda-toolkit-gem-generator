# frozen_string_literal: true

require 'test_helper'

# Needed
# CUresult cuMemAlloc ( CUdeviceptr* dptr, size_t bytesize )
# CUresult cuMemAllocHost ( void** pp, size_t bytesize )
# CUresult cuMemAllocManaged ( CUdeviceptr* dptr, size_t bytesize, unsigned int  flags )
# CUresult cuMemAllocPitch ( CUdeviceptr* dptr, size_t* pPitch, size_t WidthInBytes, size_t Height, unsigned int  ElementSizeBytes )
# CUresult cuMemFree ( CUdeviceptr dptr )
# CUresult cuMemFreeHost ( void* p )
# CUresult cuMemGetAddressRange ( CUdeviceptr* pbase, size_t* psize, CUdeviceptr dptr )
# CUresult cuMemGetInfo ( size_t* free, size_t* total )
# CUresult cuMemHostAlloc ( void** pp, size_t bytesize, unsigned int  Flags )
# CUresult cuMemHostGetDevicePointer ( CUdeviceptr* pdptr, void* p, unsigned int  Flags )
# CUresult cuMemHostGetFlags ( unsigned int* pFlags, void* p )
# CUresult cuMemHostRegister ( void* p, size_t bytesize, unsigned int  Flags )
# CUresult cuMemHostUnregister ( void* p )
# CUresult cuMemcpy ( CUdeviceptr dst, CUdeviceptr src, size_t ByteCount )
# CUresult cuMemcpyAsync ( CUdeviceptr dst, CUdeviceptr src, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyDtoH ( void* dstHost, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoHAsync ( void* dstHost, CUdeviceptr srcDevice, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyHtoD ( CUdeviceptr dstDevice, const void* srcHost, size_t ByteCount )
# CUresult cuMemcpyHtoDAsync ( CUdeviceptr dstDevice, const void* srcHost, size_t ByteCount, CUstream hStream )

# Not needed
# CUresult cuArray3DCreate ( CUarray* pHandle, const CUDA_ARRAY3D_DESCRIPTOR* pAllocateArray )
# CUresult cuArray3DGetDescriptor ( CUDA_ARRAY3D_DESCRIPTOR* pArrayDescriptor, CUarray hArray )
# CUresult cuArrayCreate ( CUarray* pHandle, const CUDA_ARRAY_DESCRIPTOR* pAllocateArray )
# CUresult cuArrayDestroy ( CUarray hArray )
# CUresult cuArrayGetDescriptor ( CUDA_ARRAY_DESCRIPTOR* pArrayDescriptor, CUarray hArray )
# CUresult cuArrayGetPlane ( CUarray* pPlaneArray, CUarray hArray, unsigned int  planeIdx )
# CUresult cuArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUarray array )
# CUresult cuDeviceGetByPCIBusId ( CUdevice* dev, const char* pciBusId )
# CUresult cuDeviceGetPCIBusId ( char* pciBusId, int  len, CUdevice dev )
# CUresult cuIpcCloseMemHandle ( CUdeviceptr dptr )
# CUresult cuIpcGetEventHandle ( CUipcEventHandle* pHandle, CUevent event )
# CUresult cuIpcGetMemHandle ( CUipcMemHandle* pHandle, CUdeviceptr dptr )
# CUresult cuIpcOpenEventHandle ( CUevent* phEvent, CUipcEventHandle handle )
# CUresult cuIpcOpenMemHandle ( CUdeviceptr* pdptr, CUipcMemHandle handle, unsigned int  Flags )
# CUresult cuMemcpy2D ( const CUDA_MEMCPY2D* pCopy )
# CUresult cuMemcpy2DAsync ( const CUDA_MEMCPY2D* pCopy, CUstream hStream )
# CUresult cuMemcpy2DUnaligned ( const CUDA_MEMCPY2D* pCopy )
# CUresult cuMemcpy3D ( const CUDA_MEMCPY3D* pCopy )
# CUresult cuMemcpy3DAsync ( const CUDA_MEMCPY3D* pCopy, CUstream hStream )
# CUresult cuMemcpy3DPeer ( const CUDA_MEMCPY3D_PEER* pCopy )
# CUresult cuMemcpy3DPeerAsync ( const CUDA_MEMCPY3D_PEER* pCopy, CUstream hStream )
# CUresult cuMemsetD16 ( CUdeviceptr dstDevice, unsigned short us, size_t N )
# CUresult cuMemsetD16Async ( CUdeviceptr dstDevice, unsigned short us, size_t N, CUstream hStream )
# CUresult cuMemsetD2D16 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned short us, size_t Width, size_t Height )
# CUresult cuMemsetD2D16Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned short us, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD2D32 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned int  ui, size_t Width, size_t Height )
# CUresult cuMemsetD2D32Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned int  ui, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD2D8 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned char  uc, size_t Width, size_t Height )
# CUresult cuMemsetD2D8Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned char  uc, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD32 ( CUdeviceptr dstDevice, unsigned int  ui, size_t N )
# CUresult cuMemsetD32Async ( CUdeviceptr dstDevice, unsigned int  ui, size_t N, CUstream hStream )
# CUresult cuMemsetD8 ( CUdeviceptr dstDevice, unsigned char  uc, size_t N )
# CUresult cuMemsetD8Async ( CUdeviceptr dstDevice, unsigned char  uc, size_t N, CUstream hStream )
# CUresult cuMipmappedArrayCreate ( CUmipmappedArray* pHandle, const CUDA_ARRAY3D_DESCRIPTOR* pMipmappedArrayDesc, unsigned int  numMipmapLevels )
# CUresult cuMipmappedArrayDestroy ( CUmipmappedArray hMipmappedArray )
# CUresult cuMipmappedArrayGetLevel ( CUarray* pLevelArray, CUmipmappedArray hMipmappedArray, unsigned int  level )
# CUresult cuMipmappedArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUmipmappedArray mipmap )
# CUresult cuMemcpyAtoA ( CUarray dstArray, size_t dstOffset, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoD ( CUdeviceptr dstDevice, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoH ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoHAsync ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyDtoA ( CUarray dstArray, size_t dstOffset, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoD ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoDAsync ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyHtoA ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount )
# CUresult cuMemcpyHtoAAsync ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyPeer ( CUdeviceptr dstDevice, CUcontext dstContext, CUdeviceptr srcDevice, CUcontext srcContext, size_t ByteCount )
# CUresult cuMemcpyPeerAsync ( CUdeviceptr dstDevice, CUcontext dstContext, CUdeviceptr srcDevice, CUcontext srcContext, size_t ByteCount, CUstream hStream )

# Problems
# CUresult cuArray3DGetDescriptor ( CUDA_ARRAY3D_DESCRIPTOR* pArrayDescriptor, CUarray hArray )
# CUresult cuArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUarray array )
# CUresult cuMipmappedArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUmipmappedArray mipmap )

# Not done
# CUresult cuIpcCloseMemHandle ( CUdeviceptr dptr )
# CUresult cuIpcGetEventHandle ( CUipcEventHandle* pHandle, CUevent event )
# CUresult cuIpcGetMemHandle ( CUipcMemHandle* pHandle, CUdeviceptr dptr )
# CUresult cuIpcOpenEventHandle ( CUevent* phEvent, CUipcEventHandle handle )
# CUresult cuIpcOpenMemHandle ( CUdeviceptr* pdptr, CUipcMemHandle handle, unsigned int  Flags )

# CUresult cuMemcpyAtoA ( CUarray dstArray, size_t dstOffset, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoD ( CUdeviceptr dstDevice, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoH ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoHAsync ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyDtoA ( CUarray dstArray, size_t dstOffset, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoD ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoDAsync ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyHtoA ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount )
# CUresult cuMemcpyHtoAAsync ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyPeer ( CUdeviceptr dstDevice, CUcontext dstContext, CUdeviceptr srcDevice, CUcontext srcContext, size_t ByteCount )
# CUresult cuMemcpyPeerAsync ( CUdeviceptr dstDevice, CUcontext dstContext, CUdeviceptr srcDevice, CUcontext srcContext, size_t ByteCount, CUstream hStream )
# CUresult cuMemsetD16 ( CUdeviceptr dstDevice, unsigned short us, size_t N )
# CUresult cuMemsetD16Async ( CUdeviceptr dstDevice, unsigned short us, size_t N, CUstream hStream )
# CUresult cuMemsetD2D16 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned short us, size_t Width, size_t Height )
# CUresult cuMemsetD2D16Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned short us, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD2D32 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned int  ui, size_t Width, size_t Height )
# CUresult cuMemsetD2D32Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned int  ui, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD2D8 ( CUdeviceptr dstDevice, size_t dstPitch, unsigned char  uc, size_t Width, size_t Height )
# CUresult cuMemsetD2D8Async ( CUdeviceptr dstDevice, size_t dstPitch, unsigned char  uc, size_t Width, size_t Height, CUstream hStream )
# CUresult cuMemsetD32 ( CUdeviceptr dstDevice, unsigned int  ui, size_t N )
# CUresult cuMemsetD32Async ( CUdeviceptr dstDevice, unsigned int  ui, size_t N, CUstream hStream )
# CUresult cuMemsetD8 ( CUdeviceptr dstDevice, unsigned char  uc, size_t N )
# CUresult cuMemsetD8Async ( CUdeviceptr dstDevice, unsigned char  uc, size_t N, CUstream hStream )

class CudaMemoryManagementTest < Minitest::Test
  def setup
    @cu_context = FFI::MemoryPointer.new :pointer
    @cu_array = FFI::MemoryPointer.new :pointer
    @cu_array_3d = FFI::MemoryPointer.new :pointer
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    @cu_device = 0

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    # For testing the memory we need to have a context created
    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)

    p_allocate_array = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_allocate_array[:Width] = 2048
    p_allocate_array[:Height] = 0
    p_allocate_array[:Depth] = 0
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    p_allocate_array[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SURFACE_LDST
    Cuda::DriverApi.cuArray3DCreate_v2(@cu_array_3d, p_allocate_array)

    p_allocate_array = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    Cuda::DriverApi.cuArrayCreate_v2(@cu_array, p_allocate_array)
  end

  def test_cu_mem_alloc_invalid
    d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 0
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuMemAlloc_v2(d_ptr, byte_size))
  end

  def test_cu_mem_alloc
    d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(d_ptr, byte_size))
    assert_equal(:success, Cuda::DriverApi.cuMemFree_v2(d_ptr.read_pointer))
  end

  def test_cu_mem_alloc_host_free
    pp = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemAllocHost_v2(pp, byte_size))
    assert_equal(:success, Cuda::DriverApi.cuMemFreeHost(pp.read_pointer))
  end

  def test_cu_mem_alloc_managed
    d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemAllocManaged(d_ptr, byte_size, Cuda::DriverApi::CU_MEM_ATTACH_GLOBAL))
  end

  def test_cu_mem_alloc_pitch
    d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    p_pitch = FFI::MemoryPointer.new(:size_t, 1)
    width_in_bytes = 4
    height = 2
    element_size_bytes = 4
    assert_equal(:success, Cuda::DriverApi.cuMemAllocPitch_v2(d_ptr, p_pitch, width_in_bytes, height, element_size_bytes))
    # puts "Pitch #{p_pitch.read(:size_t)}"
  end

  def test_cu_mem_get_address_range
    d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(d_ptr, byte_size))
    p_base = FFI::MemoryPointer.new(:pointer, 1)
    p_size = FFI::MemoryPointer.new(:size_t, 1)
    assert_equal(:success, Cuda::DriverApi.cuMemGetAddressRange_v2(p_base, p_size, d_ptr.read_pointer))
    assert_equal(byte_size, p_size.read(:size_t))
  end

  def test_cu_mem_get_info
    free = FFI::MemoryPointer.new(:size_t, 1)
    total = FFI::MemoryPointer.new(:size_t, 1)
    assert_equal(:success, Cuda::DriverApi.cuMemGetInfo_v2(free, total))
    # puts "Free #{free.read(:size_t)} Total #{total.read(:size_t)}"
  end

  def test_cu_mem_host_alloc_free
    pp = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemHostAlloc(pp, byte_size, Cuda::DriverApi::CU_MEMHOSTALLOC_PORTABLE))
    assert_equal(:success, Cuda::DriverApi.cuMemFreeHost(pp.read_pointer))
  end

  def test_cu_mem_host_get_device_pointer
    p = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemHostAlloc(p, byte_size, Cuda::DriverApi::CU_MEMHOSTALLOC_PORTABLE))
    p_d_ptr = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuMemHostGetDevicePointer_v2(p_d_ptr, p.read_pointer, 0))
  end

  def test_cu_mem_host_get_flags
    p = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemHostAlloc(p, byte_size, Cuda::DriverApi::CU_MEMHOSTALLOC_PORTABLE))
    p_flags = FFI::MemoryPointer.new(:uint, 1)
    assert_equal(:success, Cuda::DriverApi.cuMemHostGetFlags(p_flags, p.read_pointer))
    assert_equal(3, p_flags.read(:uint))
  end

  def test_cu_mem_host_register_unregister
    p = FFI::MemoryPointer.new(:pointer, 1)
    byte_size = 4
    assert_equal(:success, Cuda::DriverApi.cuMemHostRegister_v2(p, byte_size, Cuda::DriverApi::CU_MEMHOSTREGISTER_PORTABLE))
    assert_equal(:success, Cuda::DriverApi.cuMemHostUnregister(p))
  end

  def test_cu_mem_cpy
    array = [1, 2, 3]
    dst = FFI::MemoryPointer.new(:ulong_long, array.size)
    src = FFI::MemoryPointer.new(:ulong_long, array.size)
    src.write_array_of_ulong_long(array)

    byte_count = src.size

    assert_equal(:success, Cuda::DriverApi.cuMemcpy(dst.address, src.address, byte_count))
    assert_equal(src.read_array_of_ulong_long(3), dst.read_array_of_ulong_long(3))
  end

  def test_cu_mem_cpy_async
    dst = FFI::MemoryPointer.new(:pointer, 3)
    src = FFI::MemoryPointer.new(:pointer, 3)
    src.write_array_of_int([1, 2, 3])

    byte_count = src.size

    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuMemcpyAsync(dst, src, byte_count, cu_stream.read_pointer))

    assert_equal([1, 2, 3].to_s, dst.read_array_of_int(3).to_s)
  end

  def test_cu_mem_cpy_host_to_device_and_back
    # Fixed: Here we need to put data on the device first and than read it again
    # otherwise we cannot verify the output as dst_host contains random values from device
    # # Here is a full example of getting data from the host to the device and back

    src_host = FFI::MemoryPointer.new(:ulong_long, 3)
    src_host.write_array_of_int([3, 2, 1])
    byte_count = src_host.size

    # First dst_host is zero
    dst_host = FFI::MemoryPointer.new(:ulong_long, 3)
    assert_equal([0, 0, 0], dst_host.read_array_of_int(3))

    tmp_device = FFI::MemoryPointer.new(:ulong_long, 3)
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(tmp_device, byte_count))
    assert_equal(:success, Cuda::DriverApi.cuMemcpy(tmp_device.read_ulong_long, src_host.address, byte_count))
    assert_equal(:success, Cuda::DriverApi.cuMemcpyDtoH_v2(dst_host, tmp_device.read_ulong_long, byte_count))

    # Now dst_host is the same as src_host and has been copied through the device
    assert_equal([3, 2, 1], dst_host.read_array_of_int(3))

    # >>> Whenever we allocate a device memory FFI can no longer write into the device memory. <<<
    # # It is true that we cannot read/write to the device through the pointers allocated on the host.
    # # This is why we have the api to copy data back and forth.
    # >>> If we write some data it says invalid value.
    # # So to access data on the device we have to copy it to the host first and the other way around

    # >>> After looking at the sample of cuda it seems. A Nvidia kernel is launched at the device memory. <<<
    # # A kernel is basicaly a callback on the device (which is called with some special variables filled).
    # # This is the principle workflow of every cuda program:
    # # 1. We prepare the device memory first on the device by copying the data over.
    # # 2. Than we launch a kernel with the pointer values as arguments.
    # # 3. In the kernel we use the device pointer to access the data and do our computations
    # # 4. We copy the results back from device to the host

    # >>> After allocating the memory at device the data will be empty/zero. <<<
    # # I think the data is undefined after a device malloc
  end

  def test_cu_mem_cpy_h_to_d_to_h
    array = [3, 2, 1]
    src_dst_host = FFI::MemoryPointer.new(:ulong_long, array.size)
    src_dst_host.write_array_of_int(array)
    byte_count = src_dst_host.size

    dst_device = FFI::MemoryPointer.new(:ulong_long, array.size)
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(dst_device, byte_count))

    assert_equal(:success, Cuda::DriverApi.cuMemcpyHtoD_v2(dst_device.read_ulong_long, src_dst_host, byte_count))
    zeroed_array = [0, 0, 0]
    src_dst_host.write_array_of_int(zeroed_array)
    assert_equal(zeroed_array, src_dst_host.read_array_of_int(array.size))

    assert_equal(:success, Cuda::DriverApi.cuMemcpyDtoH_v2(src_dst_host, dst_device.read_ulong_long, byte_count))
    assert_equal(array, src_dst_host.read_array_of_int(array.size))
  end

  def test_cu_mem_cpy_h_to_d
    array_host = [1, 2, 3]
    src_host = FFI::MemoryPointer.new(:int, array_host.size)
    src_host.write_array_of_int(array_host)

    byte_count = src_host.size # byte_count is the memory size in bytes

    dst_device = FFI::MemoryPointer.new(:ulong_long)

    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(dst_device, byte_count))
    assert_equal(:success, Cuda::DriverApi.cuMemcpyHtoD_v2(dst_device.read_ulong_long, src_host, byte_count))

    # Again we can not check whether device memory contains our host data or not
  end

  def test_cu_mem_cpy_d_to_h_async
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))

    dst_host = FFI::MemoryPointer.new(:int, 3)
    src_device = FFI::MemoryPointer.new(:ulong_long)
    byte_count = src_device.size
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(src_device, byte_count))
    # TODO: Here we need to put data on the device first and than read it again
    # >>> Discussed before <<<
    # otherwise we cannot verify the output as dst_host contains random values from device
    assert_equal(:success, Cuda::DriverApi.cuMemcpyDtoHAsync_v2(dst_host, src_device.read_ulong_long, byte_count, cu_stream.read_pointer))
    # TODO: Verify output
    # >>> Discussed before <<<

    # assert_equal([0, 0, 0],dst_host.read_array_of_int(3))
  end

  def test_cu_mem_cpy_h_to_d_async
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))

    dst_device = FFI::MemoryPointer.new(:ulong_long)
    src_host = FFI::MemoryPointer.new(:int, 3)
    byte_count = src_host.size
    assert_equal(:success, Cuda::DriverApi.cuMemAlloc_v2(dst_device, byte_count))
    assert_equal(:success, Cuda::DriverApi.cuMemcpyHtoDAsync_v2(dst_device.read_ulong_long, src_host, byte_count, cu_stream.read_pointer))
  end

  # TODO: CUDAMEMCPY2DSt parameters are not correct
  def test_cu_mem_cpy_2d_async_unaligned
    # Not a correct CUDAMEMCPY2DSt structure
    p_copy = Cuda::DriverApi::CUDAMEMCPY2DSt.new
    p_copy[:srcXInBytes] = 0
    p_copy[:srcY] = 0
    p_copy[:srcMemoryType] = Cuda::DriverApi::CU_MEMORYTYPE_ARRAY
    p_copy[:srcHost] = 0
    p_copy[:srcDevice] = 0
    p_copy[:srcArray] = 0
    p_copy[:srcPitch] = 0
    p_copy[:dstXInBytes] = 0
    p_copy[:dstY] = 0
    p_copy[:dstMemoryType] = Cuda::DriverApi::CU_MEMORYTYPE_ARRAY
    p_copy[:dstHost] = 0
    p_copy[:dstDevice] = 0
    p_copy[:dstArray] = 0
    p_copy[:dstPitch] = 0
    p_copy[:WidthInBytes] = 0
    p_copy[:Height] = 0
    assert_equal(:success, Cuda::DriverApi.cuMemcpy2D_v2(p_copy))

    cu_stream = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT)
    assert_equal(:success, Cuda::DriverApi.cuMemcpy2DAsync_v2(p_copy, cu_stream.read_pointer))

    assert_equal(:success, Cuda::DriverApi.cuMemcpy2DUnaligned_v2(p_copy))
  end

  # TODO: CUDAMEMCPY3DSt parameter are not correct
  def test_cu_mem_cpy_3d_async
    p_copy = Cuda::DriverApi::CUDAMEMCPY3DSt.new
    p_copy[:srcXInBytes] = 0
    p_copy[:srcY] = 0
    p_copy[:srcZ] = 0
    p_copy[:srcLOD] = 0
    p_copy[:srcMemoryType] = 0
    p_copy[:srcHost] = 0
    p_copy[:srcDevice] = 0
    p_copy[:srcArray] = 0
    p_copy[:reserved0] = 0
    p_copy[:srcPitch] = 0
    p_copy[:srcHeight] = 0
    p_copy[:dstXInBytes] = 0
    p_copy[:dstY] = 0
    p_copy[:dstZ] = 0
    p_copy[:dstLOD] = 0
    p_copy[:dstMemoryType] = 0
    p_copy[:dstHost] = 0
    p_copy[:dstDevice] = 0
    p_copy[:dstArray] = 0
    p_copy[:reserved1] = 0
    p_copy[:dstPitch] = 0
    p_copy[:dstHeight] = 0
    p_copy[:WidthInBytes] = 0
    p_copy[:Height] = 0
    p_copy[:Depth] = 0
    assert_equal(:success, Cuda::DriverApi.cuMemcpy3D_v2(p_copy))

    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuMemcpy3DAsync_v2(p_copy, cu_stream.read_pointer))
  end

  # TODO: CUDAMEMCPY3DSt parameter are not correct
  def test_cu_mem_cpy_3d_peer_peer_async
    p_copy = Cuda::DriverApi::CUDAMEMCPY3DSt.new
    p_copy[:srcXInBytes] = 0
    p_copy[:srcY] = 0
    p_copy[:srcZ] = 0
    p_copy[:srcLOD] = 0
    p_copy[:srcMemoryType] = 0
    p_copy[:srcHost] = 0
    p_copy[:srcDevice] = 0
    p_copy[:srcArray] = 0
    p_copy[:reserved0] = 0
    p_copy[:srcPitch] = 0
    p_copy[:srcHeight] = 0
    p_copy[:dstXInBytes] = 0
    p_copy[:dstY] = 0
    p_copy[:dstZ] = 0
    p_copy[:dstLOD] = 0
    p_copy[:dstMemoryType] = 0
    p_copy[:dstHost] = 0
    p_copy[:dstDevice] = 0
    p_copy[:dstArray] = 0
    p_copy[:reserved1] = 0
    p_copy[:dstPitch] = 0
    p_copy[:dstHeight] = 0
    p_copy[:WidthInBytes] = 0
    p_copy[:Height] = 0
    p_copy[:Depth] = 0
    assert_equal(:success, Cuda::DriverApi.cuMemcpy3DPeer(p_copy))

    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuMemcpy3DPeerAsync(p_copy, cu_stream.read_pointer))
  end

  def test_cu_mipmapped_array_create_destroy
    p_handle = FFI::MemoryPointer.new(:pointer, 1)

    # Array descriptor needs to be specific on which type of array will be created otherwise it will send error invalid value
    p_mipmapped_array_desc = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_mipmapped_array_desc[:Width] = 4
    p_mipmapped_array_desc[:Height] = 4
    p_mipmapped_array_desc[:Depth] = 6
    p_mipmapped_array_desc[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_mipmapped_array_desc[:NumChannels] = 1 # 1, 2 or 4
    p_mipmapped_array_desc[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_CUBEMAP
    num_mipmap_levels = 2
    assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayCreate(p_handle, p_mipmapped_array_desc, num_mipmap_levels))
    assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayDestroy(p_handle.read_pointer))
  end

  def test_cu_mipmapped_array_get_level
    p_handle = FFI::MemoryPointer.new(:pointer, 1)

    # Array descriptor needs to be specific on which type of array will be created otherwise it will send error invalid value
    p_mipmapped_array_desc = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_mipmapped_array_desc[:Width] = 4
    p_mipmapped_array_desc[:Height] = 4
    p_mipmapped_array_desc[:Depth] = 6
    p_mipmapped_array_desc[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_mipmapped_array_desc[:NumChannels] = 1 # 1, 2 or 4
    p_mipmapped_array_desc[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_CUBEMAP
    num_mipmap_levels = 2
    assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayCreate(p_handle, p_mipmapped_array_desc, num_mipmap_levels))

    p_level_array = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayGetLevel(p_level_array, p_handle.read_pointer, 1))
  end

  # TODO: Can not create a sparse array to test the sparse properties
  # def test_cu_mipmapped_array_get_sparse_properties
  #   p_handle = FFI::MemoryPointer.new(:pointer, 1)
  #
  #   # Array descriptor needs to be specific on which type of array will be created otherwise it will send error invalid value
  #   p_mipmapped_array_desc = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
  #   p_mipmapped_array_desc[:Width] = 2
  #   p_mipmapped_array_desc[:Height] = 0
  #   p_mipmapped_array_desc[:Depth] = 0
  #   p_mipmapped_array_desc[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
  #   p_mipmapped_array_desc[:NumChannels] = 1 # 1, 2 or 4
  #   p_mipmapped_array_desc[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SPARSE
  #   num_mipmap_levels = 2
  #   assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayCreate(p_handle, p_mipmapped_array_desc, num_mipmap_levels))
  #
  #   sparse_properties = FFI::MemoryPointer.new(:pointer, 1)
  #   assert_equal(:success, Cuda::DriverApi.cuMipmappedArrayGetSparseProperties(sparse_properties, p_handle.read_pointer))
  # end

  def test_cu_array_3d_create
    p_handle_ptr = FFI::MemoryPointer.new :pointer
    p_allocate_array = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_allocate_array[:Width] = 2048
    p_allocate_array[:Height] = 0
    p_allocate_array[:Depth] = 0
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    p_allocate_array[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SURFACE_LDST
    assert_equal(:success, Cuda::DriverApi.cuArray3DCreate_v2(p_handle_ptr, p_allocate_array))
    refute_nil(p_handle_ptr.read_pointer)
  end

  # # FIXME: memory issues
  # def test_cu_array_3d_get_descriptor
  #   cu_array_3d_ptr = FFI::MemoryPointer.new :pointer
  #
  #   cu_array_3d_descriptor = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
  #   cu_array_3d_descriptor[:Width] = 8
  #   cu_array_3d_descriptor[:Height] = 6
  #   cu_array_3d_descriptor[:Depth] = 4
  #   cu_array_3d_descriptor[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
  #   cu_array_3d_descriptor[:NumChannels] = 1
  #   cu_array_3d_descriptor[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_LAYERED
  #
  #   assert_equal(:success, Cuda::DriverApi.cuArray3DCreate_v2(cu_array_3d_ptr, cu_array_3d_descriptor))
  #
  #   refute_nil(cu_array_3d_ptr.read_pointer)
  #
  #   assert_equal('Success', 'Test returns successfully but ruby got segmentation fault.')
  #   p_array_3d_descriptor_ptr = FFI::MemoryPointer.new :pointer
  #   assert_equal(:success,
  #                Cuda::DriverApi.cuArray3DGetDescriptor_v2(
  #                  p_array_3d_descriptor_ptr,
  #                  cu_array_3d_ptr.read_pointer
  #                ))
  #
  #   refute_nil(cu_array_3d_ptr.read_pointer)
  #
  #   array_3d_descriptor = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new p_array_3d_descriptor_ptr
  #   puts array_3d_descriptor[:Width]
  # end

  def test_cu_array_create
    p_handle_ptr = FFI::MemoryPointer.new :pointer
    p_allocate_array = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    assert_equal(:success, Cuda::DriverApi.cuArrayCreate_v2(p_handle_ptr, p_allocate_array))
    refute_nil(p_handle_ptr.read_pointer)
  end

  def test_cu_array_destroy
    p_handle_ptr = FFI::MemoryPointer.new :pointer
    p_allocate_array = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    Cuda::DriverApi.cuArrayCreate_v2(p_handle_ptr, p_allocate_array)

    assert_equal(:success, Cuda::DriverApi.cuArrayDestroy(p_handle_ptr.read_pointer))
  end

  def test_cu_array_get_descriptor
    p_allocate_array = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    assert_equal(:success, Cuda::DriverApi.cuArrayCreate_v2(@cu_array, p_allocate_array))

    p_array_descriptor_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuArrayGetDescriptor_v2(p_array_descriptor_ptr, @cu_array.read_pointer))

    array_descriptor = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new p_array_descriptor_ptr

    assert_equal(64, array_descriptor[:Width])
  end

  def test_cu_array_get_plane
    p_plane_array = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetPlane(p_plane_array, @cu_array.read_pointer, 0))
  end

  def test_cu_array_get_sparse_properties_invalid_value
    sparse_properties = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetSparseProperties(sparse_properties, @cu_array_3d.read_pointer))
  end

  # TODO: Can not create a sparse array to test sparse properties
  # def test_cu_array_get_sparse_properties
  #   p_handle_ptr = FFI::MemoryPointer.new :pointer
  #   p_allocate_array = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
  #   p_allocate_array[:Width] = 64
  #   p_allocate_array[:Height] = 64
  #   p_allocate_array[:Depth] = 4
  #   p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
  #   p_allocate_array[:NumChannels] = 2
  #   p_allocate_array[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SPARSE
  #   assert_equal(:success, Cuda::DriverApi.cuArray3DCreate_v2(p_handle_ptr, p_allocate_array))
  #
  #   sparse_properties = FFI::MemoryPointer.new :pointer
  #   assert_equal(:success, Cuda::DriverApi.cuArrayGetSparseProperties(sparse_properties, p_handle_ptr))
  # end

  def test_cu_device_get_pci_bus_id
    len = 100
    pci_bus_id = FFI::MemoryPointer.new(len)
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetPCIBusId(pci_bus_id, len, @cu_device))
    refute_nil(pci_bus_id.read_string)
  end

  def test_cu_device_get_by_pci_bus_id
    len = 100
    pci_bus_id = FFI::MemoryPointer.new(len)
    Cuda::DriverApi.cuDeviceGetPCIBusId(pci_bus_id, len, @cu_device)
    refute_nil(pci_bus_id.read_string)

    dev = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetByPCIBusId(dev, pci_bus_id.read_string))
    assert_equal(@cu_device, dev.read(:int))
  end
end
