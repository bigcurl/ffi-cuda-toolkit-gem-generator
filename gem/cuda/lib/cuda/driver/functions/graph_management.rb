# frozen_string_literal: true

module Cuda
  module DriverApi
    module GraphManagement
      extend FFI::Library
      ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"
      attach_function :cuDeviceGetGraphMemAttribute, %i[pointer pointer pointer], :int
      attach_function :cuDeviceGraphMemTrim, [:pointer], :int
      attach_function :cuDeviceSetGraphMemAttribute, %i[pointer pointer pointer], :int
      attach_function :cuGraphAddChildGraphNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddDependencies, %i[pointer pointer pointer size_t], :int
      attach_function :cuGraphAddEmptyNode, %i[pointer pointer pointer size_t], :int
      attach_function :cuGraphAddEventRecordNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddEventWaitNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddExternalSemaphoresSignalNode, %i[pointer pointer pointer size_t pointer],
                      :int
      attach_function :cuGraphAddExternalSemaphoresWaitNode, %i[pointer pointer pointer size_t pointer],
                      :int
      attach_function :cuGraphAddHostNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddKernelNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddMemAllocNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddMemFreeNode, %i[pointer pointer pointer size_t pointer], :int
      attach_function :cuGraphAddMemcpyNode, %i[pointer pointer pointer size_t pointer pointer], :int
      attach_function :cuGraphAddMemsetNode, %i[pointer pointer pointer size_t pointer pointer], :int
      attach_function :cuGraphChildGraphNodeGetGraph, %i[pointer pointer], :int
      attach_function :cuGraphClone, %i[pointer pointer], :int
      attach_function :cuGraphCreate, %i[pointer uint], :int
      attach_function :cuGraphDebugDotPrint, %i[pointer pointer uint], :int
      attach_function :cuGraphDestroy, [:pointer], :int
      attach_function :cuGraphDestroyNode, [:pointer], :int
      attach_function :cuGraphEventRecordNodeGetEvent, %i[pointer pointer], :int
      attach_function :cuGraphEventRecordNodeSetEvent, %i[pointer pointer], :int
      attach_function :cuGraphEventWaitNodeGetEvent, %i[pointer pointer], :int
      attach_function :cuGraphEventWaitNodeSetEvent, %i[pointer pointer], :int
      attach_function :cuGraphExecChildGraphNodeSetParams, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecDestroy, [:pointer], :int
      attach_function :cuGraphExecEventRecordNodeSetEvent, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecEventWaitNodeSetEvent, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecExternalSemaphoresSignalNodeSetParams, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecExternalSemaphoresWaitNodeSetParams, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecHostNodeSetParams, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecKernelNodeSetParams, %i[pointer pointer pointer], :int
      attach_function :cuGraphExecMemcpyNodeSetParams, %i[pointer pointer pointer pointer], :int
      attach_function :cuGraphExecMemsetNodeSetParams, %i[pointer pointer pointer pointer], :int
      attach_function :cuGraphExecUpdate, %i[pointer pointer pointer pointer], :int
      attach_function :cuGraphExternalSemaphoresSignalNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphExternalSemaphoresSignalNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphExternalSemaphoresWaitNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphExternalSemaphoresWaitNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphGetEdges, %i[pointer pointer pointer pointer], :int
      attach_function :cuGraphGetNodes, %i[pointer pointer pointer], :int
      attach_function :cuGraphGetRootNodes, %i[pointer pointer pointer], :int
      attach_function :cuGraphHostNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphHostNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphInstantiate, %i[pointer pointer pointer pointer size_t], :int
      attach_function :cuGraphInstantiateWithFlags, %i[pointer pointer ulong_long], :int
      attach_function :cuGraphKernelNodeCopyAttributes, %i[pointer pointer], :int
      attach_function :cuGraphKernelNodeGetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuGraphKernelNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphKernelNodeSetAttribute, %i[pointer pointer pointer], :int
      attach_function :cuGraphKernelNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphLaunch, %i[pointer pointer], :int
      attach_function :cuGraphMemAllocNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphMemFreeNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphMemcpyNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphMemcpyNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphMemsetNodeGetParams, %i[pointer pointer], :int
      attach_function :cuGraphMemsetNodeSetParams, %i[pointer pointer], :int
      attach_function :cuGraphNodeFindInClone, %i[pointer pointer pointer], :int
      attach_function :cuGraphNodeGetDependencies, %i[pointer pointer pointer], :int
      attach_function :cuGraphNodeGetDependentNodes, %i[pointer pointer pointer], :int
      attach_function :cuGraphNodeGetType, %i[pointer pointer], :int
      attach_function :cuGraphReleaseUserObject, %i[pointer pointer uint], :int
      attach_function :cuGraphRemoveDependencies, %i[pointer pointer pointer size_t], :int
      attach_function :cuGraphRetainUserObject, %i[pointer pointer uint uint], :int
      attach_function :cuGraphUpload, %i[pointer pointer], :int
      attach_function :cuUserObjectCreate, %i[pointer pointer pointer uint uint], :int
      attach_function :cuUserObjectRelease, %i[pointer uint], :int
      attach_function :cuUserObjectRetain, %i[pointer uint], :int
    end
  end
end
