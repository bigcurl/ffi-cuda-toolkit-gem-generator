# frozen_string_literal: true

require 'test_helper'

# Problems
# CUresult cuArray3DGetDescriptor ( CUDA_ARRAY3D_DESCRIPTOR* pArrayDescriptor, CUarray hArray )

# Not done
# CUresult cuIpcCloseMemHandle ( CUdeviceptr dptr )
# CUresult cuIpcGetEventHandle ( CUipcEventHandle* pHandle, CUevent event )
# CUresult cuIpcGetMemHandle ( CUipcMemHandle* pHandle, CUdeviceptr dptr )
# CUresult cuIpcOpenEventHandle ( CUevent* phEvent, CUipcEventHandle handle )
# CUresult cuIpcOpenMemHandle ( CUdeviceptr* pdptr, CUipcMemHandle handle, unsigned int  Flags )

# CUresult cuMemcpy ( CUdeviceptr dst, CUdeviceptr src, size_t ByteCount )
# CUresult cuMemcpy2D ( const CUDA_MEMCPY2D* pCopy )
# CUresult cuMemcpy2DAsync ( const CUDA_MEMCPY2D* pCopy, CUstream hStream )
# CUresult cuMemcpy2DUnaligned ( const CUDA_MEMCPY2D* pCopy )
# CUresult cuMemcpy3D ( const CUDA_MEMCPY3D* pCopy )
# CUresult cuMemcpy3DAsync ( const CUDA_MEMCPY3D* pCopy, CUstream hStream )
# CUresult cuMemcpy3DPeer ( const CUDA_MEMCPY3D_PEER* pCopy )
# CUresult cuMemcpy3DPeerAsync ( const CUDA_MEMCPY3D_PEER* pCopy, CUstream hStream )
# CUresult cuMemcpyAsync ( CUdeviceptr dst, CUdeviceptr src, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyAtoA ( CUarray dstArray, size_t dstOffset, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoD ( CUdeviceptr dstDevice, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoH ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount )
# CUresult cuMemcpyAtoHAsync ( void* dstHost, CUarray srcArray, size_t srcOffset, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyDtoA ( CUarray dstArray, size_t dstOffset, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoD ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoDAsync ( CUdeviceptr dstDevice, CUdeviceptr srcDevice, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyDtoH ( void* dstHost, CUdeviceptr srcDevice, size_t ByteCount )
# CUresult cuMemcpyDtoHAsync ( void* dstHost, CUdeviceptr srcDevice, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyHtoA ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount )
# CUresult cuMemcpyHtoAAsync ( CUarray dstArray, size_t dstOffset, const void* srcHost, size_t ByteCount, CUstream hStream )
# CUresult cuMemcpyHtoD ( CUdeviceptr dstDevice, const void* srcHost, size_t ByteCount )
# CUresult cuMemcpyHtoDAsync ( CUdeviceptr dstDevice, const void* srcHost, size_t ByteCount, CUstream hStream )
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
# CUresult cuMipmappedArrayCreate ( CUmipmappedArray* pHandle, const CUDA_ARRAY3D_DESCRIPTOR* pMipmappedArrayDesc, unsigned int  numMipmapLevels )
# CUresult cuMipmappedArrayDestroy ( CUmipmappedArray hMipmappedArray )
# CUresult cuMipmappedArrayGetLevel ( CUarray* pLevelArray, CUmipmappedArray hMipmappedArray, unsigned int  level )
# CUresult cuMipmappedArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUmipmappedArray mipmap )

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

  # FIXME: memory issues
  def test_cu_array_3d_get_descriptor
    # cu_ctx = FFI::MemoryPointer.new :pointer
    # Cuda::DriverApi.cuDevicePrimaryCtxRetain(cu_ctx, @cu_device)
    # Cuda::DriverApi.cuCtxPushCurrent_v2(cu_ctx.read_pointer)
    # Cuda::DriverApi.cuCtxSetCurrent(cu_ctx.read_pointer)

    cu_array_3d_ptr = FFI::Pointer.new(:pointer, 1)
    cu_array_3d_descriptor = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    cu_array_3d_descriptor[:Width] = 64
    cu_array_3d_descriptor[:Height] = 64
    cu_array_3d_descriptor[:Depth] = 0
    cu_array_3d_descriptor[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    cu_array_3d_descriptor[:NumChannels] = 1
    cu_array_3d_descriptor[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SURFACE_LDST

    cu_array_3d_descriptor_array = FFI::MemoryPointer.new :pointer
    cu_array_3d_descriptor_array.write_array_of_pointer([cu_array_3d_descriptor])
    Cuda::DriverApi.cuArray3DCreate_v2(cu_array_3d_ptr, cu_array_3d_descriptor_array)

    # cu_ctx_curr = FFI::MemoryPointer.new :pointer
    # Cuda::DriverApi.cuCtxGetCurrent(cu_ctx_curr)
    # assert_equal(cu_ctx_curr.read_pointer, cu_ctx.read_pointer)

    assert_equal('Success', 'Segmentation fault')
    p_array_3d_descriptor_ptr = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:error_context_is_destroyed,
                 # Segmentation fault. Trying to access invalid memory address
                 Cuda::DriverApi.cuArray3DGetDescriptor_v2(
                   p_array_3d_descriptor_ptr,
                   cu_array_3d_ptr))

  end

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
    p_array_descriptor_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuArrayGetDescriptor_v2(p_array_descriptor_ptr, @cu_array.read_pointer))
  end

  def test_cu_array_get_plane
    p_plane_array = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetPlane(p_plane_array, @cu_array.read_pointer, 0))
  end

  def test_cu_array_get_sparse_properties_invalid_value
    sparse_properties = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetSparseProperties(sparse_properties, @cu_array_3d.read_pointer))
  end

  def test_cu_array_get_sparse_properties
    p_handle_ptr = FFI::MemoryPointer.new :pointer
    p_allocate_array = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Depth] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 6
    p_allocate_array[:Flags] = Cuda::DriverApi::CU_AD_FORMAT_NV12
    Cuda::DriverApi.cuArray3DCreate_v2(p_handle_ptr, p_allocate_array)

    sparse_properties = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetSparseProperties(sparse_properties, p_handle_ptr.read_pointer))
  end

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
    puts "Pitch #{p_pitch.read(:size_t)}"
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
    puts "Free #{free.read(:size_t)} Total #{total.read(:size_t)}"
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
end
