# frozen_string_literal: true

module Cuda
  module DriverApi
    module Occupancy
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuOccupancyAvailableDynamicSMemPerBlock, %i[pointer pointer int int], :int
      attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessor, %i[pointer pointer int size_t], :int
      attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags,
                      %i[pointer pointer int size_t uint], :int
      attach_function :cuOccupancyMaxPotentialBlockSize, %i[pointer pointer pointer pointer size_t int],
                      :int
      attach_function :cuOccupancyMaxPotentialBlockSizeWithFlags,
                      %i[pointer pointer pointer pointer size_t int uint], :int
    end
  end
end
