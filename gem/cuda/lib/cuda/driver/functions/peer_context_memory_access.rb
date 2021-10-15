# frozen_string_literal: true

module Cuda
  module DriverApi
    module PeerContextMemoryAccess
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuCtxDisablePeerAccess, [:pointer], :int
      attach_function :cuCtxEnablePeerAccess, %i[pointer uint], :int
      attach_function :cuDeviceCanAccessPeer, %i[pointer pointer pointer], :int
      attach_function :cuDeviceGetP2PAttribute, %i[pointer pointer pointer pointer], :int
    end
  end
end
