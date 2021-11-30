# frozen_string_literal: true

require 'test_helper'

# Needed
# CUresult cuGetErrorName ( CUresult error, const char** pStr )
# CUresult cuGetErrorString ( CUresult error, const char** pStr )

class CudaErrorHandlingTest < Minitest::Test
  def setup
    Cuda::DriverApi.cuInit(0)
  end

  def test_cu_get_error_name
    p_str = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuGetErrorName(:error_not_initialized, p_str))
    assert_equal('CUDA_ERROR_NOT_INITIALIZED', p_str.read_pointer.read_string)
  end

  def test_cu_get_error_string_error
    p_str = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuGetErrorString(:error_not_initialized, p_str))
    assert_equal('initialization error', p_str.read_pointer.read_string)
  end

  def test_cu_get_error_string_success
    p_str = FFI::MemoryPointer.new(:pointer, 1)
    assert_equal(:success, Cuda::DriverApi.cuGetErrorString(:success, p_str))
    assert_equal('no error', p_str.read_pointer.read_string)
  end
end
