# frozen_string_literal: true

require "test_helper"

class CudaVersionManagementTest < Minitest::Test
  def test_cu_driver_get_version
    version_pointer = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi.cuDriverGetVersion(version_pointer)
    refute_equal(0, version_pointer.read(:int))
  end
end
