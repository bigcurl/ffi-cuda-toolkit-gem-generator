# frozen_string_literal: true

# rubocop:disable Naming/VariableNumber
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Style/NumericLiterals

module Cuda
  module DriverApi
    extend FFI::Library
    binary_list = `whereis -b libcuda`.strip.split('libcuda: ')
    binary_path = '/usr/lib/x86_64-linux-gnu/libcuda.so'
    binary_path = binary_list[1] unless binary_list[1].nil?
    ffi_lib binary_path

    # TODO: Missing Unions, Structs, FunctionTypes

    # Fundamental Typedefs
    typedef :ulong_long, :long_unsigned_int
    typedef :int, :int
    typedef :float, :float
    typedef :double, :double
    typedef :long, :long_int
    typedef :long_long, :long_long_int
    typedef :ulong_long, :long_long_unsigned_int
    typedef :uchar, :unsigned_char
    typedef :ushort, :short_unsigned_int
    typedef :uint, :unsigned_int
    typedef :char, :signed_char
    typedef :short, :short_int
    typedef :pointer, :void
    typedef :char, :char

    # Typedefs
    typedef :uint32_t, :cuuint32_t
    typedef :uint64_t, :cuuint64_t
    typedef :long_long_unsigned_int, :CUdeviceptr_v2
    typedef :CUdeviceptr_v2, :CUdeviceptr
    typedef :int, :CUdevice_v1
    typedef :CUdevice_v1, :CUdevice
    typedef :CUctx_st, :CUcontext
    typedef :CUmod_st, :CUmodule
    typedef :CUfunc_st, :CUfunction
    typedef :CUarray_st, :CUarray
    typedef :CUmipmappedArray_st, :CUmipmappedArray
    typedef :CUtexref_st, :CUtexref
    typedef :CUsurfref_st, :CUsurfref
    typedef :CUevent_st, :CUevent
    typedef :CUstream_st, :CUstream
    typedef :CUgraphicsResource_st, :CUgraphicsResource
    typedef :long_long_unsigned_int, :CUtexObject_v1
    typedef :CUtexObject_v1, :CUtexObject
    typedef :long_long_unsigned_int, :CUsurfObject_v1
    typedef :CUsurfObject_v1, :CUsurfObject
    typedef :CUextMemory_st, :CUexternalMemory
    typedef :CUextSemaphore_st, :CUexternalSemaphore
    typedef :CUgraph_st, :CUgraph
    typedef :CUgraphNode_st, :CUgraphNode
    typedef :CUgraphExec_st, :CUgraphExec
    typedef :CUmemPoolHandle_st, :CUmemoryPool
    typedef :CUuserObject_st, :CUuserObject
    typedef :CUuuid_st, :CUuuid
    typedef :CUipcEventHandle_st, :CUipcEventHandle_v1
    typedef :CUipcEventHandle_v1, :CUipcEventHandle
    typedef :CUipcMemHandle_st, :CUipcMemHandle_v1
    typedef :CUipcMemHandle_v1, :CUipcMemHandle
    typedef :CUipcMem_flags_enum, :CUipcMem_flags
    typedef :CUmemAttach_flags_enum, :CUmemAttach_flags
    typedef :CUctx_flags_enum, :CUctx_flags
    typedef :CUstream_flags_enum, :CUstream_flags
    typedef :CUevent_flags_enum, :CUevent_flags
    typedef :CUevent_record_flags_enum, :CUevent_record_flags
    typedef :CUevent_wait_flags_enum, :CUevent_wait_flags
    typedef :CUstreamWaitValue_flags_enum, :CUstreamWaitValue_flags
    typedef :CUstreamWriteValue_flags_enum, :CUstreamWriteValue_flags
    typedef :CUstreamBatchMemOpType_enum, :CUstreamBatchMemOpType
    typedef :CUstreamBatchMemOpParams_union, :CUstreamBatchMemOpParams_v1
    typedef :CUstreamBatchMemOpParams_v1, :CUstreamBatchMemOpParams
    typedef :CUoccupancy_flags_enum, :CUoccupancy_flags
    typedef :CUstreamUpdateCaptureDependencies_flags_enum, :CUstreamUpdateCaptureDependencies_flags
    typedef :CUarray_format_enum, :CUarray_format
    typedef :CUaddress_mode_enum, :CUaddress_mode
    typedef :CUfilter_mode_enum, :CUfilter_mode
    typedef :CUdevice_attribute_enum, :CUdevice_attribute
    typedef :CUdevprop_st, :CUdevprop_v1
    typedef :CUdevprop_v1, :CUdevprop
    typedef :CUpointer_attribute_enum, :CUpointer_attribute
    typedef :CUfunction_attribute_enum, :CUfunction_attribute
    typedef :CUfunc_cache_enum, :CUfunc_cache
    typedef :CUsharedconfig_enum, :CUsharedconfig
    typedef :CUshared_carveout_enum, :CUshared_carveout
    typedef :CUmemorytype_enum, :CUmemorytype
    typedef :CUcomputemode_enum, :CUcomputemode
    typedef :CUmem_advise_enum, :CUmem_advise
    typedef :CUmem_range_attribute_enum, :CUmem_range_attribute
    typedef :CUjit_option_enum, :CUjit_option
    typedef :CUjit_target_enum, :CUjit_target
    typedef :CUjit_fallback_enum, :CUjit_fallback
    typedef :CUjit_cacheMode_enum, :CUjit_cacheMode
    typedef :CUjitInputType_enum, :CUjitInputType
    typedef :CUlinkState_st, :CUlinkState
    typedef :CUgraphicsRegisterFlags_enum, :CUgraphicsRegisterFlags
    typedef :CUgraphicsMapResourceFlags_enum, :CUgraphicsMapResourceFlags
    typedef :CUarray_cubemap_face_enum, :CUarray_cubemap_face
    typedef :CUlimit_enum, :CUlimit
    typedef :CUresourcetype_enum, :CUresourcetype
    typedef :pointer, :CUhostFn
    typedef :CUaccessProperty_enum, :CUaccessProperty
    typedef :CUaccessPolicyWindow_st, :CUaccessPolicyWindow_v1
    typedef :CUaccessPolicyWindow_v1, :CUaccessPolicyWindow
    typedef :CUDA_KERNEL_NODE_PARAMS_st, :CUDA_KERNEL_NODE_PARAMS_v1
    typedef :CUDA_KERNEL_NODE_PARAMS_v1, :CUDA_KERNEL_NODE_PARAMS
    typedef :CUDA_MEMSET_NODE_PARAMS_st, :CUDA_MEMSET_NODE_PARAMS_v1
    typedef :CUDA_MEMSET_NODE_PARAMS_v1, :CUDA_MEMSET_NODE_PARAMS
    typedef :CUDA_HOST_NODE_PARAMS_st, :CUDA_HOST_NODE_PARAMS_v1
    typedef :CUDA_HOST_NODE_PARAMS_v1, :CUDA_HOST_NODE_PARAMS
    typedef :CUgraphNodeType_enum, :CUgraphNodeType
    typedef :CUsynchronizationPolicy_enum, :CUsynchronizationPolicy
    typedef :CUkernelNodeAttrID_enum, :CUkernelNodeAttrID
    typedef :CUkernelNodeAttrValue_union, :CUkernelNodeAttrValue_v1
    typedef :CUkernelNodeAttrValue_v1, :CUkernelNodeAttrValue
    typedef :CUstreamCaptureStatus_enum, :CUstreamCaptureStatus
    typedef :CUstreamCaptureMode_enum, :CUstreamCaptureMode
    typedef :CUstreamAttrID_enum, :CUstreamAttrID
    typedef :CUstreamAttrValue_union, :CUstreamAttrValue_v1
    typedef :CUstreamAttrValue_v1, :CUstreamAttrValue
    typedef :CUdriverProcAddress_flags_enum, :CUdriverProcAddress_flags
    typedef :CUexecAffinityType_enum, :CUexecAffinityType
    typedef :CUexecAffinitySmCount_st, :CUexecAffinitySmCount_v1
    typedef :CUexecAffinitySmCount_v1, :CUexecAffinitySmCount
    typedef :CUexecAffinityParam_st, :CUexecAffinityParam_v1
    typedef :CUexecAffinityParam_v1, :CUexecAffinityParam
    typedef :cudaError_enum, :CUresult
    typedef :CUdevice_P2PAttribute_enum, :CUdevice_P2PAttribute
    typedef :pointer, :CUstreamCallback
    typedef :pointer, :CUoccupancyB2DSize
    typedef :CUDA_MEMCPY2D_st, :CUDA_MEMCPY2D_v2
    typedef :CUDA_MEMCPY2D_v2, :CUDA_MEMCPY2D
    typedef :CUDA_MEMCPY3D_st, :CUDA_MEMCPY3D_v2
    typedef :CUDA_MEMCPY3D_v2, :CUDA_MEMCPY3D
    typedef :CUDA_MEMCPY3D_PEER_st, :CUDA_MEMCPY3D_PEER_v1
    typedef :CUDA_MEMCPY3D_PEER_v1, :CUDA_MEMCPY3D_PEER
    typedef :CUDA_ARRAY_DESCRIPTOR_st, :CUDA_ARRAY_DESCRIPTOR_v2
    typedef :CUDA_ARRAY_DESCRIPTOR_v2, :CUDA_ARRAY_DESCRIPTOR
    typedef :CUDA_ARRAY3D_DESCRIPTOR_st, :CUDA_ARRAY3D_DESCRIPTOR_v2
    typedef :CUDA_ARRAY3D_DESCRIPTOR_v2, :CUDA_ARRAY3D_DESCRIPTOR
    typedef :CUDA_ARRAY_SPARSE_PROPERTIES_st, :CUDA_ARRAY_SPARSE_PROPERTIES_v1
    typedef :CUDA_ARRAY_SPARSE_PROPERTIES_v1, :CUDA_ARRAY_SPARSE_PROPERTIES
    typedef :CUDA_RESOURCE_DESC_st, :CUDA_RESOURCE_DESC_v1
    typedef :CUDA_RESOURCE_DESC_v1, :CUDA_RESOURCE_DESC
    typedef :CUDA_TEXTURE_DESC_st, :CUDA_TEXTURE_DESC_v1
    typedef :CUDA_TEXTURE_DESC_v1, :CUDA_TEXTURE_DESC
    typedef :CUresourceViewFormat_enum, :CUresourceViewFormat
    typedef :CUDA_RESOURCE_VIEW_DESC_st, :CUDA_RESOURCE_VIEW_DESC_v1
    typedef :CUDA_RESOURCE_VIEW_DESC_v1, :CUDA_RESOURCE_VIEW_DESC
    typedef :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st, :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1
    typedef :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1, :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS
    typedef :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum, :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS
    typedef :CUDA_LAUNCH_PARAMS_st, :CUDA_LAUNCH_PARAMS_v1
    typedef :CUDA_LAUNCH_PARAMS_v1, :CUDA_LAUNCH_PARAMS
    typedef :CUexternalMemoryHandleType_enum, :CUexternalMemoryHandleType
    typedef :CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st, :CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1, :CUDA_EXTERNAL_MEMORY_HANDLE_DESC
    typedef :CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st, :CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1, :CUDA_EXTERNAL_MEMORY_BUFFER_DESC
    typedef :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st, :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1, :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC
    typedef :CUexternalSemaphoreHandleType_enum, :CUexternalSemaphoreHandleType
    typedef :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st, :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1, :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC
    typedef :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st, :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1, :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS
    typedef :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st, :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1, :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS
    typedef :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_st, :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1
    typedef :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1, :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS
    typedef :CUDA_EXT_SEM_WAIT_NODE_PARAMS_st, :CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1
    typedef :CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1, :CUDA_EXT_SEM_WAIT_NODE_PARAMS
    typedef :long_long_unsigned_int, :CUmemGenericAllocationHandle_v1
    typedef :CUmemGenericAllocationHandle_v1, :CUmemGenericAllocationHandle
    typedef :CUmemAllocationHandleType_enum, :CUmemAllocationHandleType
    typedef :CUmemAccess_flags_enum, :CUmemAccess_flags
    typedef :CUmemLocationType_enum, :CUmemLocationType
    typedef :CUmemAllocationType_enum, :CUmemAllocationType
    typedef :CUmemAllocationGranularity_flags_enum, :CUmemAllocationGranularity_flags
    typedef :CUarraySparseSubresourceType_enum, :CUarraySparseSubresourceType
    typedef :CUmemOperationType_enum, :CUmemOperationType
    typedef :CUmemHandleType_enum, :CUmemHandleType
    typedef :CUarrayMapInfo_st, :CUarrayMapInfo_v1
    typedef :CUarrayMapInfo_v1, :CUarrayMapInfo
    typedef :CUmemLocation_st, :CUmemLocation_v1
    typedef :CUmemLocation_v1, :CUmemLocation
    typedef :CUmemAllocationCompType_enum, :CUmemAllocationCompType
    typedef :CUmemAllocationProp_st, :CUmemAllocationProp_v1
    typedef :CUmemAllocationProp_v1, :CUmemAllocationProp
    typedef :CUmemAccessDesc_st, :CUmemAccessDesc_v1
    typedef :CUmemAccessDesc_v1, :CUmemAccessDesc
    typedef :CUgraphExecUpdateResult_enum, :CUgraphExecUpdateResult
    typedef :CUmemPool_attribute_enum, :CUmemPool_attribute
    typedef :CUmemPoolProps_st, :CUmemPoolProps_v1
    typedef :CUmemPoolProps_v1, :CUmemPoolProps
    typedef :CUmemPoolPtrExportData_st, :CUmemPoolPtrExportData_v1
    typedef :CUmemPoolPtrExportData_v1, :CUmemPoolPtrExportData
    typedef :CUDA_MEM_ALLOC_NODE_PARAMS_st, :CUDA_MEM_ALLOC_NODE_PARAMS
    typedef :CUgraphMem_attribute_enum, :CUgraphMem_attribute
    typedef :CUflushGPUDirectRDMAWritesOptions_enum, :CUflushGPUDirectRDMAWritesOptions
    typedef :CUGPUDirectRDMAWritesOrdering_enum, :CUGPUDirectRDMAWritesOrdering
    typedef :CUflushGPUDirectRDMAWritesScope_enum, :CUflushGPUDirectRDMAWritesScope
    typedef :CUflushGPUDirectRDMAWritesTarget_enum, :CUflushGPUDirectRDMAWritesTarget
    typedef :CUgraphDebugDot_flags_enum, :CUgraphDebugDot_flags
    typedef :CUuserObject_flags_enum, :CUuserObject_flags
    typedef :CUuserObjectRetain_flags_enum, :CUuserObjectRetain_flags
    typedef :CUgraphInstantiate_flags_enum, :CUgraphInstantiate_flags

    # Enums
    enum :CUipcMem_flags_enum, [:CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS, 1]
    enum :CUmemAttach_flags_enum, [:CU_MEM_ATTACH_GLOBAL, 1,
                                   :CU_MEM_ATTACH_HOST, 2,
                                   :CU_MEM_ATTACH_SINGLE, 4]
    enum :CUctx_flags_enum, [:CU_CTX_SCHED_AUTO, 0,
                             :CU_CTX_SCHED_SPIN, 1,
                             :CU_CTX_SCHED_YIELD, 2,
                             :CU_CTX_SCHED_BLOCKING_SYNC, 4,
                             :CU_CTX_BLOCKING_SYNC, 4,
                             :CU_CTX_SCHED_MASK, 7,
                             :CU_CTX_MAP_HOST, 8,
                             :CU_CTX_LMEM_RESIZE_TO_MAX, 16,
                             :CU_CTX_FLAGS_MASK, 31]
    enum :CUstream_flags_enum, [:CU_STREAM_DEFAULT, 0,
                                :CU_STREAM_NON_BLOCKING, 1]
    enum :CUevent_flags_enum, [:CU_EVENT_DEFAULT, 0,
                               :CU_EVENT_BLOCKING_SYNC, 1,
                               :CU_EVENT_DISABLE_TIMING, 2,
                               :CU_EVENT_INTERPROCESS, 4]
    enum :CUevent_record_flags_enum, [:CU_EVENT_RECORD_DEFAULT, 0,
                                      :CU_EVENT_RECORD_EXTERNAL, 1]
    enum :CUevent_wait_flags_enum, [:CU_EVENT_WAIT_DEFAULT, 0,
                                    :CU_EVENT_WAIT_EXTERNAL, 1]
    enum :CUstreamWaitValue_flags_enum, [:CU_STREAM_WAIT_VALUE_GEQ, 0,
                                         :CU_STREAM_WAIT_VALUE_EQ, 1,
                                         :CU_STREAM_WAIT_VALUE_AND, 2,
                                         :CU_STREAM_WAIT_VALUE_NOR, 3,
                                         :CU_STREAM_WAIT_VALUE_FLUSH, 1073741824]
    enum :CUstreamWriteValue_flags_enum, [:CU_STREAM_WRITE_VALUE_DEFAULT, 0,
                                          :CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER, 1]
    enum :CUstreamBatchMemOpType_enum, [:CU_STREAM_MEM_OP_WAIT_VALUE_32, 1,
                                        :CU_STREAM_MEM_OP_WRITE_VALUE_32, 2,
                                        :CU_STREAM_MEM_OP_WAIT_VALUE_64, 4,
                                        :CU_STREAM_MEM_OP_WRITE_VALUE_64, 5,
                                        :CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES, 3]
    enum :CUoccupancy_flags_enum, [:CU_OCCUPANCY_DEFAULT, 0,
                                   :CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE, 1]
    enum :CUstreamUpdateCaptureDependencies_flags_enum, [:CU_STREAM_ADD_CAPTURE_DEPENDENCIES, 0,
                                                         :CU_STREAM_SET_CAPTURE_DEPENDENCIES, 1]
    enum :CUarray_format_enum, [:CU_AD_FORMAT_UNSIGNED_INT8, 1,
                                :CU_AD_FORMAT_UNSIGNED_INT16, 2,
                                :CU_AD_FORMAT_UNSIGNED_INT32, 3,
                                :CU_AD_FORMAT_SIGNED_INT8, 8,
                                :CU_AD_FORMAT_SIGNED_INT16, 9,
                                :CU_AD_FORMAT_SIGNED_INT32, 10,
                                :CU_AD_FORMAT_HALF, 16,
                                :CU_AD_FORMAT_FLOAT, 32,
                                :CU_AD_FORMAT_NV12, 176,
                                :CU_AD_FORMAT_UNORM_INT8X1, 192,
                                :CU_AD_FORMAT_UNORM_INT8X2, 193,
                                :CU_AD_FORMAT_UNORM_INT8X4, 194,
                                :CU_AD_FORMAT_UNORM_INT16X1, 195,
                                :CU_AD_FORMAT_UNORM_INT16X2, 196,
                                :CU_AD_FORMAT_UNORM_INT16X4, 197,
                                :CU_AD_FORMAT_SNORM_INT8X1, 198,
                                :CU_AD_FORMAT_SNORM_INT8X2, 199,
                                :CU_AD_FORMAT_SNORM_INT8X4, 200,
                                :CU_AD_FORMAT_SNORM_INT16X1, 201,
                                :CU_AD_FORMAT_SNORM_INT16X2, 202,
                                :CU_AD_FORMAT_SNORM_INT16X4, 203,
                                :CU_AD_FORMAT_BC1_UNORM, 145,
                                :CU_AD_FORMAT_BC1_UNORM_SRGB, 146,
                                :CU_AD_FORMAT_BC2_UNORM, 147,
                                :CU_AD_FORMAT_BC2_UNORM_SRGB, 148,
                                :CU_AD_FORMAT_BC3_UNORM, 149,
                                :CU_AD_FORMAT_BC3_UNORM_SRGB, 150,
                                :CU_AD_FORMAT_BC4_UNORM, 151,
                                :CU_AD_FORMAT_BC4_SNORM, 152,
                                :CU_AD_FORMAT_BC5_UNORM, 153,
                                :CU_AD_FORMAT_BC5_SNORM, 154,
                                :CU_AD_FORMAT_BC6H_UF16, 155,
                                :CU_AD_FORMAT_BC6H_SF16, 156,
                                :CU_AD_FORMAT_BC7_UNORM, 157,
                                :CU_AD_FORMAT_BC7_UNORM_SRGB, 158]
    enum :CUaddress_mode_enum, [:CU_TR_ADDRESS_MODE_WRAP, 0,
                                :CU_TR_ADDRESS_MODE_CLAMP, 1,
                                :CU_TR_ADDRESS_MODE_MIRROR, 2,
                                :CU_TR_ADDRESS_MODE_BORDER, 3]
    enum :CUfilter_mode_enum, [:CU_TR_FILTER_MODE_POINT, 0,
                               :CU_TR_FILTER_MODE_LINEAR, 1]
    enum :CUdevice_attribute_enum, [:CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK, 1,
                                    :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X, 2,
                                    :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y, 3,
                                    :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z, 4,
                                    :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X, 5,
                                    :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y, 6,
                                    :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z, 7,
                                    :CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK, 8,
                                    :CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK, 8,
                                    :CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY, 9,
                                    :CU_DEVICE_ATTRIBUTE_WARP_SIZE, 10,
                                    :CU_DEVICE_ATTRIBUTE_MAX_PITCH, 11,
                                    :CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK, 12,
                                    :CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK, 12,
                                    :CU_DEVICE_ATTRIBUTE_CLOCK_RATE, 13,
                                    :CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT, 14,
                                    :CU_DEVICE_ATTRIBUTE_GPU_OVERLAP, 15,
                                    :CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT, 16,
                                    :CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT, 17,
                                    :CU_DEVICE_ATTRIBUTE_INTEGRATED, 18,
                                    :CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY, 19,
                                    :CU_DEVICE_ATTRIBUTE_COMPUTE_MODE, 20,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH, 21,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH, 22,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT, 23,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH, 24,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT, 25,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH, 26,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH, 27,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT, 28,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS, 29,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH, 27,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT, 28,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES, 29,
                                    :CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT, 30,
                                    :CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS, 31,
                                    :CU_DEVICE_ATTRIBUTE_ECC_ENABLED, 32,
                                    :CU_DEVICE_ATTRIBUTE_PCI_BUS_ID, 33,
                                    :CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID, 34,
                                    :CU_DEVICE_ATTRIBUTE_TCC_DRIVER, 35,
                                    :CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE, 36,
                                    :CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH, 37,
                                    :CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE, 38,
                                    :CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR, 39,
                                    :CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT, 40,
                                    :CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING, 41,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH, 42,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS, 43,
                                    :CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER, 44,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH, 45,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT, 46,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE, 47,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE, 48,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE, 49,
                                    :CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID, 50,
                                    :CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT, 51,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH, 52,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH, 53,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS, 54,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH, 55,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH, 56,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT, 57,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH, 58,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT, 59,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH, 60,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH, 61,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS, 62,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH, 63,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT, 64,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS, 65,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH, 66,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH, 67,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS, 68,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH, 69,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH, 70,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT, 71,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH, 72,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH, 73,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT, 74,
                                    :CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, 75,
                                    :CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, 76,
                                    :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH, 77,
                                    :CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED, 78,
                                    :CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED, 79,
                                    :CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED, 80,
                                    :CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR, 81,
                                    :CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR, 82,
                                    :CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY, 83,
                                    :CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD, 84,
                                    :CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID, 85,
                                    :CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED, 86,
                                    :CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO, 87,
                                    :CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS, 88,
                                    :CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS, 89,
                                    :CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED, 90,
                                    :CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM, 91,
                                    :CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS, 92,
                                    :CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS, 93,
                                    :CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR, 94,
                                    :CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH, 95,
                                    :CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH, 96,
                                    :CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN, 97,
                                    :CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES, 98,
                                    :CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED, 99,
                                    :CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES, 100,
                                    :CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST, 101,
                                    :CU_DEVICE_ATTRIBUTE_VIRTUAL_ADDRESS_MANAGEMENT_SUPPORTED, 102,
                                    :CU_DEVICE_ATTRIBUTE_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED, 102,
                                    :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR_SUPPORTED, 103,
                                    :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_HANDLE_SUPPORTED, 104,
                                    :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_KMT_HANDLE_SUPPORTED, 105,
                                    :CU_DEVICE_ATTRIBUTE_MAX_BLOCKS_PER_MULTIPROCESSOR, 106,
                                    :CU_DEVICE_ATTRIBUTE_GENERIC_COMPRESSION_SUPPORTED, 107,
                                    :CU_DEVICE_ATTRIBUTE_MAX_PERSISTING_L2_CACHE_SIZE, 108,
                                    :CU_DEVICE_ATTRIBUTE_MAX_ACCESS_POLICY_WINDOW_SIZE, 109,
                                    :CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WITH_CUDA_VMM_SUPPORTED, 110,
                                    :CU_DEVICE_ATTRIBUTE_RESERVED_SHARED_MEMORY_PER_BLOCK, 111,
                                    :CU_DEVICE_ATTRIBUTE_SPARSE_CUDA_ARRAY_SUPPORTED, 112,
                                    :CU_DEVICE_ATTRIBUTE_READ_ONLY_HOST_REGISTER_SUPPORTED, 113,
                                    :CU_DEVICE_ATTRIBUTE_TIMELINE_SEMAPHORE_INTEROP_SUPPORTED, 114,
                                    :CU_DEVICE_ATTRIBUTE_MEMORY_POOLS_SUPPORTED, 115,
                                    :CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_SUPPORTED, 116,
                                    :CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_FLUSH_WRITES_OPTIONS, 117,
                                    :CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WRITES_ORDERING, 118,
                                    :CU_DEVICE_ATTRIBUTE_MEMPOOL_SUPPORTED_HANDLE_TYPES, 119,
                                    :CU_DEVICE_ATTRIBUTE_MAX, 120]
    enum :CUpointer_attribute_enum, [:CU_POINTER_ATTRIBUTE_CONTEXT, 1,
                                     :CU_POINTER_ATTRIBUTE_MEMORY_TYPE, 2,
                                     :CU_POINTER_ATTRIBUTE_DEVICE_POINTER, 3,
                                     :CU_POINTER_ATTRIBUTE_HOST_POINTER, 4,
                                     :CU_POINTER_ATTRIBUTE_P2P_TOKENS, 5,
                                     :CU_POINTER_ATTRIBUTE_SYNC_MEMOPS, 6,
                                     :CU_POINTER_ATTRIBUTE_BUFFER_ID, 7,
                                     :CU_POINTER_ATTRIBUTE_IS_MANAGED, 8,
                                     :CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL, 9,
                                     :CU_POINTER_ATTRIBUTE_IS_LEGACY_CUDA_IPC_CAPABLE, 10,
                                     :CU_POINTER_ATTRIBUTE_RANGE_START_ADDR, 11,
                                     :CU_POINTER_ATTRIBUTE_RANGE_SIZE, 12,
                                     :CU_POINTER_ATTRIBUTE_MAPPED, 13,
                                     :CU_POINTER_ATTRIBUTE_ALLOWED_HANDLE_TYPES, 14,
                                     :CU_POINTER_ATTRIBUTE_IS_GPU_DIRECT_RDMA_CAPABLE, 15,
                                     :CU_POINTER_ATTRIBUTE_ACCESS_FLAGS, 16,
                                     :CU_POINTER_ATTRIBUTE_MEMPOOL_HANDLE, 17]
    enum :CUfunction_attribute_enum, [:CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, 0,
                                      :CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES, 1,
                                      :CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES, 2,
                                      :CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES, 3,
                                      :CU_FUNC_ATTRIBUTE_NUM_REGS, 4,
                                      :CU_FUNC_ATTRIBUTE_PTX_VERSION, 5,
                                      :CU_FUNC_ATTRIBUTE_BINARY_VERSION, 6,
                                      :CU_FUNC_ATTRIBUTE_CACHE_MODE_CA, 7,
                                      :CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES, 8,
                                      :CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT, 9,
                                      :CU_FUNC_ATTRIBUTE_MAX, 10]
    enum :CUfunc_cache_enum, [:CU_FUNC_CACHE_PREFER_NONE, 0,
                              :CU_FUNC_CACHE_PREFER_SHARED, 1,
                              :CU_FUNC_CACHE_PREFER_L1, 2,
                              :CU_FUNC_CACHE_PREFER_EQUAL, 3]
    enum :CUsharedconfig_enum, [:CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE, 0,
                                :CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE, 1,
                                :CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE, 2]
    enum :CUshared_carveout_enum, [:CU_SHAREDMEM_CARVEOUT_DEFAULT, -1,
                                   :CU_SHAREDMEM_CARVEOUT_MAX_SHARED, 100,
                                   :CU_SHAREDMEM_CARVEOUT_MAX_L1, 0]
    enum :CUmemorytype_enum, [:CU_MEMORYTYPE_HOST, 1,
                              :CU_MEMORYTYPE_DEVICE, 2,
                              :CU_MEMORYTYPE_ARRAY, 3,
                              :CU_MEMORYTYPE_UNIFIED, 4]
    enum :CUcomputemode_enum, [:CU_COMPUTEMODE_DEFAULT, 0,
                               :CU_COMPUTEMODE_PROHIBITED, 2,
                               :CU_COMPUTEMODE_EXCLUSIVE_PROCESS, 3]
    enum :CUmem_advise_enum, [:CU_MEM_ADVISE_SET_READ_MOSTLY, 1,
                              :CU_MEM_ADVISE_UNSET_READ_MOSTLY, 2,
                              :CU_MEM_ADVISE_SET_PREFERRED_LOCATION, 3,
                              :CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION, 4,
                              :CU_MEM_ADVISE_SET_ACCESSED_BY, 5,
                              :CU_MEM_ADVISE_UNSET_ACCESSED_BY, 6]
    enum :CUmem_range_attribute_enum, [:CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY, 1,
                                       :CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION, 2,
                                       :CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY, 3,
                                       :CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION, 4]
    enum :CUjit_option_enum, [:CU_JIT_MAX_REGISTERS, 0,
                              :CU_JIT_THREADS_PER_BLOCK, 1,
                              :CU_JIT_WALL_TIME, 2,
                              :CU_JIT_INFO_LOG_BUFFER, 3,
                              :CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES, 4,
                              :CU_JIT_ERROR_LOG_BUFFER, 5,
                              :CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES, 6,
                              :CU_JIT_OPTIMIZATION_LEVEL, 7,
                              :CU_JIT_TARGET_FROM_CUCONTEXT, 8,
                              :CU_JIT_TARGET, 9,
                              :CU_JIT_FALLBACK_STRATEGY, 10,
                              :CU_JIT_GENERATE_DEBUG_INFO, 11,
                              :CU_JIT_LOG_VERBOSE, 12,
                              :CU_JIT_GENERATE_LINE_INFO, 13,
                              :CU_JIT_CACHE_MODE, 14,
                              :CU_JIT_NEW_SM3X_OPT, 15,
                              :CU_JIT_FAST_COMPILE, 16,
                              :CU_JIT_GLOBAL_SYMBOL_NAMES, 17,
                              :CU_JIT_GLOBAL_SYMBOL_ADDRESSES, 18,
                              :CU_JIT_GLOBAL_SYMBOL_COUNT, 19,
                              :CU_JIT_LTO, 20,
                              :CU_JIT_FTZ, 21,
                              :CU_JIT_PREC_DIV, 22,
                              :CU_JIT_PREC_SQRT, 23,
                              :CU_JIT_FMA, 24,
                              :CU_JIT_NUM_OPTIONS, 25]
    enum :CUjit_target_enum, [:CU_TARGET_COMPUTE_20, 20,
                              :CU_TARGET_COMPUTE_21, 21,
                              :CU_TARGET_COMPUTE_30, 30,
                              :CU_TARGET_COMPUTE_32, 32,
                              :CU_TARGET_COMPUTE_35, 35,
                              :CU_TARGET_COMPUTE_37, 37,
                              :CU_TARGET_COMPUTE_50, 50,
                              :CU_TARGET_COMPUTE_52, 52,
                              :CU_TARGET_COMPUTE_53, 53,
                              :CU_TARGET_COMPUTE_60, 60,
                              :CU_TARGET_COMPUTE_61, 61,
                              :CU_TARGET_COMPUTE_62, 62,
                              :CU_TARGET_COMPUTE_70, 70,
                              :CU_TARGET_COMPUTE_72, 72,
                              :CU_TARGET_COMPUTE_75, 75,
                              :CU_TARGET_COMPUTE_80, 80,
                              :CU_TARGET_COMPUTE_86, 86]
    enum :CUjit_fallback_enum, [:CU_PREFER_PTX, 0,
                                :CU_PREFER_BINARY, 1]
    enum :CUjit_cacheMode_enum, [:CU_JIT_CACHE_OPTION_NONE, 0,
                                 :CU_JIT_CACHE_OPTION_CG, 1,
                                 :CU_JIT_CACHE_OPTION_CA, 2]
    enum :CUjitInputType_enum, [:CU_JIT_INPUT_CUBIN, 0,
                                :CU_JIT_INPUT_PTX, 1,
                                :CU_JIT_INPUT_FATBINARY, 2,
                                :CU_JIT_INPUT_OBJECT, 3,
                                :CU_JIT_INPUT_LIBRARY, 4,
                                :CU_JIT_INPUT_NVVM, 5,
                                :CU_JIT_NUM_INPUT_TYPES, 6]
    enum :CUgraphicsRegisterFlags_enum, [:CU_GRAPHICS_REGISTER_FLAGS_NONE, 0,
                                         :CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY, 1,
                                         :CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD, 2,
                                         :CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST, 4,
                                         :CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER, 8]
    enum :CUgraphicsMapResourceFlags_enum, [:CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE, 0,
                                            :CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY, 1,
                                            :CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD, 2]
    enum :CUarray_cubemap_face_enum, [:CU_CUBEMAP_FACE_POSITIVE_X, 0,
                                      :CU_CUBEMAP_FACE_NEGATIVE_X, 1,
                                      :CU_CUBEMAP_FACE_POSITIVE_Y, 2,
                                      :CU_CUBEMAP_FACE_NEGATIVE_Y, 3,
                                      :CU_CUBEMAP_FACE_POSITIVE_Z, 4,
                                      :CU_CUBEMAP_FACE_NEGATIVE_Z, 5]
    enum :CUlimit_enum, [:CU_LIMIT_STACK_SIZE, 0,
                         :CU_LIMIT_PRINTF_FIFO_SIZE, 1,
                         :CU_LIMIT_MALLOC_HEAP_SIZE, 2,
                         :CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH, 3,
                         :CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT, 4,
                         :CU_LIMIT_MAX_L2_FETCH_GRANULARITY, 5,
                         :CU_LIMIT_PERSISTING_L2_CACHE_SIZE, 6,
                         :CU_LIMIT_MAX, 7]
    enum :CUresourcetype_enum, [:CU_RESOURCE_TYPE_ARRAY, 0,
                                :CU_RESOURCE_TYPE_MIPMAPPED_ARRAY, 1,
                                :CU_RESOURCE_TYPE_LINEAR, 2,
                                :CU_RESOURCE_TYPE_PITCH2D, 3]
    enum :CUaccessProperty_enum, [:CU_ACCESS_PROPERTY_NORMAL, 0,
                                  :CU_ACCESS_PROPERTY_STREAMING, 1,
                                  :CU_ACCESS_PROPERTY_PERSISTING, 2]
    enum :CUgraphNodeType_enum, [:CU_GRAPH_NODE_TYPE_KERNEL, 0,
                                 :CU_GRAPH_NODE_TYPE_MEMCPY, 1,
                                 :CU_GRAPH_NODE_TYPE_MEMSET, 2,
                                 :CU_GRAPH_NODE_TYPE_HOST, 3,
                                 :CU_GRAPH_NODE_TYPE_GRAPH, 4,
                                 :CU_GRAPH_NODE_TYPE_EMPTY, 5,
                                 :CU_GRAPH_NODE_TYPE_WAIT_EVENT, 6,
                                 :CU_GRAPH_NODE_TYPE_EVENT_RECORD, 7,
                                 :CU_GRAPH_NODE_TYPE_EXT_SEMAS_SIGNAL, 8,
                                 :CU_GRAPH_NODE_TYPE_EXT_SEMAS_WAIT, 9,
                                 :CU_GRAPH_NODE_TYPE_MEM_ALLOC, 10,
                                 :CU_GRAPH_NODE_TYPE_MEM_FREE, 11]
    enum :CUsynchronizationPolicy_enum, [:CU_SYNC_POLICY_AUTO, 1,
                                         :CU_SYNC_POLICY_SPIN, 2,
                                         :CU_SYNC_POLICY_YIELD, 3,
                                         :CU_SYNC_POLICY_BLOCKING_SYNC, 4]
    enum :CUkernelNodeAttrID_enum, [:CU_KERNEL_NODE_ATTRIBUTE_ACCESS_POLICY_WINDOW, 1,
                                    :CU_KERNEL_NODE_ATTRIBUTE_COOPERATIVE, 2]
    enum :CUstreamCaptureStatus_enum, [:CU_STREAM_CAPTURE_STATUS_NONE, 0,
                                       :CU_STREAM_CAPTURE_STATUS_ACTIVE, 1,
                                       :CU_STREAM_CAPTURE_STATUS_INVALIDATED, 2]
    enum :CUstreamCaptureMode_enum, [:CU_STREAM_CAPTURE_MODE_GLOBAL, 0,
                                     :CU_STREAM_CAPTURE_MODE_THREAD_LOCAL, 1,
                                     :CU_STREAM_CAPTURE_MODE_RELAXED, 2]
    enum :CUstreamAttrID_enum, [:CU_STREAM_ATTRIBUTE_ACCESS_POLICY_WINDOW, 1,
                                :CU_STREAM_ATTRIBUTE_SYNCHRONIZATION_POLICY, 3]
    enum :CUdriverProcAddress_flags_enum, [:CU_GET_PROC_ADDRESS_DEFAULT, 0,
                                           :CU_GET_PROC_ADDRESS_LEGACY_STREAM, 1,
                                           :CU_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM, 2]
    enum :CUexecAffinityType_enum, [:CU_EXEC_AFFINITY_TYPE_SM_COUNT, 0,
                                    :CU_EXEC_AFFINITY_TYPE_MAX, 1]
    enum :cudaError_enum, [:CUDA_SUCCESS, 0,
                           :CUDA_ERROR_INVALID_VALUE, 1,
                           :CUDA_ERROR_OUT_OF_MEMORY, 2,
                           :CUDA_ERROR_NOT_INITIALIZED, 3,
                           :CUDA_ERROR_DEINITIALIZED, 4,
                           :CUDA_ERROR_PROFILER_DISABLED, 5,
                           :CUDA_ERROR_PROFILER_NOT_INITIALIZED, 6,
                           :CUDA_ERROR_PROFILER_ALREADY_STARTED, 7,
                           :CUDA_ERROR_PROFILER_ALREADY_STOPPED, 8,
                           :CUDA_ERROR_STUB_LIBRARY, 34,
                           :CUDA_ERROR_NO_DEVICE, 100,
                           :CUDA_ERROR_INVALID_DEVICE, 101,
                           :CUDA_ERROR_DEVICE_NOT_LICENSED, 102,
                           :CUDA_ERROR_INVALID_IMAGE, 200,
                           :CUDA_ERROR_INVALID_CONTEXT, 201,
                           :CUDA_ERROR_CONTEXT_ALREADY_CURRENT, 202,
                           :CUDA_ERROR_MAP_FAILED, 205,
                           :CUDA_ERROR_UNMAP_FAILED, 206,
                           :CUDA_ERROR_ARRAY_IS_MAPPED, 207,
                           :CUDA_ERROR_ALREADY_MAPPED, 208,
                           :CUDA_ERROR_NO_BINARY_FOR_GPU, 209,
                           :CUDA_ERROR_ALREADY_ACQUIRED, 210,
                           :CUDA_ERROR_NOT_MAPPED, 211,
                           :CUDA_ERROR_NOT_MAPPED_AS_ARRAY, 212,
                           :CUDA_ERROR_NOT_MAPPED_AS_POINTER, 213,
                           :CUDA_ERROR_ECC_UNCORRECTABLE, 214,
                           :CUDA_ERROR_UNSUPPORTED_LIMIT, 215,
                           :CUDA_ERROR_CONTEXT_ALREADY_IN_USE, 216,
                           :CUDA_ERROR_PEER_ACCESS_UNSUPPORTED, 217,
                           :CUDA_ERROR_INVALID_PTX, 218,
                           :CUDA_ERROR_INVALID_GRAPHICS_CONTEXT, 219,
                           :CUDA_ERROR_NVLINK_UNCORRECTABLE, 220,
                           :CUDA_ERROR_JIT_COMPILER_NOT_FOUND, 221,
                           :CUDA_ERROR_UNSUPPORTED_PTX_VERSION, 222,
                           :CUDA_ERROR_JIT_COMPILATION_DISABLED, 223,
                           :CUDA_ERROR_UNSUPPORTED_EXEC_AFFINITY, 224,
                           :CUDA_ERROR_INVALID_SOURCE, 300,
                           :CUDA_ERROR_FILE_NOT_FOUND, 301,
                           :CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND, 302,
                           :CUDA_ERROR_SHARED_OBJECT_INIT_FAILED, 303,
                           :CUDA_ERROR_OPERATING_SYSTEM, 304,
                           :CUDA_ERROR_INVALID_HANDLE, 400,
                           :CUDA_ERROR_ILLEGAL_STATE, 401,
                           :CUDA_ERROR_NOT_FOUND, 500,
                           :CUDA_ERROR_NOT_READY, 600,
                           :CUDA_ERROR_ILLEGAL_ADDRESS, 700,
                           :CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES, 701,
                           :CUDA_ERROR_LAUNCH_TIMEOUT, 702,
                           :CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING, 703,
                           :CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED, 704,
                           :CUDA_ERROR_PEER_ACCESS_NOT_ENABLED, 705,
                           :CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE, 708,
                           :CUDA_ERROR_CONTEXT_IS_DESTROYED, 709,
                           :CUDA_ERROR_ASSERT, 710,
                           :CUDA_ERROR_TOO_MANY_PEERS, 711,
                           :CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED, 712,
                           :CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED, 713,
                           :CUDA_ERROR_HARDWARE_STACK_ERROR, 714,
                           :CUDA_ERROR_ILLEGAL_INSTRUCTION, 715,
                           :CUDA_ERROR_MISALIGNED_ADDRESS, 716,
                           :CUDA_ERROR_INVALID_ADDRESS_SPACE, 717,
                           :CUDA_ERROR_INVALID_PC, 718,
                           :CUDA_ERROR_LAUNCH_FAILED, 719,
                           :CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE, 720,
                           :CUDA_ERROR_NOT_PERMITTED, 800,
                           :CUDA_ERROR_NOT_SUPPORTED, 801,
                           :CUDA_ERROR_SYSTEM_NOT_READY, 802,
                           :CUDA_ERROR_SYSTEM_DRIVER_MISMATCH, 803,
                           :CUDA_ERROR_COMPAT_NOT_SUPPORTED_ON_DEVICE, 804,
                           :CUDA_ERROR_MPS_CONNECTION_FAILED, 805,
                           :CUDA_ERROR_MPS_RPC_FAILURE, 806,
                           :CUDA_ERROR_MPS_SERVER_NOT_READY, 807,
                           :CUDA_ERROR_MPS_MAX_CLIENTS_REACHED, 808,
                           :CUDA_ERROR_MPS_MAX_CONNECTIONS_REACHED, 809,
                           :CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED, 900,
                           :CUDA_ERROR_STREAM_CAPTURE_INVALIDATED, 901,
                           :CUDA_ERROR_STREAM_CAPTURE_MERGE, 902,
                           :CUDA_ERROR_STREAM_CAPTURE_UNMATCHED, 903,
                           :CUDA_ERROR_STREAM_CAPTURE_UNJOINED, 904,
                           :CUDA_ERROR_STREAM_CAPTURE_ISOLATION, 905,
                           :CUDA_ERROR_STREAM_CAPTURE_IMPLICIT, 906,
                           :CUDA_ERROR_CAPTURED_EVENT, 907,
                           :CUDA_ERROR_STREAM_CAPTURE_WRONG_THREAD, 908,
                           :CUDA_ERROR_TIMEOUT, 909,
                           :CUDA_ERROR_GRAPH_EXEC_UPDATE_FAILURE, 910,
                           :CUDA_ERROR_EXTERNAL_DEVICE, 911,
                           :CUDA_ERROR_UNKNOWN, 999]
    enum :CUdevice_P2PAttribute_enum, [:CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK, 1,
                                       :CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED, 2,
                                       :CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED, 3,
                                       :CU_DEVICE_P2P_ATTRIBUTE_ACCESS_ACCESS_SUPPORTED, 4,
                                       :CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED, 4]
    enum :CUresourceViewFormat_enum, [:CU_RES_VIEW_FORMAT_NONE, 0,
                                      :CU_RES_VIEW_FORMAT_UINT_1X8, 1,
                                      :CU_RES_VIEW_FORMAT_UINT_2X8, 2,
                                      :CU_RES_VIEW_FORMAT_UINT_4X8, 3,
                                      :CU_RES_VIEW_FORMAT_SINT_1X8, 4,
                                      :CU_RES_VIEW_FORMAT_SINT_2X8, 5,
                                      :CU_RES_VIEW_FORMAT_SINT_4X8, 6,
                                      :CU_RES_VIEW_FORMAT_UINT_1X16, 7,
                                      :CU_RES_VIEW_FORMAT_UINT_2X16, 8,
                                      :CU_RES_VIEW_FORMAT_UINT_4X16, 9,
                                      :CU_RES_VIEW_FORMAT_SINT_1X16, 10,
                                      :CU_RES_VIEW_FORMAT_SINT_2X16, 11,
                                      :CU_RES_VIEW_FORMAT_SINT_4X16, 12,
                                      :CU_RES_VIEW_FORMAT_UINT_1X32, 13,
                                      :CU_RES_VIEW_FORMAT_UINT_2X32, 14,
                                      :CU_RES_VIEW_FORMAT_UINT_4X32, 15,
                                      :CU_RES_VIEW_FORMAT_SINT_1X32, 16,
                                      :CU_RES_VIEW_FORMAT_SINT_2X32, 17,
                                      :CU_RES_VIEW_FORMAT_SINT_4X32, 18,
                                      :CU_RES_VIEW_FORMAT_FLOAT_1X16, 19,
                                      :CU_RES_VIEW_FORMAT_FLOAT_2X16, 20,
                                      :CU_RES_VIEW_FORMAT_FLOAT_4X16, 21,
                                      :CU_RES_VIEW_FORMAT_FLOAT_1X32, 22,
                                      :CU_RES_VIEW_FORMAT_FLOAT_2X32, 23,
                                      :CU_RES_VIEW_FORMAT_FLOAT_4X32, 24,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC1, 25,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC2, 26,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC3, 27,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC4, 28,
                                      :CU_RES_VIEW_FORMAT_SIGNED_BC4, 29,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC5, 30,
                                      :CU_RES_VIEW_FORMAT_SIGNED_BC5, 31,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC6H, 32,
                                      :CU_RES_VIEW_FORMAT_SIGNED_BC6H, 33,
                                      :CU_RES_VIEW_FORMAT_UNSIGNED_BC7, 34]
    enum :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum, [:CU_POINTER_ATTRIBUTE_ACCESS_FLAG_NONE, 0,
                                                     :CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READ, 1,
                                                     :CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READWRITE, 3]
    enum :CUexternalMemoryHandleType_enum, [:CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD, 1,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32, 2,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT, 3,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP, 4,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE, 5,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE, 6,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE_KMT, 7,
                                            :CU_EXTERNAL_MEMORY_HANDLE_TYPE_NVSCIBUF, 8]
    enum :CUexternalSemaphoreHandleType_enum, [:CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD, 1,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32, 2,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT, 3,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE, 4,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_FENCE, 5,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_NVSCISYNC, 6,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX, 7,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX_KMT, 8,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_FD, 9,
                                               :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_WIN32, 10]
    enum :CUmemAllocationHandleType_enum, [:CU_MEM_HANDLE_TYPE_NONE, 0,
                                           :CU_MEM_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR, 1,
                                           :CU_MEM_HANDLE_TYPE_WIN32, 2,
                                           :CU_MEM_HANDLE_TYPE_WIN32_KMT, 4,
                                           :CU_MEM_HANDLE_TYPE_MAX, 2147483647]
    enum :CUmemAccess_flags_enum, [:CU_MEM_ACCESS_FLAGS_PROT_NONE, 0,
                                   :CU_MEM_ACCESS_FLAGS_PROT_READ, 1,
                                   :CU_MEM_ACCESS_FLAGS_PROT_READWRITE, 3,
                                   :CU_MEM_ACCESS_FLAGS_PROT_MAX, 2147483647]
    enum :CUmemLocationType_enum, [:CU_MEM_LOCATION_TYPE_INVALID, 0,
                                   :CU_MEM_LOCATION_TYPE_DEVICE, 1,
                                   :CU_MEM_LOCATION_TYPE_MAX, 2147483647]
    enum :CUmemAllocationType_enum, [:CU_MEM_ALLOCATION_TYPE_INVALID, 0,
                                     :CU_MEM_ALLOCATION_TYPE_PINNED, 1,
                                     :CU_MEM_ALLOCATION_TYPE_MAX, 2147483647]
    enum :CUmemAllocationGranularity_flags_enum, [:CU_MEM_ALLOC_GRANULARITY_MINIMUM, 0,
                                                  :CU_MEM_ALLOC_GRANULARITY_RECOMMENDED, 1]
    enum :CUarraySparseSubresourceType_enum, [:CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_SPARSE_LEVEL, 0,
                                              :CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_MIPTAIL, 1]
    enum :CUmemOperationType_enum, [:CU_MEM_OPERATION_TYPE_MAP, 1,
                                    :CU_MEM_OPERATION_TYPE_UNMAP, 2]
    enum :CUmemHandleType_enum, [:CU_MEM_HANDLE_TYPE_GENERIC, 0]
    enum :CUmemAllocationCompType_enum, [:CU_MEM_ALLOCATION_COMP_NONE, 0,
                                         :CU_MEM_ALLOCATION_COMP_GENERIC, 1]
    enum :CUgraphExecUpdateResult_enum, [:CU_GRAPH_EXEC_UPDATE_SUCCESS, 0,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR, 1,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_TOPOLOGY_CHANGED, 2,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_NODE_TYPE_CHANGED, 3,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_FUNCTION_CHANGED, 4,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_PARAMETERS_CHANGED, 5,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_NOT_SUPPORTED, 6,
                                         :CU_GRAPH_EXEC_UPDATE_ERROR_UNSUPPORTED_FUNCTION_CHANGE, 7]
    enum :CUmemPool_attribute_enum, [:CU_MEMPOOL_ATTR_REUSE_FOLLOW_EVENT_DEPENDENCIES, 1,
                                     :CU_MEMPOOL_ATTR_REUSE_ALLOW_OPPORTUNISTIC, 2,
                                     :CU_MEMPOOL_ATTR_REUSE_ALLOW_INTERNAL_DEPENDENCIES, 3,
                                     :CU_MEMPOOL_ATTR_RELEASE_THRESHOLD, 4,
                                     :CU_MEMPOOL_ATTR_RESERVED_MEM_CURRENT, 5,
                                     :CU_MEMPOOL_ATTR_RESERVED_MEM_HIGH, 6,
                                     :CU_MEMPOOL_ATTR_USED_MEM_CURRENT, 7,
                                     :CU_MEMPOOL_ATTR_USED_MEM_HIGH, 8]
    enum :CUgraphMem_attribute_enum, [:CU_GRAPH_MEM_ATTR_USED_MEM_CURRENT, 0,
                                      :CU_GRAPH_MEM_ATTR_USED_MEM_HIGH, 1,
                                      :CU_GRAPH_MEM_ATTR_RESERVED_MEM_CURRENT, 2,
                                      :CU_GRAPH_MEM_ATTR_RESERVED_MEM_HIGH, 3]
    enum :CUflushGPUDirectRDMAWritesOptions_enum, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_HOST, 1,
                                                   :CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_MEMOPS, 2]
    enum :CUGPUDirectRDMAWritesOrdering_enum, [:CU_GPU_DIRECT_RDMA_WRITES_ORDERING_NONE, 0,
                                               :CU_GPU_DIRECT_RDMA_WRITES_ORDERING_OWNER, 100,
                                               :CU_GPU_DIRECT_RDMA_WRITES_ORDERING_ALL_DEVICES, 200]
    enum :CUflushGPUDirectRDMAWritesScope_enum, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_OWNER, 100,
                                                 :CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_ALL_DEVICES, 200]
    enum :CUflushGPUDirectRDMAWritesTarget_enum, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TARGET_CURRENT_CTX, 0]
    enum :CUgraphDebugDot_flags_enum, [:CU_GRAPH_DEBUG_DOT_FLAGS_VERBOSE, 1,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_RUNTIME_TYPES, 2,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_PARAMS, 4,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_MEMCPY_NODE_PARAMS, 8,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_MEMSET_NODE_PARAMS, 16,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_HOST_NODE_PARAMS, 32,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_EVENT_NODE_PARAMS, 64,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_SIGNAL_NODE_PARAMS, 128,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_WAIT_NODE_PARAMS, 256,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_ATTRIBUTES, 512,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_HANDLES, 1024,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_MEM_ALLOC_NODE_PARAMS, 2048,
                                       :CU_GRAPH_DEBUG_DOT_FLAGS_MEM_FREE_NODE_PARAMS, 4096]
    enum :CUuserObject_flags_enum, [:CU_USER_OBJECT_NO_DESTRUCTOR_SYNC, 1]
    enum :CUuserObjectRetain_flags_enum, [:CU_GRAPH_USER_OBJECT_MOVE, 1]
    enum :CUgraphInstantiate_flags_enum, [:CUDA_GRAPH_INSTANTIATE_FLAG_AUTO_FREE_ON_LAUNCH, 1]

    # Functions
    attach_function :cuGetErrorString, %i[CUresult char], :CUresult
    attach_function :cuGetErrorName, %i[CUresult char], :CUresult
    attach_function :cuInit, [:unsigned_int], :CUresult
    attach_function :cuDriverGetVersion, [:int], :CUresult
    attach_function :cuDeviceGet, %i[CUdevice int], :CUresult
    attach_function :cuDeviceGetCount, [:int], :CUresult
    attach_function :cuDeviceGetName, %i[char int CUdevice], :CUresult
    attach_function :cuDeviceGetUuid, %i[CUuuid CUdevice], :CUresult
    attach_function :cuDeviceGetUuid_v2, %i[CUuuid CUdevice], :CUresult
    attach_function :cuDeviceGetLuid, %i[char unsigned_int CUdevice], :CUresult
    attach_function :cuDeviceTotalMem_v2, %i[size_t CUdevice], :CUresult
    attach_function :cuDeviceGetTexture1DLinearMaxWidth, %i[size_t CUarray_format unsigned_int CUdevice], :CUresult
    attach_function :cuDeviceGetAttribute, %i[int CUdevice_attribute CUdevice], :CUresult
    attach_function :cuDeviceGetNvSciSyncAttributes, %i[pointer CUdevice int], :CUresult
    attach_function :cuDeviceSetMemPool, %i[CUdevice CUmemoryPool], :CUresult
    attach_function :cuDeviceGetMemPool, %i[CUmemoryPool CUdevice], :CUresult
    attach_function :cuDeviceGetDefaultMemPool, %i[CUmemoryPool CUdevice], :CUresult
    attach_function :cuFlushGPUDirectRDMAWrites, %i[CUflushGPUDirectRDMAWritesTarget CUflushGPUDirectRDMAWritesScope], :CUresult
    attach_function :cuDeviceGetProperties, %i[CUdevprop CUdevice], :CUresult
    attach_function :cuDeviceComputeCapability, %i[int int CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxRetain, %i[CUcontext CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxRelease_v2, [:CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxSetFlags_v2, %i[CUdevice unsigned_int], :CUresult
    attach_function :cuDevicePrimaryCtxGetState, %i[CUdevice unsigned_int int], :CUresult
    attach_function :cuDevicePrimaryCtxReset_v2, [:CUdevice], :CUresult
    attach_function :cuDeviceGetExecAffinitySupport, %i[int CUexecAffinityType CUdevice], :CUresult
    attach_function :cuCtxCreate_v2, %i[CUcontext unsigned_int CUdevice], :CUresult
    attach_function :cuCtxCreate_v3, %i[CUcontext CUexecAffinityParam int unsigned_int CUdevice], :CUresult
    attach_function :cuCtxDestroy_v2, [:CUcontext], :CUresult
    attach_function :cuCtxPushCurrent_v2, [:CUcontext], :CUresult
    attach_function :cuCtxPopCurrent_v2, [:CUcontext], :CUresult
    attach_function :cuCtxSetCurrent, [:CUcontext], :CUresult
    attach_function :cuCtxGetCurrent, [:CUcontext], :CUresult
    attach_function :cuCtxGetDevice, [:CUdevice], :CUresult
    attach_function :cuCtxGetFlags, [:unsigned_int], :CUresult
    attach_function :cuCtxSynchronize, [], :CUresult
    attach_function :cuCtxSetLimit, %i[CUlimit size_t], :CUresult
    attach_function :cuCtxGetLimit, %i[size_t CUlimit], :CUresult
    attach_function :cuCtxGetCacheConfig, [:CUfunc_cache], :CUresult
    attach_function :cuCtxSetCacheConfig, [:CUfunc_cache], :CUresult
    attach_function :cuCtxGetSharedMemConfig, [:CUsharedconfig], :CUresult
    attach_function :cuCtxSetSharedMemConfig, [:CUsharedconfig], :CUresult
    attach_function :cuCtxGetApiVersion, %i[CUcontext unsigned_int], :CUresult
    attach_function :cuCtxGetStreamPriorityRange, %i[int int], :CUresult
    attach_function :cuCtxResetPersistingL2Cache, [], :CUresult
    attach_function :cuCtxGetExecAffinity, %i[CUexecAffinityParam CUexecAffinityType], :CUresult
    attach_function :cuCtxAttach, %i[CUcontext unsigned_int], :CUresult
    attach_function :cuCtxDetach, [:CUcontext], :CUresult
    attach_function :cuModuleLoad, %i[CUmodule char], :CUresult
    attach_function :cuModuleLoadData, %i[CUmodule pointer], :CUresult
    attach_function :cuModuleLoadDataEx, %i[CUmodule pointer unsigned_int CUjit_option pointer], :CUresult
    attach_function :cuModuleLoadFatBinary, %i[CUmodule pointer], :CUresult
    attach_function :cuModuleUnload, [:CUmodule], :CUresult
    attach_function :cuModuleGetFunction, %i[CUfunction CUmodule char], :CUresult
    attach_function :cuModuleGetGlobal_v2, %i[CUdeviceptr size_t CUmodule char], :CUresult
    attach_function :cuModuleGetTexRef, %i[CUtexref CUmodule char], :CUresult
    attach_function :cuModuleGetSurfRef, %i[CUsurfref CUmodule char], :CUresult
    attach_function :cuLinkCreate_v2, %i[unsigned_int CUjit_option pointer CUlinkState], :CUresult
    attach_function :cuLinkAddData_v2, %i[CUlinkState CUjitInputType pointer size_t char unsigned_int CUjit_option pointer], :CUresult
    attach_function :cuLinkAddFile_v2, %i[CUlinkState CUjitInputType char unsigned_int CUjit_option pointer], :CUresult
    attach_function :cuLinkComplete, %i[CUlinkState pointer size_t], :CUresult
    attach_function :cuLinkDestroy, [:CUlinkState], :CUresult
    attach_function :cuMemGetInfo_v2, %i[size_t size_t], :CUresult
    attach_function :cuMemAlloc_v2, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemAllocPitch_v2, %i[CUdeviceptr size_t size_t size_t unsigned_int], :CUresult
    attach_function :cuMemFree_v2, [:CUdeviceptr], :CUresult
    attach_function :cuMemGetAddressRange_v2, %i[CUdeviceptr size_t CUdeviceptr], :CUresult
    attach_function :cuMemAllocHost_v2, %i[pointer size_t], :CUresult
    attach_function :cuMemFreeHost, [:pointer], :CUresult
    attach_function :cuMemHostAlloc, %i[pointer size_t unsigned_int], :CUresult
    attach_function :cuMemHostGetDevicePointer_v2, %i[CUdeviceptr pointer unsigned_int], :CUresult
    attach_function :cuMemHostGetFlags, %i[unsigned_int pointer], :CUresult
    attach_function :cuMemAllocManaged, %i[CUdeviceptr size_t unsigned_int], :CUresult
    attach_function :cuDeviceGetByPCIBusId, %i[CUdevice char], :CUresult
    attach_function :cuDeviceGetPCIBusId, %i[char int CUdevice], :CUresult
    attach_function :cuIpcGetEventHandle, %i[CUipcEventHandle CUevent], :CUresult
    attach_function :cuIpcOpenEventHandle, %i[CUevent CUipcEventHandle], :CUresult
    attach_function :cuIpcGetMemHandle, %i[CUipcMemHandle CUdeviceptr], :CUresult
    attach_function :cuIpcOpenMemHandle_v2, %i[CUdeviceptr CUipcMemHandle unsigned_int], :CUresult
    attach_function :cuIpcCloseMemHandle, [:CUdeviceptr], :CUresult
    attach_function :cuMemHostRegister_v2, %i[pointer size_t unsigned_int], :CUresult
    attach_function :cuMemHostUnregister, [:pointer], :CUresult
    attach_function :cuMemcpy, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyPeer, %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t], :CUresult
    attach_function :cuMemcpyHtoD_v2, %i[CUdeviceptr pointer size_t], :CUresult
    attach_function :cuMemcpyDtoH_v2, %i[pointer CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoD_v2, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoA_v2, %i[CUarray size_t CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyAtoD_v2, %i[CUdeviceptr CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyHtoA_v2, %i[CUarray size_t pointer size_t], :CUresult
    attach_function :cuMemcpyAtoH_v2, %i[pointer CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyAtoA_v2, %i[CUarray size_t CUarray size_t size_t], :CUresult
    attach_function :cuMemcpy2D_v2, [:CUDA_MEMCPY2D], :CUresult
    attach_function :cuMemcpy2DUnaligned_v2, [:CUDA_MEMCPY2D], :CUresult
    attach_function :cuMemcpy3D_v2, [:CUDA_MEMCPY3D], :CUresult
    attach_function :cuMemcpy3DPeer, [:CUDA_MEMCPY3D_PEER], :CUresult
    attach_function :cuMemcpyAsync, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyPeerAsync, %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoDAsync_v2, %i[CUdeviceptr pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoHAsync_v2, %i[pointer CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoDAsync_v2, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoAAsync_v2, %i[CUarray size_t pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyAtoHAsync_v2, %i[pointer CUarray size_t size_t CUstream], :CUresult
    attach_function :cuMemcpy2DAsync_v2, %i[CUDA_MEMCPY2D CUstream], :CUresult
    attach_function :cuMemcpy3DAsync_v2, %i[CUDA_MEMCPY3D CUstream], :CUresult
    attach_function :cuMemcpy3DPeerAsync, %i[CUDA_MEMCPY3D_PEER CUstream], :CUresult
    attach_function :cuMemsetD8_v2, %i[CUdeviceptr unsigned_char size_t], :CUresult
    attach_function :cuMemsetD16_v2, %i[CUdeviceptr short_unsigned_int size_t], :CUresult
    attach_function :cuMemsetD32_v2, %i[CUdeviceptr unsigned_int size_t], :CUresult
    attach_function :cuMemsetD2D8_v2, %i[CUdeviceptr size_t unsigned_char size_t size_t], :CUresult
    attach_function :cuMemsetD2D16_v2, %i[CUdeviceptr size_t short_unsigned_int size_t size_t], :CUresult
    attach_function :cuMemsetD2D32_v2, %i[CUdeviceptr size_t unsigned_int size_t size_t], :CUresult
    attach_function :cuMemsetD8Async, %i[CUdeviceptr unsigned_char size_t CUstream], :CUresult
    attach_function :cuMemsetD16Async, %i[CUdeviceptr short_unsigned_int size_t CUstream], :CUresult
    attach_function :cuMemsetD32Async, %i[CUdeviceptr unsigned_int size_t CUstream], :CUresult
    attach_function :cuMemsetD2D8Async, %i[CUdeviceptr size_t unsigned_char size_t size_t CUstream], :CUresult
    attach_function :cuMemsetD2D16Async, %i[CUdeviceptr size_t short_unsigned_int size_t size_t CUstream], :CUresult
    attach_function :cuMemsetD2D32Async, %i[CUdeviceptr size_t unsigned_int size_t size_t CUstream], :CUresult
    attach_function :cuArrayCreate_v2, %i[CUarray CUDA_ARRAY_DESCRIPTOR], :CUresult
    attach_function :cuArrayGetDescriptor_v2, %i[CUDA_ARRAY_DESCRIPTOR CUarray], :CUresult
    attach_function :cuArrayGetSparseProperties, %i[CUDA_ARRAY_SPARSE_PROPERTIES CUarray], :CUresult
    attach_function :cuMipmappedArrayGetSparseProperties, %i[CUDA_ARRAY_SPARSE_PROPERTIES CUmipmappedArray], :CUresult
    attach_function :cuArrayGetPlane, %i[CUarray CUarray unsigned_int], :CUresult
    attach_function :cuArrayDestroy, [:CUarray], :CUresult
    attach_function :cuArray3DCreate_v2, %i[CUarray CUDA_ARRAY3D_DESCRIPTOR], :CUresult
    attach_function :cuArray3DGetDescriptor_v2, %i[CUDA_ARRAY3D_DESCRIPTOR CUarray], :CUresult
    attach_function :cuMipmappedArrayCreate, %i[CUmipmappedArray CUDA_ARRAY3D_DESCRIPTOR unsigned_int], :CUresult
    attach_function :cuMipmappedArrayGetLevel, %i[CUarray CUmipmappedArray unsigned_int], :CUresult
    attach_function :cuMipmappedArrayDestroy, [:CUmipmappedArray], :CUresult
    attach_function :cuMemAddressReserve, %i[CUdeviceptr size_t size_t CUdeviceptr long_long_unsigned_int], :CUresult
    attach_function :cuMemAddressFree, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemCreate, %i[CUmemGenericAllocationHandle size_t CUmemAllocationProp long_long_unsigned_int], :CUresult
    attach_function :cuMemRelease, [:CUmemGenericAllocationHandle], :CUresult
    attach_function :cuMemMap, %i[CUdeviceptr size_t size_t CUmemGenericAllocationHandle long_long_unsigned_int], :CUresult
    attach_function :cuMemMapArrayAsync, %i[CUarrayMapInfo unsigned_int CUstream], :CUresult
    attach_function :cuMemUnmap, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemSetAccess, %i[CUdeviceptr size_t CUmemAccessDesc size_t], :CUresult
    attach_function :cuMemGetAccess, %i[long_long_unsigned_int CUmemLocation CUdeviceptr], :CUresult
    attach_function :cuMemExportToShareableHandle, %i[pointer CUmemGenericAllocationHandle CUmemAllocationHandleType long_long_unsigned_int], :CUresult
    attach_function :cuMemImportFromShareableHandle, %i[CUmemGenericAllocationHandle pointer CUmemAllocationHandleType], :CUresult
    attach_function :cuMemGetAllocationGranularity, %i[size_t CUmemAllocationProp CUmemAllocationGranularity_flags], :CUresult
    attach_function :cuMemGetAllocationPropertiesFromHandle, %i[CUmemAllocationProp CUmemGenericAllocationHandle], :CUresult
    attach_function :cuMemRetainAllocationHandle, %i[CUmemGenericAllocationHandle pointer], :CUresult
    attach_function :cuMemFreeAsync, %i[CUdeviceptr CUstream], :CUresult
    attach_function :cuMemAllocAsync, %i[CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemPoolTrimTo, %i[CUmemoryPool size_t], :CUresult
    attach_function :cuMemPoolSetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolGetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolSetAccess, %i[CUmemoryPool CUmemAccessDesc size_t], :CUresult
    attach_function :cuMemPoolGetAccess, %i[CUmemAccess_flags CUmemoryPool CUmemLocation], :CUresult
    attach_function :cuMemPoolCreate, %i[CUmemoryPool CUmemPoolProps], :CUresult
    attach_function :cuMemPoolDestroy, [:CUmemoryPool], :CUresult
    attach_function :cuMemAllocFromPoolAsync, %i[CUdeviceptr size_t CUmemoryPool CUstream], :CUresult
    attach_function :cuMemPoolExportToShareableHandle, %i[pointer CUmemoryPool CUmemAllocationHandleType long_long_unsigned_int], :CUresult
    attach_function :cuMemPoolImportFromShareableHandle, %i[CUmemoryPool pointer CUmemAllocationHandleType long_long_unsigned_int], :CUresult
    attach_function :cuMemPoolExportPointer, %i[CUmemPoolPtrExportData CUdeviceptr], :CUresult
    attach_function :cuMemPoolImportPointer, %i[CUdeviceptr CUmemoryPool CUmemPoolPtrExportData], :CUresult
    attach_function :cuPointerGetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuMemPrefetchAsync, %i[CUdeviceptr size_t CUdevice CUstream], :CUresult
    attach_function :cuMemAdvise, %i[CUdeviceptr size_t CUmem_advise CUdevice], :CUresult
    attach_function :cuMemRangeGetAttribute, %i[pointer size_t CUmem_range_attribute CUdeviceptr size_t], :CUresult
    attach_function :cuMemRangeGetAttributes, %i[pointer size_t CUmem_range_attribute size_t CUdeviceptr size_t], :CUresult
    attach_function :cuPointerSetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuPointerGetAttributes, %i[unsigned_int CUpointer_attribute pointer CUdeviceptr], :CUresult
    attach_function :cuStreamCreate, %i[CUstream unsigned_int], :CUresult
    attach_function :cuStreamCreateWithPriority, %i[CUstream unsigned_int int], :CUresult
    attach_function :cuStreamGetPriority, %i[CUstream int], :CUresult
    attach_function :cuStreamGetFlags, %i[CUstream unsigned_int], :CUresult
    attach_function :cuStreamGetCtx, %i[CUstream CUcontext], :CUresult
    attach_function :cuStreamWaitEvent, %i[CUstream CUevent unsigned_int], :CUresult
    attach_function :cuStreamAddCallback, %i[CUstream CUstreamCallback pointer unsigned_int], :CUresult
    attach_function :cuStreamBeginCapture_v2, %i[CUstream CUstreamCaptureMode], :CUresult
    attach_function :cuThreadExchangeStreamCaptureMode, [:CUstreamCaptureMode], :CUresult
    attach_function :cuStreamEndCapture, %i[CUstream CUgraph], :CUresult
    attach_function :cuStreamIsCapturing, %i[CUstream CUstreamCaptureStatus], :CUresult
    attach_function :cuStreamGetCaptureInfo, %i[CUstream CUstreamCaptureStatus cuuint64_t], :CUresult
    attach_function :cuStreamGetCaptureInfo_v2, %i[CUstream CUstreamCaptureStatus cuuint64_t CUgraph CUgraphNode size_t], :CUresult
    attach_function :cuStreamUpdateCaptureDependencies, %i[CUstream CUgraphNode size_t unsigned_int], :CUresult
    attach_function :cuStreamAttachMemAsync, %i[CUstream CUdeviceptr size_t unsigned_int], :CUresult
    attach_function :cuStreamQuery, [:CUstream], :CUresult
    attach_function :cuStreamSynchronize, [:CUstream], :CUresult
    attach_function :cuStreamDestroy_v2, [:CUstream], :CUresult
    attach_function :cuStreamCopyAttributes, %i[CUstream CUstream], :CUresult
    attach_function :cuStreamGetAttribute, %i[CUstream CUstreamAttrID CUstreamAttrValue], :CUresult
    attach_function :cuStreamSetAttribute, %i[CUstream CUstreamAttrID CUstreamAttrValue], :CUresult
    attach_function :cuEventCreate, %i[CUevent unsigned_int], :CUresult
    attach_function :cuEventRecord, %i[CUevent CUstream], :CUresult
    attach_function :cuEventRecordWithFlags, %i[CUevent CUstream unsigned_int], :CUresult
    attach_function :cuEventQuery, [:CUevent], :CUresult
    attach_function :cuEventSynchronize, [:CUevent], :CUresult
    attach_function :cuEventDestroy_v2, [:CUevent], :CUresult
    attach_function :cuEventElapsedTime, %i[float CUevent CUevent], :CUresult
    attach_function :cuImportExternalMemory, %i[CUexternalMemory CUDA_EXTERNAL_MEMORY_HANDLE_DESC], :CUresult
    attach_function :cuExternalMemoryGetMappedBuffer, %i[CUdeviceptr CUexternalMemory CUDA_EXTERNAL_MEMORY_BUFFER_DESC], :CUresult
    attach_function :cuExternalMemoryGetMappedMipmappedArray, %i[CUmipmappedArray CUexternalMemory CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC], :CUresult
    attach_function :cuDestroyExternalMemory, [:CUexternalMemory], :CUresult
    attach_function :cuImportExternalSemaphore, %i[CUexternalSemaphore CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC], :CUresult
    attach_function :cuSignalExternalSemaphoresAsync, %i[CUexternalSemaphore CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS unsigned_int CUstream], :CUresult
    attach_function :cuWaitExternalSemaphoresAsync, %i[CUexternalSemaphore CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS unsigned_int CUstream], :CUresult
    attach_function :cuDestroyExternalSemaphore, [:CUexternalSemaphore], :CUresult
    attach_function :cuStreamWaitValue32, %i[CUstream CUdeviceptr cuuint32_t unsigned_int], :CUresult
    attach_function :cuStreamWaitValue64, %i[CUstream CUdeviceptr cuuint64_t unsigned_int], :CUresult
    attach_function :cuStreamWriteValue32, %i[CUstream CUdeviceptr cuuint32_t unsigned_int], :CUresult
    attach_function :cuStreamWriteValue64, %i[CUstream CUdeviceptr cuuint64_t unsigned_int], :CUresult
    attach_function :cuStreamBatchMemOp, %i[CUstream unsigned_int CUstreamBatchMemOpParams unsigned_int], :CUresult
    attach_function :cuFuncGetAttribute, %i[int CUfunction_attribute CUfunction], :CUresult
    attach_function :cuFuncSetAttribute, %i[CUfunction CUfunction_attribute int], :CUresult
    attach_function :cuFuncSetCacheConfig, %i[CUfunction CUfunc_cache], :CUresult
    attach_function :cuFuncSetSharedMemConfig, %i[CUfunction CUsharedconfig], :CUresult
    attach_function :cuFuncGetModule, %i[CUmodule CUfunction], :CUresult
    attach_function :cuLaunchKernel, %i[CUfunction unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int CUstream pointer pointer], :CUresult
    attach_function :cuLaunchCooperativeKernel, %i[CUfunction unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int CUstream pointer], :CUresult
    attach_function :cuLaunchCooperativeKernelMultiDevice, %i[CUDA_LAUNCH_PARAMS unsigned_int unsigned_int], :CUresult
    attach_function :cuLaunchHostFunc, %i[CUstream CUhostFn pointer], :CUresult
    attach_function :cuFuncSetBlockShape, %i[CUfunction int int int], :CUresult
    attach_function :cuFuncSetSharedSize, %i[CUfunction unsigned_int], :CUresult
    attach_function :cuParamSetSize, %i[CUfunction unsigned_int], :CUresult
    attach_function :cuParamSeti, %i[CUfunction int unsigned_int], :CUresult
    attach_function :cuParamSetf, %i[CUfunction int float], :CUresult
    attach_function :cuParamSetv, %i[CUfunction int pointer unsigned_int], :CUresult
    attach_function :cuLaunch, [:CUfunction], :CUresult
    attach_function :cuLaunchGrid, %i[CUfunction int int], :CUresult
    attach_function :cuLaunchGridAsync, %i[CUfunction int int CUstream], :CUresult
    attach_function :cuParamSetTexRef, %i[CUfunction int CUtexref], :CUresult
    attach_function :cuGraphCreate, %i[CUgraph unsigned_int], :CUresult
    attach_function :cuGraphAddKernelNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_KERNEL_NODE_PARAMS], :CUresult
    attach_function :cuGraphKernelNodeGetParams, %i[CUgraphNode CUDA_KERNEL_NODE_PARAMS], :CUresult
    attach_function :cuGraphKernelNodeSetParams, %i[CUgraphNode CUDA_KERNEL_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddMemcpyNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_MEMCPY3D CUcontext], :CUresult
    attach_function :cuGraphMemcpyNodeGetParams, %i[CUgraphNode CUDA_MEMCPY3D], :CUresult
    attach_function :cuGraphMemcpyNodeSetParams, %i[CUgraphNode CUDA_MEMCPY3D], :CUresult
    attach_function :cuGraphAddMemsetNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_MEMSET_NODE_PARAMS CUcontext], :CUresult
    attach_function :cuGraphMemsetNodeGetParams, %i[CUgraphNode CUDA_MEMSET_NODE_PARAMS], :CUresult
    attach_function :cuGraphMemsetNodeSetParams, %i[CUgraphNode CUDA_MEMSET_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddHostNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_HOST_NODE_PARAMS], :CUresult
    attach_function :cuGraphHostNodeGetParams, %i[CUgraphNode CUDA_HOST_NODE_PARAMS], :CUresult
    attach_function :cuGraphHostNodeSetParams, %i[CUgraphNode CUDA_HOST_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddChildGraphNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUgraph], :CUresult
    attach_function :cuGraphChildGraphNodeGetGraph, %i[CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphAddEmptyNode, %i[CUgraphNode CUgraph CUgraphNode size_t], :CUresult
    attach_function :cuGraphAddEventRecordNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUevent], :CUresult
    attach_function :cuGraphEventRecordNodeGetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphEventRecordNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphAddEventWaitNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUevent], :CUresult
    attach_function :cuGraphEventWaitNodeGetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphEventWaitNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphAddExternalSemaphoresSignalNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_EXT_SEM_SIGNAL_NODE_PARAMS], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeGetParams, %i[CUgraphNode CUDA_EXT_SEM_SIGNAL_NODE_PARAMS], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeSetParams, %i[CUgraphNode CUDA_EXT_SEM_SIGNAL_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddExternalSemaphoresWaitNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_EXT_SEM_WAIT_NODE_PARAMS], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeGetParams, %i[CUgraphNode CUDA_EXT_SEM_WAIT_NODE_PARAMS], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeSetParams, %i[CUgraphNode CUDA_EXT_SEM_WAIT_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddMemAllocNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUDA_MEM_ALLOC_NODE_PARAMS], :CUresult
    attach_function :cuGraphMemAllocNodeGetParams, %i[CUgraphNode CUDA_MEM_ALLOC_NODE_PARAMS], :CUresult
    attach_function :cuGraphAddMemFreeNode, %i[CUgraphNode CUgraph CUgraphNode size_t CUdeviceptr], :CUresult
    attach_function :cuGraphMemFreeNodeGetParams, %i[CUgraphNode CUdeviceptr], :CUresult
    attach_function :cuDeviceGraphMemTrim, [:CUdevice], :CUresult
    attach_function :cuDeviceGetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuDeviceSetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuGraphClone, %i[CUgraph CUgraph], :CUresult
    attach_function :cuGraphNodeFindInClone, %i[CUgraphNode CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphNodeGetType, %i[CUgraphNode CUgraphNodeType], :CUresult
    attach_function :cuGraphGetNodes, %i[CUgraph CUgraphNode size_t], :CUresult
    attach_function :cuGraphGetRootNodes, %i[CUgraph CUgraphNode size_t], :CUresult
    attach_function :cuGraphGetEdges, %i[CUgraph CUgraphNode CUgraphNode size_t], :CUresult
    attach_function :cuGraphNodeGetDependencies, %i[CUgraphNode CUgraphNode size_t], :CUresult
    attach_function :cuGraphNodeGetDependentNodes, %i[CUgraphNode CUgraphNode size_t], :CUresult
    attach_function :cuGraphAddDependencies, %i[CUgraph CUgraphNode CUgraphNode size_t], :CUresult
    attach_function :cuGraphRemoveDependencies, %i[CUgraph CUgraphNode CUgraphNode size_t], :CUresult
    attach_function :cuGraphDestroyNode, [:CUgraphNode], :CUresult
    attach_function :cuGraphInstantiate_v2, %i[CUgraphExec CUgraph CUgraphNode char size_t], :CUresult
    attach_function :cuGraphInstantiateWithFlags, %i[CUgraphExec CUgraph long_long_unsigned_int], :CUresult
    attach_function :cuGraphExecKernelNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_KERNEL_NODE_PARAMS], :CUresult
    attach_function :cuGraphExecMemcpyNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_MEMCPY3D CUcontext], :CUresult
    attach_function :cuGraphExecMemsetNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_MEMSET_NODE_PARAMS CUcontext], :CUresult
    attach_function :cuGraphExecHostNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_HOST_NODE_PARAMS], :CUresult
    attach_function :cuGraphExecChildGraphNodeSetParams, %i[CUgraphExec CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphExecEventRecordNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecEventWaitNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecExternalSemaphoresSignalNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_EXT_SEM_SIGNAL_NODE_PARAMS], :CUresult
    attach_function :cuGraphExecExternalSemaphoresWaitNodeSetParams, %i[CUgraphExec CUgraphNode CUDA_EXT_SEM_WAIT_NODE_PARAMS], :CUresult
    attach_function :cuGraphUpload, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuGraphLaunch, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuGraphExecDestroy, [:CUgraphExec], :CUresult
    attach_function :cuGraphDestroy, [:CUgraph], :CUresult
    attach_function :cuGraphExecUpdate, %i[CUgraphExec CUgraph CUgraphNode CUgraphExecUpdateResult], :CUresult
    attach_function :cuGraphKernelNodeCopyAttributes, %i[CUgraphNode CUgraphNode], :CUresult
    attach_function :cuGraphKernelNodeGetAttribute, %i[CUgraphNode CUkernelNodeAttrID CUkernelNodeAttrValue], :CUresult
    attach_function :cuGraphKernelNodeSetAttribute, %i[CUgraphNode CUkernelNodeAttrID CUkernelNodeAttrValue], :CUresult
    attach_function :cuGraphDebugDotPrint, %i[CUgraph char unsigned_int], :CUresult
    attach_function :cuUserObjectCreate, %i[CUuserObject pointer CUhostFn unsigned_int unsigned_int], :CUresult
    attach_function :cuUserObjectRetain, %i[CUuserObject unsigned_int], :CUresult
    attach_function :cuUserObjectRelease, %i[CUuserObject unsigned_int], :CUresult
    attach_function :cuGraphRetainUserObject, %i[CUgraph CUuserObject unsigned_int unsigned_int], :CUresult
    attach_function :cuGraphReleaseUserObject, %i[CUgraph CUuserObject unsigned_int], :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessor, %i[int CUfunction int size_t], :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags, %i[int CUfunction int size_t unsigned_int], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSize, %i[int int CUfunction CUoccupancyB2DSize size_t int], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSizeWithFlags, %i[int int CUfunction CUoccupancyB2DSize size_t int unsigned_int], :CUresult
    attach_function :cuOccupancyAvailableDynamicSMemPerBlock, %i[size_t CUfunction int int], :CUresult
    attach_function :cuTexRefSetArray, %i[CUtexref CUarray unsigned_int], :CUresult
    attach_function :cuTexRefSetMipmappedArray, %i[CUtexref CUmipmappedArray unsigned_int], :CUresult
    attach_function :cuTexRefSetAddress_v2, %i[size_t CUtexref CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetAddress2D_v3, %i[CUtexref CUDA_ARRAY_DESCRIPTOR CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetFormat, %i[CUtexref CUarray_format int], :CUresult
    attach_function :cuTexRefSetAddressMode, %i[CUtexref int CUaddress_mode], :CUresult
    attach_function :cuTexRefSetFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetMipmapFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetMipmapLevelBias, %i[CUtexref float], :CUresult
    attach_function :cuTexRefSetMipmapLevelClamp, %i[CUtexref float float], :CUresult
    attach_function :cuTexRefSetMaxAnisotropy, %i[CUtexref unsigned_int], :CUresult
    attach_function :cuTexRefSetBorderColor, %i[CUtexref float], :CUresult
    attach_function :cuTexRefSetFlags, %i[CUtexref unsigned_int], :CUresult
    attach_function :cuTexRefGetAddress_v2, %i[CUdeviceptr CUtexref], :CUresult
    attach_function :cuTexRefGetArray, %i[CUarray CUtexref], :CUresult
    attach_function :cuTexRefGetMipmappedArray, %i[CUmipmappedArray CUtexref], :CUresult
    attach_function :cuTexRefGetAddressMode, %i[CUaddress_mode CUtexref int], :CUresult
    attach_function :cuTexRefGetFilterMode, %i[CUfilter_mode CUtexref], :CUresult
    attach_function :cuTexRefGetFormat, %i[CUarray_format int CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapFilterMode, %i[CUfilter_mode CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelBias, %i[float CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelClamp, %i[float float CUtexref], :CUresult
    attach_function :cuTexRefGetMaxAnisotropy, %i[int CUtexref], :CUresult
    attach_function :cuTexRefGetBorderColor, %i[float CUtexref], :CUresult
    attach_function :cuTexRefGetFlags, %i[unsigned_int CUtexref], :CUresult
    attach_function :cuTexRefCreate, [:CUtexref], :CUresult
    attach_function :cuTexRefDestroy, [:CUtexref], :CUresult
    attach_function :cuSurfRefSetArray, %i[CUsurfref CUarray unsigned_int], :CUresult
    attach_function :cuSurfRefGetArray, %i[CUarray CUsurfref], :CUresult
    attach_function :cuTexObjectCreate, %i[CUtexObject CUDA_RESOURCE_DESC CUDA_TEXTURE_DESC CUDA_RESOURCE_VIEW_DESC], :CUresult
    attach_function :cuTexObjectDestroy, [:CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceDesc, %i[CUDA_RESOURCE_DESC CUtexObject], :CUresult
    attach_function :cuTexObjectGetTextureDesc, %i[CUDA_TEXTURE_DESC CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceViewDesc, %i[CUDA_RESOURCE_VIEW_DESC CUtexObject], :CUresult
    attach_function :cuSurfObjectCreate, %i[CUsurfObject CUDA_RESOURCE_DESC], :CUresult
    attach_function :cuSurfObjectDestroy, [:CUsurfObject], :CUresult
    attach_function :cuSurfObjectGetResourceDesc, %i[CUDA_RESOURCE_DESC CUsurfObject], :CUresult
    attach_function :cuDeviceCanAccessPeer, %i[int CUdevice CUdevice], :CUresult
    attach_function :cuCtxEnablePeerAccess, %i[CUcontext unsigned_int], :CUresult
    attach_function :cuCtxDisablePeerAccess, [:CUcontext], :CUresult
    attach_function :cuDeviceGetP2PAttribute, %i[int CUdevice_P2PAttribute CUdevice CUdevice], :CUresult
    attach_function :cuGraphicsUnregisterResource, [:CUgraphicsResource], :CUresult
    attach_function :cuGraphicsSubResourceGetMappedArray, %i[CUarray CUgraphicsResource unsigned_int unsigned_int], :CUresult
    attach_function :cuGraphicsResourceGetMappedMipmappedArray, %i[CUmipmappedArray CUgraphicsResource], :CUresult
    attach_function :cuGraphicsResourceGetMappedPointer_v2, %i[CUdeviceptr size_t CUgraphicsResource], :CUresult
    attach_function :cuGraphicsResourceSetMapFlags_v2, %i[CUgraphicsResource unsigned_int], :CUresult
    attach_function :cuGraphicsMapResources, %i[unsigned_int CUgraphicsResource CUstream], :CUresult
    attach_function :cuGraphicsUnmapResources, %i[unsigned_int CUgraphicsResource CUstream], :CUresult
    attach_function :cuGetProcAddress, %i[char pointer int cuuint64_t], :CUresult
    attach_function :cuGetExportTable, %i[pointer CUuuid], :CUresult
  end
end

# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Naming/VariableNumber
