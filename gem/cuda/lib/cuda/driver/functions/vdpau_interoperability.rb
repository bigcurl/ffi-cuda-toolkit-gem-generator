# frozen_string_literal: true

module Cuda
  module DriverApi
    module VdpauInteroperability
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuGraphicsVDPAURegisterOutputSurface, %i[pointer pointer uint], :int
      attach_function :cuGraphicsVDPAURegisterVideoSurface, %i[pointer pointer uint], :int
      attach_function :cuVDPAUCtxCreate, %i[pointer uint pointer pointer pointer], :int
      attach_function :cuVDPAUGetDevice, %i[pointer pointer pointer], :int
    end
  end
end
