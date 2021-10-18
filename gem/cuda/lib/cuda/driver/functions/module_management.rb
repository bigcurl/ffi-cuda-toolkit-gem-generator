# frozen_string_literal: true

module Cuda
  module DriverApi
    module ModuleManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuLinkAddData,
                      %i[pointer CUjitInputType pointer size_t pointer uint pointer pointer], :CUresult
      attach_function :cuLinkAddFile, %i[pointer CUjitInputType pointer uint pointer pointer], :CUresult
      attach_function :cuLinkComplete, %i[pointer pointer pointer], :CUresult
      attach_function :cuLinkCreate, %i[uint pointer pointer pointer], :CUresult
      attach_function :cuLinkDestroy, [:pointer], :CUresult
      attach_function :cuModuleGetFunction, %i[pointer pointer pointer], :CUresult
      attach_function :cuModuleGetGlobal, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuModuleGetSurfRef, %i[pointer pointer pointer], :CUresult
      attach_function :cuModuleGetTexRef, %i[pointer pointer pointer], :CUresult
      attach_function :cuModuleLoad, %i[pointer pointer], :CUresult
      attach_function :cuModuleLoadData, %i[pointer pointer], :CUresult
      attach_function :cuModuleLoadDataEx, %i[pointer pointer uint pointer pointer], :CUresult
      attach_function :cuModuleLoadFatBinary, %i[pointer pointer], :CUresult
      attach_function :cuModuleUnload, [:pointer], :CUresult
    end
  end
end
