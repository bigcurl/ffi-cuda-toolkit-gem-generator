# frozen_string_literal: true

module Cuda
  module DriverApi
    module DriverEntryPointAccess
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGetProcAddress, %i[pointer pointer int pointer], :int
    end
  end
end
