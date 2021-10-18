# frozen_string_literal: true

module Cuda
  module DriverApi
    module ExecutionControlDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuFuncSetBlockShape, %i[pointer int int int], :CUresult
      attach_function :cuFuncSetSharedSize, %i[pointer uint], :CUresult
      attach_function :cuLaunch, [:pointer], :CUresult
      attach_function :cuLaunchGrid, %i[pointer int int], :CUresult
      attach_function :cuLaunchGridAsync, %i[pointer int int pointer], :CUresult
      attach_function :cuParamSetSize, %i[pointer uint], :CUresult
      attach_function :cuParamSetTexRef, %i[pointer int pointer], :CUresult
      attach_function :cuParamSetf, %i[pointer int float], :CUresult
      attach_function :cuParamSeti, %i[pointer int uint], :CUresult
      attach_function :cuParamSetv, %i[pointer int pointer uint], :CUresult
    end
  end
end
