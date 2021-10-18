# frozen_string_literal: true

module Cuda
  module DriverApi
    module Occupancy
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuOccupancyAvailableDynamicSMemPerBlock, %i[pointer pointer int int], :CUresult
      attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessor, %i[pointer pointer int size_t], :CUresult
      attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags,
                      %i[pointer pointer int size_t uint], :CUresult
      attach_function :cuOccupancyMaxPotentialBlockSize, %i[pointer pointer pointer pointer size_t int],
                      :CUresult
      attach_function :cuOccupancyMaxPotentialBlockSizeWithFlags,
                      %i[pointer pointer pointer pointer size_t int uint], :CUresult
    end
  end
end
