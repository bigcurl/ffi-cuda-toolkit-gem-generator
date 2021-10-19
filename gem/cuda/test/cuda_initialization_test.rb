# frozen_string_literal: true

require "test_helper"

class CudaInitializationTest < Minitest::Test
  def test_cu_init
    assert_equal(:CUDA_SUCCESS, Cuda::DriverApi.cuInit(0))
  end
end
