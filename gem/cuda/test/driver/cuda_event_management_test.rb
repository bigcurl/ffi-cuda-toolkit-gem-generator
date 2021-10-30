# frozen_string_literal: true

require 'test_helper'

# Not done
# CUresult cuEventDestroy ( CUevent hEvent )
# CUresult cuEventRecord ( CUevent hEvent, CUstream hStream )
# CUresult cuEventRecordWithFlags ( CUevent hEvent, CUstream hStream, unsigned int  flags )
# CUresult cuEventSynchronize ( CUevent hEvent )

class CudaInitializationTest < Minitest::Test
  def test_cu_event_create
    ph_event = FFI::MemoryPointer.new(:pointer, 1)
    # FIXME: returns error_not_initialized. Found not CUevent struct in the API
    assert_equal(:success, Cuda::DriverApi.cuEventCreate(ph_event, Cuda::DriverApi::CU_EVENT_DEFAULT))
  end

  # Need to have an event to query it's information
  def test_cu_event_query_invalid_context
    h_event = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:error_invalid_context, Cuda::DriverApi.cuEventQuery(h_event))
  end

  def test_cu_event_elapsed_time
    h_start = FFI::MemoryPointer.new(:pointer, 1)
    h_end = FFI::MemoryPointer.new(:pointer, 1)
    p_milliseconds = FFI::MemoryPointer.new(:float, 1)
    assert_equal(:error_invalid_context, Cuda::DriverApi.cuEventElapsedTime(p_milliseconds, h_start, h_end))
  end
end
