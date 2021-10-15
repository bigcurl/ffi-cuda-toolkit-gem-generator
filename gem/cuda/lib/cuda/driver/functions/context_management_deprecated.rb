# frozen_string_literal: true

module Cuda
  module DriverApi
    module ContextManagementDeprecated
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuCtxAttach, %i[pointer uint], :int
      attach_function :cuCtxDetach, [:pointer], :int
    end
  end
end