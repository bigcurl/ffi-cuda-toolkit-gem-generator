# frozen_string_literal: true

require "test_helper"

class CudaVersionManagementTest < Minitest::Test
  def test_cuDriverGetVersion
    version_pointer = FFI::MemoryPointer.new(:int, 1)
    Cuda::DriverApi::VersionManagement.cuDriverGetVersion(version_pointer)
    refute_equal(0, version_pointer.read(:int))
  end
end
