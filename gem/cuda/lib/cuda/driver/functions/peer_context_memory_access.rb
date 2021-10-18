# frozen_string_literal: true

module Cuda
  module DriverApi
    module PeerContextMemoryAccess
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuCtxDisablePeerAccess, [:pointer], :CUresult
      attach_function :cuCtxEnablePeerAccess, %i[pointer uint], :CUresult
      attach_function :cuDeviceCanAccessPeer, %i[pointer pointer pointer], :CUresult
      attach_function :cuDeviceGetP2PAttribute, %i[pointer CUdevice_P2PAttribute pointer pointer], :CUresult
    end
  end
end
