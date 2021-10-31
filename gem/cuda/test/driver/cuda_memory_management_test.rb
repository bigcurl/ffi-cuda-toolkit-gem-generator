# frozen_string_literal: true

require 'test_helper'

# Problems
# CUresult cuArray3DGetDescriptor ( CUDA_ARRAY3D_DESCRIPTOR* pArrayDescriptor, CUarray hArray )
# CUresult cuArrayGetPlane ( CUarray* pPlaneArray, CUarray hArray, unsigned int  planeIdx )
# CUresult cuArrayGetSparseProperties ( CUDA_ARRAY_SPARSE_PROPERTIES* sparseProperties, CUarray array )

# Not done
# CUresult cuIpcCloseMemHandle ( CUdeviceptr dptr )
# CUresult cuIpcGetEventHandle ( CUipcEventHandle* pHandle, CUevent event )
# CUresult cuIpcGetMemHandle ( CUipcMemHandle* pHandle, CUdeviceptr dptr )
# CUresult cuIpcOpenEventHandle ( CUevent* phEvent, CUipcEventHandle handle )
# CUresult cuIpcOpenMemHandle ( CUdeviceptr* pdptr, CUipcMemHandle handle, unsigned int  Flags )
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

  @@cuContext = FFI::MemoryPointer.new :pointer
  @@cuArray = FFI::MemoryPointer.new :pointer
  @@cuArray3D = FFI::MemoryPointer.new :pointer
  @@cuDevice = 0

  def setup
    Cuda::DriverApi.cuInit(0)

    cuDevicePtr = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDeviceGet(cuDevicePtr, 0)

    # For testing the memory we need to have a context created
    Cuda::DriverApi.cuCtxCreate_v2(@@cuContext, 0, cuDevicePtr.read(:int))

    @@device_pointer = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDeviceGet(@@device_pointer, 0)
    @@cuDevice = @@device_pointer.read(:int)

    p_allocate_array = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
    p_allocate_array[:Width] = 2048
    p_allocate_array[:Height] = 0
    p_allocate_array[:Depth] = 0
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    p_allocate_array[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SURFACE_LDST
    Cuda::DriverApi.cuArray3DCreate_v2(@@cuArray3D, p_allocate_array)

    p_allocate_array = Cuda::DriverApi::CUDAARRAYDESCRIPTORSt.new
    p_allocate_array[:Width] = 64
    p_allocate_array[:Height] = 64
    p_allocate_array[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
    p_allocate_array[:NumChannels] = 1
    Cuda::DriverApi.cuArrayCreate_v2(@@cuArray, p_allocate_array)
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
  # def test_cu_array_3d_get_descriptor
  #   cuArray3D_ptr = FFI::MemoryPointer.new :pointer
  #   cuArray3DDescriptor = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new
  #   cuArray3DDescriptor[:Width] = 64
  #   cuArray3DDescriptor[:Height] = 64
  #   cuArray3DDescriptor[:Depth] = 0
  #   cuArray3DDescriptor[:Format] = Cuda::DriverApi::CU_AD_FORMAT_FLOAT
  #   cuArray3DDescriptor[:NumChannels] = 1
  #   cuArray3DDescriptor[:Flags] = Cuda::DriverApi::CUDA_ARRAY3D_SURFACE_LDST
  #   Cuda::DriverApi.cuArray3DCreate_v2(cuArray3D_ptr, cuArray3DDescriptor)
  #
  #   p_array_3d_descriptor_ptr = FFI::MemoryPointer.new :pointer
  #   # FIXME: Some memory issues. Can not read cuArray3D pointer
  #   # assert_equal(:success, Cuda::DriverApi.cuArray3DGetDescriptor_v2(p_array_3d_descriptor_ptr, cuArray3D_ptr.read_pointer))
  #
  #   # p_array_descriptor = Cuda::DriverApi::CUDAARRAY3DDESCRIPTORSt.new p_array_descriptor_ptr
  #   # p_array_descriptor = p_array_descriptor_ptr.read_pointer
  #   # refute_nil(p_array_descriptor[:Format])
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
    p_array_descriptor_ptr = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuArrayGetDescriptor_v2(p_array_descriptor_ptr, @@cuArray.read_pointer))
  end

  def test_cu_array_get_plane
    p_plane_array = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetPlane(p_plane_array, @@cuArray.read_pointer, 0))
  end

  def test_cu_array_get_sparse_properties_invalid_value
    sparse_properties = FFI::MemoryPointer.new :pointer
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuArrayGetSparseProperties(sparse_properties, @@cuArray3D.read_pointer))
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
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetPCIBusId(pci_bus_id, len, @@cuDevice))
    refute_nil(pci_bus_id.read_string)
  end

  def test_cu_device_get_by_pci_bus_id
    len = 100
    pci_bus_id = FFI::MemoryPointer.new(len)
    Cuda::DriverApi.cuDeviceGetPCIBusId(pci_bus_id, len, @@cuDevice)
    refute_nil(pci_bus_id.read_string)

    dev = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuDeviceGetByPCIBusId(dev, pci_bus_id.read_string))
    assert_equal(@@cuDevice, dev.read(:int))
  end
end
