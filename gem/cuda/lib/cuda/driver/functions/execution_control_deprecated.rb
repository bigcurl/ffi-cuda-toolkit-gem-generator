# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExecutionControlDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuFuncSetBlockShape, %i[pointer int int int], :int
      attach_function :cuFuncSetSharedSize, %i[pointer uint], :int
      attach_function :cuLaunch, [:pointer], :int
      attach_function :cuLaunchGrid, %i[pointer int int], :int
      attach_function :cuLaunchGridAsync, %i[pointer int int pointer], :int
      attach_function :cuParamSetSize, %i[pointer uint], :int
      attach_function :cuParamSetTexRef, %i[pointer int pointer], :int
      attach_function :cuParamSetf, %i[pointer int float], :int
      attach_function :cuParamSeti, %i[pointer int uint], :int
      attach_function :cuParamSetv, %i[pointer int pointer uint], :int
    end
  end
end
