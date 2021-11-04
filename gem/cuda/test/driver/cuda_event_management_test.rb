# frozen_string_literal: true

require 'test_helper'

class CudaEventManagementTest < Minitest::Test
  def setup
    @cu_context = FFI::MemoryPointer.new :pointer
    @cu_event = FFI::MemoryPointer.new :pointer
    @cu_stream = FFI::MemoryPointer.new :pointer

    Cuda::DriverApi.cuInit(0)

    cu_device_ptr = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDeviceGet(cu_device_ptr, 0)

    # For testing the memory we need to have a context created
    Cuda::DriverApi.cuCtxCreate_v2(@cu_context, 0, cu_device_ptr.read(:int))

    Cuda::DriverApi.cuStreamCreate(@cu_stream, Cuda::DriverApi::CU_STREAM_DEFAULT)

    Cuda::DriverApi.cuEventCreate(@cu_event, Cuda::DriverApi::CU_EVENT_DEFAULT)
  end

  def test_cu_event_create_default_event
    ph_event = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuEventCreate(ph_event, Cuda::DriverApi::CU_EVENT_DEFAULT))
    refute_nil(ph_event.read_pointer)
  end

  def test_cu_event_create_event_blocking_sync
    ph_event = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuEventCreate(ph_event, Cuda::DriverApi::CU_EVENT_BLOCKING_SYNC))
    refute_nil(ph_event.read_pointer)
  end

  def test_cu_event_create_event_disable_timing
    ph_event = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuEventCreate(ph_event, Cuda::DriverApi::CU_EVENT_DISABLE_TIMING))
    refute_nil(ph_event.read_pointer)
  end

  def test_cu_event_create_event_interprocess
    ph_event = FFI::MemoryPointer.new(:pointer, 1)
    # Returns error_invalid_value
    assert_equal(:success, Cuda::DriverApi.cuEventCreate(ph_event, Cuda::DriverApi::CU_EVENT_INTERPROCESS | Cuda::DriverApi::CU_EVENT_DISABLE_TIMING))
    refute_nil(ph_event.read_pointer)
  end

  def test_cu_event_record
    assert_equal(:success, Cuda::DriverApi.cuEventRecord(@cu_event.read_pointer, @cu_stream.read_pointer))
  end

  def test_cu_event_elapsed_time
    h_start = FFI::MemoryPointer.new(:pointer, 1)
    Cuda::DriverApi.cuEventCreate(h_start, Cuda::DriverApi::CU_EVENT_DEFAULT)
    Cuda::DriverApi.cuEventRecord(h_start.read_pointer, @cu_stream.read_pointer)

    h_end = FFI::MemoryPointer.new(:pointer, 1)
    Cuda::DriverApi.cuEventCreate(h_end, Cuda::DriverApi::CU_EVENT_DEFAULT)
    Cuda::DriverApi.cuEventRecord(h_end.read_pointer, @cu_stream.read_pointer)

    p_milliseconds = FFI::MemoryPointer.new(:float, 1)

    assert_equal(:success, Cuda::DriverApi.cuEventElapsedTime(p_milliseconds, h_start.read_pointer, h_end.read_pointer))
    refute_nil(p_milliseconds.read(:float))
  end

  def test_cu_event_query
    assert_equal(:success, Cuda::DriverApi.cuEventQuery(@cu_event.read_pointer))
  end

  def test_cu_event_query_invalid_context
    h_event = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:error_invalid_context, Cuda::DriverApi.cuEventQuery(h_event))
  end

  def test_cu_event_destroy
    h_event = FFI::MemoryPointer.new(:pointer, 1)
    Cuda::DriverApi.cuEventCreate(h_event, Cuda::DriverApi::CU_EVENT_DEFAULT)
    assert_equal(:success, Cuda::DriverApi.cuEventDestroy_v2(h_event.read_pointer))
  end

  def test_cu_event_synchronize
    assert_equal(:success, Cuda::DriverApi.cuEventSynchronize(@cu_event.read_pointer))
  end
end
