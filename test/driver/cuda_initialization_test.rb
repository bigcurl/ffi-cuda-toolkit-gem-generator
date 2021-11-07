# frozen_string_literal: true

require 'test_helper'

class CudaInitializationTest < Minitest::Test
  def test_cu_init
    assert_equal(:success, Cuda::DriverApi.cuInit(0))
  end

  def test_cu_init_shall_be_called_with_flag_zero
    assert_equal(:error_invalid_value, Cuda::DriverApi.cuInit(1))
  end

  # def test_cu_init_shall_be_called_before_any_other_call
  #   count_pointer = FFI::MemoryPointer.new(:int, 1)
  #   assert_equal(:error_not_initialized, Cuda::DriverApi.cuDeviceGetCount(count_pointer))
  # end
end
