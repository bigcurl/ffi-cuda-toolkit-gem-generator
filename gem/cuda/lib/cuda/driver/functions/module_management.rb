# frozen_string_literal: true

module Cuda
  module DriverApi
    module ModuleManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuLinkAddData,
                      %i[pointer pointer pointer size_t pointer uint pointer pointer], :int
      attach_function :cuLinkAddFile, %i[pointer pointer pointer uint pointer pointer], :int
      attach_function :cuLinkComplete, %i[pointer pointer pointer], :int
      attach_function :cuLinkCreate, %i[uint pointer pointer pointer], :int
      attach_function :cuLinkDestroy, [:pointer], :int
      attach_function :cuModuleGetFunction, %i[pointer pointer pointer], :int
      attach_function :cuModuleGetGlobal, %i[pointer pointer pointer pointer], :int
      attach_function :cuModuleGetSurfRef, %i[pointer pointer pointer], :int
      attach_function :cuModuleGetTexRef, %i[pointer pointer pointer], :int
      attach_function :cuModuleLoad, %i[pointer pointer], :int
      attach_function :cuModuleLoadData, %i[pointer pointer], :int
      attach_function :cuModuleLoadDataEx, %i[pointer pointer uint pointer pointer], :int
      attach_function :cuModuleLoadFatBinary, %i[pointer pointer], :int
      attach_function :cuModuleUnload, [:pointer], :int
    end
  end
end
