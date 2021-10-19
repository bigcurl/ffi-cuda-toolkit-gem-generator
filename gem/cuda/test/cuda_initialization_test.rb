# frozen_string_literal: true

require "test_helper"

class CudaInitializationTest < Minitest::Test
  def test_cu_init
    assert_equal(:CUDA_SUCCESS, Cuda::DriverApi.cuInit(0))
  end

  def test_cu_init_shall_be_called_with_flag_zero
    assert_equal(:CUDA_ERROR_INVALID_VALUE, Cuda::DriverApi.cuInit(1))
  end
end
