# frozen_string_literal: true

module Cuda
  module DriverApi
    module GraphManagement
      include Cuda::DriverApi :Enums

      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

      attach_function :cuDeviceGetGraphMemAttribute, %i[pointer pointer pointer], :CUresult
      attach_function :cuDeviceGraphMemTrim, [:pointer], :CUresult
      attach_function :cuDeviceSetGraphMemAttribute, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphAddChildGraphNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddDependencies, %i[pointer pointer pointer size_t], :CUresult
      attach_function :cuGraphAddEmptyNode, %i[pointer pointer pointer size_t], :CUresult
      attach_function :cuGraphAddEventRecordNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddEventWaitNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddExternalSemaphoresSignalNode, %i[pointer pointer pointer size_t pointer],
                      :CUresult
      attach_function :cuGraphAddExternalSemaphoresWaitNode, %i[pointer pointer pointer size_t pointer],
                      :CUresult
      attach_function :cuGraphAddHostNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddKernelNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddMemAllocNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddMemFreeNode, %i[pointer pointer pointer size_t pointer], :CUresult
      attach_function :cuGraphAddMemcpyNode, %i[pointer pointer pointer size_t pointer pointer],
                      :CUresult
      attach_function :cuGraphAddMemsetNode, %i[pointer pointer pointer size_t pointer pointer],
                      :CUresult
      attach_function :cuGraphChildGraphNodeGetGraph, %i[pointer pointer], :CUresult
      attach_function :cuGraphClone, %i[pointer pointer], :CUresult
      attach_function :cuGraphCreate, %i[pointer uint], :CUresult
      attach_function :cuGraphDebugDotPrint, %i[pointer pointer uint], :CUresult
      attach_function :cuGraphDestroy, [:pointer], :CUresult
      attach_function :cuGraphDestroyNode, [:pointer], :CUresult
      attach_function :cuGraphEventRecordNodeGetEvent, %i[pointer pointer], :CUresult
      attach_function :cuGraphEventRecordNodeSetEvent, %i[pointer pointer], :CUresult
      attach_function :cuGraphEventWaitNodeGetEvent, %i[pointer pointer], :CUresult
      attach_function :cuGraphEventWaitNodeSetEvent, %i[pointer pointer], :CUresult
      attach_function :cuGraphExecChildGraphNodeSetParams, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecDestroy, [:pointer], :CUresult
      attach_function :cuGraphExecEventRecordNodeSetEvent, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecEventWaitNodeSetEvent, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecExternalSemaphoresSignalNodeSetParams, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecExternalSemaphoresWaitNodeSetParams, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecHostNodeSetParams, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecKernelNodeSetParams, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphExecMemcpyNodeSetParams, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuGraphExecMemsetNodeSetParams, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuGraphExecUpdate, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuGraphExternalSemaphoresSignalNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphExternalSemaphoresSignalNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphExternalSemaphoresWaitNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphExternalSemaphoresWaitNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphGetEdges, %i[pointer pointer pointer pointer], :CUresult
      attach_function :cuGraphGetNodes, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphGetRootNodes, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphHostNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphHostNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphInstantiate, %i[pointer pointer pointer pointer size_t], :CUresult
      attach_function :cuGraphInstantiateWithFlags, %i[pointer pointer ulong_long], :CUresult
      attach_function :cuGraphKernelNodeCopyAttributes, %i[pointer pointer], :CUresult
      attach_function :cuGraphKernelNodeGetAttribute, %i[pointer CUkernelNodeAttrID pointer], :CUresult
      attach_function :cuGraphKernelNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphKernelNodeSetAttribute, %i[pointer CUkernelNodeAttrID pointer], :CUresult
      attach_function :cuGraphKernelNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphLaunch, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemAllocNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemFreeNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemcpyNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemcpyNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemsetNodeGetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphMemsetNodeSetParams, %i[pointer pointer], :CUresult
      attach_function :cuGraphNodeFindInClone, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphNodeGetDependencies, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphNodeGetDependentNodes, %i[pointer pointer pointer], :CUresult
      attach_function :cuGraphNodeGetType, %i[pointer pointer], :CUresult
      attach_function :cuGraphReleaseUserObject, %i[pointer pointer uint], :CUresult
      attach_function :cuGraphRemoveDependencies, %i[pointer pointer pointer size_t], :CUresult
      attach_function :cuGraphRetainUserObject, %i[pointer pointer uint uint], :CUresult
      attach_function :cuGraphUpload, %i[pointer pointer], :CUresult
      attach_function :cuUserObjectCreate, %i[pointer pointer pointer uint uint], :CUresult
      attach_function :cuUserObjectRelease, %i[pointer uint], :CUresult
      attach_function :cuUserObjectRetain, %i[pointer uint], :CUresult
    end
  end
end
