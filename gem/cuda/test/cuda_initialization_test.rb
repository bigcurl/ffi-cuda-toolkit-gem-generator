# frozen_string_literal: true

require "test_helper"

class CudaInitializationTest < Minitest::Test
  def test_cuInit
    assert_equal(:CUDA_SUCCESS, Cuda::DriverApi::Initialization.cuInit(0))
  end
end
