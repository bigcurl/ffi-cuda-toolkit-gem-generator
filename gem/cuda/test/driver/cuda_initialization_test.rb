# frozen_string_literal: true

require 'test_helper'

class CudaInitializationTest < Minitest::Test
  def test_cu_init
    assert_equal(:success, Cuda::DriverApi.cuInit(0))
  end

  def test_cu_init_shall_be_called_with_flag_zero
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuInit(1))
  end

  # Mentioned in the docu but I have not found a function
  # where the value is returned
  # def test_cu_init_shall_be_called_before_any_other_call
  #   count_pointer = FFI::MemoryPointer.new(:int, 1)
  #   assert_equal(:CUDA_ERROR_NOT_INITIALIZED, Cuda::DriverApi.cuDeviceGetCount(count_pointer))
  #   assert_equal(0, count_pointer.read(:int))
  # end
end
