# frozen_string_literal: true
# Needed
# CUresult cuStreamCreate ( CUstream* phStream, unsigned int  Flags )
# CUresult cuStreamCreateWithPriority ( CUstream* phStream, unsigned int  flags, int  priority )
# CUresult cuStreamDestroy ( CUstream hStream )
# CUresult cuStreamBeginCapture ( CUstream hStream, CUstreamCaptureMode mode )
# CUresult cuStreamEndCapture ( CUstream hStream, CUgraph* phGraph )
# CUresult cuStreamAddCallback ( CUstream hStream, CUstreamCallback callback, void* userData, unsigned int  flags )
# CUresult cuStreamAttachMemAsync ( CUstream hStream, CUdeviceptr dptr, size_t length, unsigned int  flags )
# CUresult cuStreamQuery ( CUstream hStream )
# CUresult cuStreamSynchronize ( CUstream hStream )

# Not needed
# CUresult cuStreamCopyAttributes ( CUstream dst, CUstream src )
# CUresult cuStreamGetAttribute ( CUstream hStream, CUstreamAttrID attr, CUstreamAttrValue* value_out )
# CUresult cuStreamGetCaptureInfo ( CUstream hStream, CUstreamCaptureStatus* captureStatus_out, cuuint64_t* id_out )
# CUresult cuStreamGetCaptureInfo_v2 ( CUstream hStream, CUstreamCaptureStatus* captureStatus_out, cuuint64_t* id_out, CUgraph* graph_out, const CUgraphNode** dependencies_out, size_t* numDependencies_out )
# CUresult cuStreamGetCtx ( CUstream hStream, CUcontext* pctx )
# CUresult cuStreamGetFlags ( CUstream hStream, unsigned int* flags )
# CUresult cuStreamGetPriority ( CUstream hStream, int* priority )
# CUresult cuStreamIsCapturing ( CUstream hStream, CUstreamCaptureStatus* captureStatus )
# CUresult cuStreamSetAttribute ( CUstream hStream, CUstreamAttrID attr, const CUstreamAttrValue* value )
# CUresult cuStreamUpdateCaptureDependencies ( CUstream hStream, CUgraphNode* dependencies, size_t numDependencies, unsigned int  flags )
# CUresult cuStreamWaitEvent ( CUstream hStream, CUevent hEvent, unsigned int  Flags )
# CUresult cuThreadExchangeStreamCaptureMode ( CUstreamCaptureMode* mode )

require 'test_helper'

class CudaStreamManagementTest < Minitest::Test
  def setup
    @cu_device = 0
    @device_pointer = FFI::MemoryPointer.new(:int, 1)
    @cu_context = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    Cuda::DriverApi.cuDeviceGet(@device_pointer, 0)
    @cu_device = @device_pointer.read(:int)

    # Context required for
    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, @cu_device)
  end

  def test_cu_stream_create
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))

    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_NON_BLOCKING))
  end

  def test_cu_stream_destroy
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer))
  end

  def test_cu_stream_create_with_priority
    # From NVIDIA doc
    # The range of meaningful numerical priorities can be queried using cuCtxGetStreamPriorityRange.
    # Otherwise it will set to default.
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreateWithPriority(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT, -5))
    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end

  def test_cu_stream_begin_capture
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuStreamBeginCapture_v2(cu_stream.read_pointer, Cuda::DriverApi::CU_STREAM_CAPTURE_MODE_GLOBAL))

    cu_graph = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamEndCapture(cu_stream.read_pointer, cu_graph))
    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end

  def test_cu_stream_query
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuStreamQuery(cu_stream.read_pointer))
    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end

  def test_cu_stream_synchronize
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))
    assert_equal(:success, Cuda::DriverApi.cuStreamSynchronize(cu_stream.read_pointer))
    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end

  def test_cu_stream_add_callback
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))

    test_callback = Proc.new do |stream_ptr, cu_result, private_ptr|
      puts 'Callback executed...'
    end

    user_data = FFI::MemoryPointer.new :pointer

    assert_equal(:success, Cuda::DriverApi.cuStreamAddCallback(cu_stream.read_pointer, test_callback, user_data, 0))
    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end

  # FIXME: Attach memory not working.
  def test_cu_stream_attach_mem_async
    cu_stream = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuStreamCreate(cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT))

    d_ptr = FFI::MemoryPointer.new(:ulong_long)
    byte_size = 16
    assert_equal(:success, Cuda::DriverApi.cuMemAllocManaged(d_ptr, byte_size, Cuda::DriverApi::CU_MEM_ATTACH_GLOBAL))

    assert_equal(:success, Cuda::DriverApi.cuStreamAttachMemAsync(
      cu_stream.read_pointer, d_ptr.address, 0, Cuda::DriverApi::CU_MEM_ATTACH_GLOBAL))

    Cuda::DriverApi.cuStreamDestroy_v2(cu_stream.read_pointer)
  end
end
