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

    typedef :uint32, :cuuint32_t
    typedef :uint64, :cuuint64_t
    CUDA_VERSION = 11050
    typedef :uint, :CUdeviceptr_v2
    typedef :CUdeviceptr_v2, :CUdeviceptr
    typedef :int, :CUdevice_v1
    typedef :CUdevice_v1, :CUdevice
    typedef :pointer, :CUcontext
    typedef :pointer, :CUmodule
    typedef :pointer, :CUfunction
    typedef :pointer, :CUarray
    typedef :pointer, :CUmipmappedArray
    typedef :pointer, :CUtexref
    typedef :pointer, :CUsurfref
    typedef :pointer, :CUevent
    typedef :pointer, :CUstream
    typedef :pointer, :CUgraphicsResource
    typedef :ulong_long, :CUtexObject_v1
    typedef :CUtexObject_v1, :CUtexObject
    typedef :ulong_long, :CUsurfObject_v1
    typedef :CUsurfObject_v1, :CUsurfObject
    typedef :pointer, :CUexternalMemory
    typedef :pointer, :CUexternalSemaphore
    typedef :pointer, :CUgraph
    typedef :pointer, :CUgraphNode
    typedef :pointer, :CUgraphExec
    typedef :pointer, :CUmemoryPool
    typedef :pointer, :CUuserObject
    class CUuuidSt < FFI::Struct
      layout(
        :bytes, [:char, 16]
      )
    end
    CU_IPC_HANDLE_SIZE = 64
    class CUipcEventHandleSt < FFI::Struct
      layout(
        :reserved, [:char, 64]
      )
    end
    typedef CUipcEventHandleSt.by_value, :CUipcEventHandle_v1
    typedef :CUipcEventHandle_v1, :CUipcEventHandle
    class CUipcMemHandleSt < FFI::Struct
      layout(
        :reserved, [:char, 64]
      )
    end
    typedef CUipcMemHandleSt.by_value, :CUipcMemHandle_v1
    typedef :CUipcMemHandle_v1, :CUipcMemHandle
    CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS = 0x1
    CUipcMem_flags_enum = enum :CUipcMem_flags, [
      :access, 0x1
    ]

    CU_MEM_ATTACH_GLOBAL = 0x1
    CU_MEM_ATTACH_HOST = 0x2
    CU_MEM_ATTACH_SINGLE = 0x4
    CUmemAttach_flags_enum = enum :CUmemAttach_flags, [
      :global, 0x1,
      :host, 0x2,
      :single, 0x4
    ]

    CU_CTX_SCHED_AUTO = 0x00
    CU_CTX_SCHED_SPIN = 0x01
    CU_CTX_SCHED_YIELD = 0x02
    CU_CTX_SCHED_BLOCKING_SYNC = 0x04
    CU_CTX_BLOCKING_SYNC = 0x04
    CU_CTX_SCHED_MASK = 0x07
    CU_CTX_MAP_HOST = 0x08
    CU_CTX_LMEM_RESIZE_TO_MAX = 0x10
    CU_CTX_FLAGS_MASK = 0x1f
    CUctx_flags_enum = enum :CUctx_flags, [
      :sched_auto, 0x00,
      :sched_spin, 0x01,
      :sched_yield, 0x02,
      :sched_blocking_sync, 0x04,
      :blocking_sync, 0x04,
      :sched_mask, 0x07,
      :map_host, 0x08,
      :lmem_resize_to_max, 0x10,
      :flags_mask, 0x1f
    ]

    CU_STREAM_DEFAULT = 0x0
    CU_STREAM_NON_BLOCKING = 0x1
    CUstream_flags_enum = enum :CUstream_flags, [
      :default, 0x0,
      :non_blocking, 0x1
    ]

    CU_EVENT_DEFAULT = 0x0
    CU_EVENT_BLOCKING_SYNC = 0x1
    CU_EVENT_DISABLE_TIMING = 0x2
    CU_EVENT_INTERPROCESS = 0x4
    CUevent_flags_enum = enum :CUevent_flags, [
      :default, 0x0,
      :blocking_sync, 0x1,
      :disable_timing, 0x2,
      :interprocess, 0x4
    ]

    CU_EVENT_RECORD_DEFAULT = 0x0
    CU_EVENT_RECORD_EXTERNAL = 0x1
    CUevent_record_flags_enum = enum :CUevent_record_flags, [
      :default, 0x0,
      :external, 0x1
    ]

    CU_EVENT_WAIT_DEFAULT = 0x0
    CU_EVENT_WAIT_EXTERNAL = 0x1
    CUevent_wait_flags_enum = enum :CUevent_wait_flags, [
      :default, 0x0,
      :external, 0x1
    ]

    CU_STREAM_WAIT_VALUE_GEQ = 0x0
    CU_STREAM_WAIT_VALUE_EQ = 0x1
    CU_STREAM_WAIT_VALUE_AND = 0x2
    CU_STREAM_WAIT_VALUE_NOR = 0x3
    CU_STREAM_WAIT_VALUE_FLUSH = 1 << 30
    CUstreamWaitValue_flags_enum = enum :CUstreamWaitValue_flags, [
      :geq, 0x0,
      :eq, 0x1,
      :and, 0x2,
      :nor, 0x3,
      :flush, 1 << 30
    ]

    CU_STREAM_WRITE_VALUE_DEFAULT = 0x0
    CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER = 0x1
    CUstreamWriteValue_flags_enum = enum :CUstreamWriteValue_flags, [
      :default, 0x0,
      :no_memory_barrier, 0x1
    ]

    CU_STREAM_MEM_OP_WAIT_VALUE_32 = 1
    CU_STREAM_MEM_OP_WRITE_VALUE_32 = 2
    CU_STREAM_MEM_OP_WAIT_VALUE_64 = 4
    CU_STREAM_MEM_OP_WRITE_VALUE_64 = 5
    CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES = 3
    CUstreamBatchMemOpType_enum = enum :CUstreamBatchMemOpType, [
      :wait_value_32, 1,
      :write_value_32, 2,
      :wait_value_64, 4,
      :write_value_64, 5,
      :flush_remote_writes, 3
    ]

    class CUstreamMemOpWaitValueParamsSt < FFI::Struct
      layout(
        :operation, :CUstreamBatchMemOpType,
        :address, :CUdeviceptr,
        :value, :cuuint32_t,
        :value64, :cuuint64_t,
        :flags, :uint,
        :alias, :CUdeviceptr
      )
    end

    class CUstreamMemOpWriteValueParamsSt < FFI::Struct
      layout(
        :operation, :CUstreamBatchMemOpType,
        :address, :CUdeviceptr,
        :value, :cuuint32_t,
        :value64, :cuuint64_t,
        :flags, :uint,
        :alias, :CUdeviceptr
      )
    end

    class CUstreamMemOpFlushRemoteWritesParamsSt < FFI::Struct
      layout(
        :operation, :CUstreamBatchMemOpType,
        :flags, :uint
      )
    end

    class CUstreamBatchMemOpParamsUnion < FFI::Union
      layout(
        :waitValue, CUstreamMemOpWaitValueParamsSt.by_value,
        :writeValue, CUstreamMemOpWriteValueParamsSt.by_value,
        :flushRemoteWrites, CUstreamMemOpFlushRemoteWritesParamsSt.by_value,
        :operation, :CUstreamBatchMemOpType,
        :pad, [:cuuint64_t, 6]
      )
    end
    typedef CUstreamBatchMemOpParamsUnion.by_value, :CUstreamBatchMemOpParams_v1
    typedef :CUstreamBatchMemOpParams_v1, :CUstreamBatchMemOpParams
    CU_OCCUPANCY_DEFAULT = 0x0
    CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE = 0x1
    CUoccupancy_flags_enum = enum :CUoccupancy_flags, [
      :efault, 0x0,
      :isable_caching_override, 0x1
    ]

    CU_STREAM_ADD_CAPTURE_DEPENDENCIES = 0x0
    CU_STREAM_SET_CAPTURE_DEPENDENCIES = 0x1
    CUstreamUpdateCaptureDependencies_flags_enum = enum :CUstreamUpdateCaptureDependencies_flags, [
      :add_capture_dependencies, 0x0,
      :set_capture_dependencies, 0x1
    ]

    CU_AD_FORMAT_UNSIGNED_INT8 = 0x01
    CU_AD_FORMAT_UNSIGNED_INT16 = 0x02
    CU_AD_FORMAT_UNSIGNED_INT32 = 0x03
    CU_AD_FORMAT_SIGNED_INT8 = 0x08
    CU_AD_FORMAT_SIGNED_INT16 = 0x09
    CU_AD_FORMAT_SIGNED_INT32 = 0x0a
    CU_AD_FORMAT_HALF = 0x10
    CU_AD_FORMAT_FLOAT = 0x20
    CU_AD_FORMAT_NV12 = 0xb0
    CU_AD_FORMAT_UNORM_INT8X1 = 0xc0
    CU_AD_FORMAT_UNORM_INT8X2 = 0xc1
    CU_AD_FORMAT_UNORM_INT8X4 = 0xc2
    CU_AD_FORMAT_UNORM_INT16X1 = 0xc3
    CU_AD_FORMAT_UNORM_INT16X2 = 0xc4
    CU_AD_FORMAT_UNORM_INT16X4 = 0xc5
    CU_AD_FORMAT_SNORM_INT8X1 = 0xc6
    CU_AD_FORMAT_SNORM_INT8X2 = 0xc7
    CU_AD_FORMAT_SNORM_INT8X4 = 0xc8
    CU_AD_FORMAT_SNORM_INT16X1 = 0xc9
    CU_AD_FORMAT_SNORM_INT16X2 = 0xca
    CU_AD_FORMAT_SNORM_INT16X4 = 0xcb
    CU_AD_FORMAT_BC1_UNORM = 0x91
    CU_AD_FORMAT_BC1_UNORM_SRGB = 0x92
    CU_AD_FORMAT_BC2_UNORM = 0x93
    CU_AD_FORMAT_BC2_UNORM_SRGB = 0x94
    CU_AD_FORMAT_BC3_UNORM = 0x95
    CU_AD_FORMAT_BC3_UNORM_SRGB = 0x96
    CU_AD_FORMAT_BC4_UNORM = 0x97
    CU_AD_FORMAT_BC4_SNORM = 0x98
    CU_AD_FORMAT_BC5_UNORM = 0x99
    CU_AD_FORMAT_BC5_SNORM = 0x9a
    CU_AD_FORMAT_BC6H_UF16 = 0x9b
    CU_AD_FORMAT_BC6H_SF16 = 0x9c
    CU_AD_FORMAT_BC7_UNORM = 0x9d
    CU_AD_FORMAT_BC7_UNORM_SRGB = 0x9e
    CUarray_format_enum = enum :CUarray_format, [
      :unsigned_int8, 0x01,
      :unsigned_int16, 0x02,
      :unsigned_int32, 0x03,
      :signed_int8, 0x08,
      :signed_int16, 0x09,
      :signed_int32, 0x0a,
      :half, 0x10,
      :float, 0x20,
      :nv12, 0xb0,
      :unorm_int8x1, 0xc0,
      :unorm_int8x2, 0xc1,
      :unorm_int8x4, 0xc2,
      :unorm_int16x1, 0xc3,
      :unorm_int16x2, 0xc4,
      :unorm_int16x4, 0xc5,
      :snorm_int8x1, 0xc6,
      :snorm_int8x2, 0xc7,
      :snorm_int8x4, 0xc8,
      :snorm_int16x1, 0xc9,
      :snorm_int16x2, 0xca,
      :snorm_int16x4, 0xcb,
      :bc1_unorm, 0x91,
      :bc1_unorm_srgb, 0x92,
      :bc2_unorm, 0x93,
      :bc2_unorm_srgb, 0x94,
      :bc3_unorm, 0x95,
      :bc3_unorm_srgb, 0x96,
      :bc4_unorm, 0x97,
      :bc4_snorm, 0x98,
      :bc5_unorm, 0x99,
      :bc5_snorm, 0x9a,
      :bc6h_uf16, 0x9b,
      :bc6h_sf16, 0x9c,
      :bc7_unorm, 0x9d,
      :bc7_unorm_srgb, 0x9e
    ]

    CU_TR_ADDRESS_MODE_WRAP = 0
    CU_TR_ADDRESS_MODE_CLAMP = 1
    CU_TR_ADDRESS_MODE_MIRROR = 2
    CU_TR_ADDRESS_MODE_BORDER = 3
    CUaddress_mode_enum = enum :CUaddress_mode, [
      :wrap, 0,
      :clamp, 1,
      :mirror, 2,
      :border, 3
    ]

    CU_TR_FILTER_MODE_POINT = 0
    CU_TR_FILTER_MODE_LINEAR = 1
    CUfilter_mode_enum = enum :CUfilter_mode, [
      :point, 0,
      :linear, 1
    ]

    CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 1
    CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X = 2
    CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y = 3
    CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z = 4
    CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X = 5
    CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y = 6
    CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z = 7
    CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK = 8
    CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK = 8
    CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY = 9
    CU_DEVICE_ATTRIBUTE_WARP_SIZE = 10
    CU_DEVICE_ATTRIBUTE_MAX_PITCH = 11
    CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK = 12
    CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK = 12
    CU_DEVICE_ATTRIBUTE_CLOCK_RATE = 13
    CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT = 14
    CU_DEVICE_ATTRIBUTE_GPU_OVERLAP = 15
    CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT = 16
    CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT = 17
    CU_DEVICE_ATTRIBUTE_INTEGRATED = 18
    CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY = 19
    CU_DEVICE_ATTRIBUTE_COMPUTE_MODE = 20
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH = 21
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH = 22
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT = 23
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH = 24
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT = 25
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH = 26
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH = 27
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT = 28
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS = 29
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH = 27
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT = 28
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES = 29
    CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT = 30
    CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS = 31
    CU_DEVICE_ATTRIBUTE_ECC_ENABLED = 32
    CU_DEVICE_ATTRIBUTE_PCI_BUS_ID = 33
    CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID = 34
    CU_DEVICE_ATTRIBUTE_TCC_DRIVER = 35
    CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE = 36
    CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH = 37
    CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE = 38
    CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR = 39
    CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT = 40
    CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING = 41
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH = 42
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS = 43
    CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER = 44
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH = 45
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT = 46
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE = 47
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE = 48
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE = 49
    CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID = 50
    CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT = 51
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH = 52
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH = 53
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS = 54
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH = 55
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH = 56
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT = 57
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH = 58
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT = 59
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH = 60
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH = 61
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS = 62
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH = 63
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT = 64
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS = 65
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH = 66
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH = 67
    CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS = 68
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH = 69
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH = 70
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT = 71
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH = 72
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH = 73
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT = 74
    CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR = 75
    CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR = 76
    CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH = 77
    CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED = 78
    CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED = 79
    CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED = 80
    CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR = 81
    CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR = 82
    CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY = 83
    CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD = 84
    CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID = 85
    CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED = 86
    CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO = 87
    CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS = 88
    CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS = 89
    CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED = 90
    CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM = 91
    CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS = 92
    CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS = 93
    CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR = 94
    CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH = 95
    CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH = 96
    CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN = 97
    CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES = 98
    CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED = 99
    CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES = 100
    CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST = 101
    CU_DEVICE_ATTRIBUTE_VIRTUAL_ADDRESS_MANAGEMENT_SUPPORTED = 102
    CU_DEVICE_ATTRIBUTE_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED = 102
    CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR_SUPPORTED = 103
    CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_HANDLE_SUPPORTED = 104
    CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_KMT_HANDLE_SUPPORTED = 105
    CU_DEVICE_ATTRIBUTE_MAX_BLOCKS_PER_MULTIPROCESSOR = 106
    CU_DEVICE_ATTRIBUTE_GENERIC_COMPRESSION_SUPPORTED = 107
    CU_DEVICE_ATTRIBUTE_MAX_PERSISTING_L2_CACHE_SIZE = 108
    CU_DEVICE_ATTRIBUTE_MAX_ACCESS_POLICY_WINDOW_SIZE = 109
    CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WITH_CUDA_VMM_SUPPORTED = 110
    CU_DEVICE_ATTRIBUTE_RESERVED_SHARED_MEMORY_PER_BLOCK = 111
    CU_DEVICE_ATTRIBUTE_SPARSE_CUDA_ARRAY_SUPPORTED = 112
    CU_DEVICE_ATTRIBUTE_READ_ONLY_HOST_REGISTER_SUPPORTED = 113
    CU_DEVICE_ATTRIBUTE_TIMELINE_SEMAPHORE_INTEROP_SUPPORTED = 114
    CU_DEVICE_ATTRIBUTE_MEMORY_POOLS_SUPPORTED = 115
    CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_SUPPORTED = 116
    CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_FLUSH_WRITES_OPTIONS = 117
    CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WRITES_ORDERING = 118
    CU_DEVICE_ATTRIBUTE_MEMPOOL_SUPPORTED_HANDLE_TYPES = 119
    CU_DEVICE_ATTRIBUTE_MAX = CU_DEVICE_ATTRIBUTE_MEMPOOL_SUPPORTED_HANDLE_TYPES + 1
    CUdevice_attribute_enum = enum :CUdevice_attribute, [
      :max_threads_per_block, 1,
      :max_block_dim_x, 2,
      :max_block_dim_y, 3,
      :max_block_dim_z, 4,
      :max_grid_dim_x, 5,
      :max_grid_dim_y, 6,
      :max_grid_dim_z, 7,
      :max_shared_memory_per_block, 8,
      :shared_memory_per_block, 8,
      :total_constant_memory, 9,
      :warp_size, 10,
      :max_pitch, 11,
      :max_registers_per_block, 12,
      :registers_per_block, 12,
      :clock_rate, 13,
      :texture_alignment, 14,
      :gpu_overlap, 15,
      :multiprocessor_count, 16,
      :kernel_exec_timeout, 17,
      :integrated, 18,
      :can_map_host_memory, 19,
      :compute_mode, 20,
      :maximum_texture1d_width, 21,
      :maximum_texture2d_width, 22,
      :maximum_texture2d_height, 23,
      :maximum_texture3d_width, 24,
      :maximum_texture3d_height, 25,
      :maximum_texture3d_depth, 26,
      :maximum_texture2d_layered_width, 27,
      :maximum_texture2d_layered_height, 28,
      :maximum_texture2d_layered_layers, 29,
      :maximum_texture2d_array_width, 27,
      :maximum_texture2d_array_height, 28,
      :maximum_texture2d_array_numslices, 29,
      :surface_alignment, 30,
      :concurrent_kernels, 31,
      :ecc_enabled, 32,
      :pci_bus_id, 33,
      :pci_device_id, 34,
      :tcc_driver, 35,
      :memory_clock_rate, 36,
      :global_memory_bus_width, 37,
      :l2_cache_size, 38,
      :max_threads_per_multiprocessor, 39,
      :async_engine_count, 40,
      :unified_addressing, 41,
      :maximum_texture1d_layered_width, 42,
      :maximum_texture1d_layered_layers, 43,
      :can_tex2d_gather, 44,
      :maximum_texture2d_gather_width, 45,
      :maximum_texture2d_gather_height, 46,
      :maximum_texture3d_width_alternate, 47,
      :maximum_texture3d_height_alternate, 48,
      :maximum_texture3d_depth_alternate, 49,
      :pci_domain_id, 50,
      :texture_pitch_alignment, 51,
      :maximum_texturecubemap_width, 52,
      :maximum_texturecubemap_layered_width, 53,
      :maximum_texturecubemap_layered_layers, 54,
      :maximum_surface1d_width, 55,
      :maximum_surface2d_width, 56,
      :maximum_surface2d_height, 57,
      :maximum_surface3d_width, 58,
      :maximum_surface3d_height, 59,
      :maximum_surface3d_depth, 60,
      :maximum_surface1d_layered_width, 61,
      :maximum_surface1d_layered_layers, 62,
      :maximum_surface2d_layered_width, 63,
      :maximum_surface2d_layered_height, 64,
      :maximum_surface2d_layered_layers, 65,
      :maximum_surfacecubemap_width, 66,
      :maximum_surfacecubemap_layered_width, 67,
      :maximum_surfacecubemap_layered_layers, 68,
      :maximum_texture1d_linear_width, 69,
      :maximum_texture2d_linear_width, 70,
      :maximum_texture2d_linear_height, 71,
      :maximum_texture2d_linear_pitch, 72,
      :maximum_texture2d_mipmapped_width, 73,
      :maximum_texture2d_mipmapped_height, 74,
      :compute_capability_major, 75,
      :compute_capability_minor, 76,
      :maximum_texture1d_mipmapped_width, 77,
      :stream_priorities_supported, 78,
      :global_l1_cache_supported, 79,
      :local_l1_cache_supported, 80,
      :max_shared_memory_per_multiprocessor, 81,
      :max_registers_per_multiprocessor, 82,
      :managed_memory, 83,
      :multi_gpu_board, 84,
      :multi_gpu_board_group_id, 85,
      :host_native_atomic_supported, 86,
      :single_to_double_precision_perf_ratio, 87,
      :pageable_memory_access, 88,
      :concurrent_managed_access, 89,
      :compute_preemption_supported, 90,
      :can_use_host_pointer_for_registered_mem, 91,
      :can_use_stream_mem_ops, 92,
      :can_use_64_bit_stream_mem_ops, 93,
      :can_use_stream_wait_value_nor, 94,
      :cooperative_launch, 95,
      :cooperative_multi_device_launch, 96,
      :max_shared_memory_per_block_optin, 97,
      :can_flush_remote_writes, 98,
      :host_register_supported, 99,
      :pageable_memory_access_uses_host_page_tables, 100,
      :direct_managed_mem_access_from_host, 101,
      :virtual_address_management_supported, 102,
      :virtual_memory_management_supported, 102,
      :handle_type_posix_file_descriptor_supported, 103,
      :handle_type_win32_handle_supported, 104,
      :handle_type_win32_kmt_handle_supported, 105,
      :max_blocks_per_multiprocessor, 106,
      :generic_compression_supported, 107,
      :max_persisting_l2_cache_size, 108,
      :max_access_policy_window_size, 109,
      :gpu_direct_rdma_with_cuda_vmm_supported, 110,
      :reserved_shared_memory_per_block, 111,
      :sparse_cuda_array_supported, 112,
      :read_only_host_register_supported, 113,
      :timeline_semaphore_interop_supported, 114,
      :memory_pools_supported, 115,
      :gpu_direct_rdma_supported, 116,
      :gpu_direct_rdma_flush_writes_options, 117,
      :gpu_direct_rdma_writes_ordering, 118,
      :mempool_supported_handle_types, 119,
      :max
    ]

    class CUdevpropSt < FFI::Struct
      layout(
        :maxThreadsPerBlock, :int,
        :maxThreadsDim, [:int, 3],
        :maxGridSize, [:int, 3],
        :sharedMemPerBlock, :int,
        :totalConstantMemory, :int,
        :SIMDWidth, :int,
        :memPitch, :int,
        :regsPerBlock, :int,
        :clockRate, :int,
        :textureAlign, :int
      )
    end
    typedef CUdevpropSt.by_value, :CUdevprop_v1
    typedef :CUdevprop_v1, :CUdevprop
    CU_POINTER_ATTRIBUTE_CONTEXT = 1
    CU_POINTER_ATTRIBUTE_MEMORY_TYPE = 2
    CU_POINTER_ATTRIBUTE_DEVICE_POINTER = 3
    CU_POINTER_ATTRIBUTE_HOST_POINTER = 4
    CU_POINTER_ATTRIBUTE_P2P_TOKENS = 5
    CU_POINTER_ATTRIBUTE_SYNC_MEMOPS = 6
    CU_POINTER_ATTRIBUTE_BUFFER_ID = 7
    CU_POINTER_ATTRIBUTE_IS_MANAGED = 8
    CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL = 9
    CU_POINTER_ATTRIBUTE_IS_LEGACY_CUDA_IPC_CAPABLE = 10
    CU_POINTER_ATTRIBUTE_RANGE_START_ADDR = 11
    CU_POINTER_ATTRIBUTE_RANGE_SIZE = 12
    CU_POINTER_ATTRIBUTE_MAPPED = 13
    CU_POINTER_ATTRIBUTE_ALLOWED_HANDLE_TYPES = 14
    CU_POINTER_ATTRIBUTE_IS_GPU_DIRECT_RDMA_CAPABLE = 15
    CU_POINTER_ATTRIBUTE_ACCESS_FLAGS = 16
    CU_POINTER_ATTRIBUTE_MEMPOOL_HANDLE = 17
    CUpointer_attribute_enum = enum :CUpointer_attribute, [
      :context, 1,
      :memory_type, 2,
      :device_pointer, 3,
      :host_pointer, 4,
      :p2p_tokens, 5,
      :sync_memops, 6,
      :buffer_id, 7,
      :is_managed, 8,
      :device_ordinal, 9,
      :is_legacy_cuda_ipc_capable, 10,
      :range_start_addr, 11,
      :range_size, 12,
      :mapped, 13,
      :allowed_handle_types, 14,
      :is_gpu_direct_rdma_capable, 15,
      :access_flags, 16,
      :mempool_handle, 17
    ]

    CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 0
    CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES = 1
    CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES = 2
    CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES = 3
    CU_FUNC_ATTRIBUTE_NUM_REGS = 4
    CU_FUNC_ATTRIBUTE_PTX_VERSION = 5
    CU_FUNC_ATTRIBUTE_BINARY_VERSION = 6
    CU_FUNC_ATTRIBUTE_CACHE_MODE_CA = 7
    CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES = 8
    CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = 9
    CU_FUNC_ATTRIBUTE_MAX = CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT + 1
    CUfunction_attribute_enum = enum :CUfunction_attribute, [
      :max_threads_per_block, 0,
      :shared_size_bytes, 1,
      :const_size_bytes, 2,
      :local_size_bytes, 3,
      :num_regs, 4,
      :ptx_version, 5,
      :binary_version, 6,
      :cache_mode_ca, 7,
      :max_dynamic_shared_size_bytes, 8,
      :preferred_shared_memory_carveout, 9,
      :max
    ]

    CU_FUNC_CACHE_PREFER_NONE = 0x00
    CU_FUNC_CACHE_PREFER_SHARED = 0x01
    CU_FUNC_CACHE_PREFER_L1 = 0x02
    CU_FUNC_CACHE_PREFER_EQUAL = 0x03
    CUfunc_cache_enum = enum :CUfunc_cache, [
      :none, 0x00,
      :shared, 0x01,
      :l1, 0x02,
      :equal, 0x03
    ]

    CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE = 0x00
    CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE = 0x01
    CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE = 0x02
    CUsharedconfig_enum = enum :CUsharedconfig, [
      :default_bank_size, 0x00,
      :four_byte_bank_size, 0x01,
      :eight_byte_bank_size, 0x02
    ]

    CU_SHAREDMEM_CARVEOUT_DEFAULT = -1
    CU_SHAREDMEM_CARVEOUT_MAX_SHARED = 100
    CU_SHAREDMEM_CARVEOUT_MAX_L1 = 0
    CUshared_carveout_enum = enum :CUshared_carveout, [
      :default, -1,
      :max_shared, 100,
      :max_l1, 0
    ]

    CU_MEMORYTYPE_HOST = 0x01
    CU_MEMORYTYPE_DEVICE = 0x02
    CU_MEMORYTYPE_ARRAY = 0x03
    CU_MEMORYTYPE_UNIFIED = 0x04
    CUmemorytype_enum = enum :CUmemorytype, [
      :host, 0x01,
      :device, 0x02,
      :array, 0x03,
      :unified, 0x04
    ]

    CU_COMPUTEMODE_DEFAULT = 0
    CU_COMPUTEMODE_PROHIBITED = 2
    CU_COMPUTEMODE_EXCLUSIVE_PROCESS = 3
    CUcomputemode_enum = enum :CUcomputemode, [
      :default, 0,
      :prohibited, 2,
      :exclusive_process, 3
    ]

    CU_MEM_ADVISE_SET_READ_MOSTLY = 1
    CU_MEM_ADVISE_UNSET_READ_MOSTLY = 2
    CU_MEM_ADVISE_SET_PREFERRED_LOCATION = 3
    CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION = 4
    CU_MEM_ADVISE_SET_ACCESSED_BY = 5
    CU_MEM_ADVISE_UNSET_ACCESSED_BY = 6
    CUmem_advise_enum = enum :CUmem_advise, [
      :set_read_mostly, 1,
      :unset_read_mostly, 2,
      :set_preferred_location, 3,
      :unset_preferred_location, 4,
      :set_accessed_by, 5,
      :unset_accessed_by, 6
    ]

    CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY = 1
    CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION = 2
    CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY = 3
    CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION = 4
    CUmem_range_attribute_enum = enum :CUmem_range_attribute, [
      :read_mostly, 1,
      :preferred_location, 2,
      :accessed_by, 3,
      :last_prefetch_location, 4
    ]

    CU_JIT_MAX_REGISTERS = 0
    CU_JIT_THREADS_PER_BLOCK = CU_JIT_MAX_REGISTERS + 1
    CU_JIT_WALL_TIME = CU_JIT_THREADS_PER_BLOCK + 1
    CU_JIT_INFO_LOG_BUFFER = CU_JIT_WALL_TIME + 1
    CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES = CU_JIT_INFO_LOG_BUFFER + 1
    CU_JIT_ERROR_LOG_BUFFER = CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES + 1
    CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES = CU_JIT_ERROR_LOG_BUFFER + 1
    CU_JIT_OPTIMIZATION_LEVEL = CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES + 1
    CU_JIT_TARGET_FROM_CUCONTEXT = CU_JIT_OPTIMIZATION_LEVEL + 1
    CU_JIT_TARGET = CU_JIT_TARGET_FROM_CUCONTEXT + 1
    CU_JIT_FALLBACK_STRATEGY = CU_JIT_TARGET + 1
    CU_JIT_GENERATE_DEBUG_INFO = CU_JIT_FALLBACK_STRATEGY + 1
    CU_JIT_LOG_VERBOSE = CU_JIT_GENERATE_DEBUG_INFO + 1
    CU_JIT_GENERATE_LINE_INFO = CU_JIT_LOG_VERBOSE + 1
    CU_JIT_CACHE_MODE = CU_JIT_GENERATE_LINE_INFO + 1
    CU_JIT_NEW_SM3X_OPT = CU_JIT_CACHE_MODE + 1
    CU_JIT_FAST_COMPILE = CU_JIT_NEW_SM3X_OPT + 1
    CU_JIT_GLOBAL_SYMBOL_NAMES = CU_JIT_FAST_COMPILE + 1
    CU_JIT_GLOBAL_SYMBOL_ADDRESSES = CU_JIT_GLOBAL_SYMBOL_NAMES + 1
    CU_JIT_GLOBAL_SYMBOL_COUNT = CU_JIT_GLOBAL_SYMBOL_ADDRESSES + 1
    CU_JIT_LTO = CU_JIT_GLOBAL_SYMBOL_COUNT + 1
    CU_JIT_FTZ = CU_JIT_LTO + 1
    CU_JIT_PREC_DIV = CU_JIT_FTZ + 1
    CU_JIT_PREC_SQRT = CU_JIT_PREC_DIV + 1
    CU_JIT_FMA = CU_JIT_PREC_SQRT + 1
    CU_JIT_NUM_OPTIONS = CU_JIT_FMA + 1
    CUjit_option_enum = enum :CUjit_option, [
      :max_registers, 0,
      :threads_per_block,
      :wall_time,
      :info_log_buffer,
      :info_log_buffer_size_bytes,
      :error_log_buffer,
      :error_log_buffer_size_bytes,
      :optimization_level,
      :target_from_cucontext,
      :target,
      :fallback_strategy,
      :generate_debug_info,
      :log_verbose,
      :generate_line_info,
      :cache_mode,
      :new_sm3x_opt,
      :fast_compile,
      :global_symbol_names,
      :global_symbol_addresses,
      :global_symbol_count,
      :lto,
      :ftz,
      :prec_div,
      :prec_sqrt,
      :fma,
      :num_options
    ]

    CU_TARGET_COMPUTE_20 = 20
    CU_TARGET_COMPUTE_21 = 21
    CU_TARGET_COMPUTE_30 = 30
    CU_TARGET_COMPUTE_32 = 32
    CU_TARGET_COMPUTE_35 = 35
    CU_TARGET_COMPUTE_37 = 37
    CU_TARGET_COMPUTE_50 = 50
    CU_TARGET_COMPUTE_52 = 52
    CU_TARGET_COMPUTE_53 = 53
    CU_TARGET_COMPUTE_60 = 60
    CU_TARGET_COMPUTE_61 = 61
    CU_TARGET_COMPUTE_62 = 62
    CU_TARGET_COMPUTE_70 = 70
    CU_TARGET_COMPUTE_72 = 72
    CU_TARGET_COMPUTE_75 = 75
    CU_TARGET_COMPUTE_80 = 80
    CU_TARGET_COMPUTE_86 = 86
    CUjit_target_enum = enum :CUjit_target, [
      :'20', 20,
      :'21', 21,
      :'30', 30,
      :'32', 32,
      :'35', 35,
      :'37', 37,
      :'50', 50,
      :'52', 52,
      :'53', 53,
      :'60', 60,
      :'61', 61,
      :'62', 62,
      :'70', 70,
      :'72', 72,
      :'75', 75,
      :'80', 80,
      :'86', 86
    ]

    CU_PREFER_PTX = 0
    CU_PREFER_BINARY = CU_PREFER_PTX + 1
    CUjit_fallback_enum = enum :CUjit_fallback, [
      :ptx, 0,
      :binary
    ]

    CU_JIT_CACHE_OPTION_NONE = 0
    CU_JIT_CACHE_OPTION_CG = CU_JIT_CACHE_OPTION_NONE + 1
    CU_JIT_CACHE_OPTION_CA = CU_JIT_CACHE_OPTION_CG + 1
    CUjit_cacheMode_enum = enum :CUjit_cacheMode, [
      :none, 0,
      :cg,
      :ca
    ]

    CU_JIT_INPUT_CUBIN = 0
    CU_JIT_INPUT_PTX = CU_JIT_INPUT_CUBIN + 1
    CU_JIT_INPUT_FATBINARY = CU_JIT_INPUT_PTX + 1
    CU_JIT_INPUT_OBJECT = CU_JIT_INPUT_FATBINARY + 1
    CU_JIT_INPUT_LIBRARY = CU_JIT_INPUT_OBJECT + 1
    CU_JIT_INPUT_NVVM = CU_JIT_INPUT_LIBRARY + 1
    CU_JIT_NUM_INPUT_TYPES = CU_JIT_INPUT_NVVM + 1
    CUjitInputType_enum = enum :CUjitInputType, [
      :input_cubin, 0,
      :input_ptx,
      :input_fatbinary,
      :input_object,
      :input_library,
      :input_nvvm,
      :num_input_types
    ]

    typedef :pointer, :CUlinkState
    CU_GRAPHICS_REGISTER_FLAGS_NONE = 0x00
    CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY = 0x01
    CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD = 0x02
    CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST = 0x04
    CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER = 0x08
    CUgraphicsRegisterFlags_enum = enum :CUgraphicsRegisterFlags, [
      :none, 0x00,
      :read_only, 0x01,
      :write_discard, 0x02,
      :surface_ldst, 0x04,
      :texture_gather, 0x08
    ]

    CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE = 0x00
    CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY = 0x01
    CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD = 0x02
    CUgraphicsMapResourceFlags_enum = enum :CUgraphicsMapResourceFlags, [
      :none, 0x00,
      :read_only, 0x01,
      :write_discard, 0x02
    ]

    CU_CUBEMAP_FACE_POSITIVE_X = 0x00
    CU_CUBEMAP_FACE_NEGATIVE_X = 0x01
    CU_CUBEMAP_FACE_POSITIVE_Y = 0x02
    CU_CUBEMAP_FACE_NEGATIVE_Y = 0x03
    CU_CUBEMAP_FACE_POSITIVE_Z = 0x04
    CU_CUBEMAP_FACE_NEGATIVE_Z = 0x05
    CUarray_cubemap_face_enum = enum :CUarray_cubemap_face, [
      :positive_x, 0x00,
      :negative_x, 0x01,
      :positive_y, 0x02,
      :negative_y, 0x03,
      :positive_z, 0x04,
      :negative_z, 0x05
    ]

    CU_LIMIT_STACK_SIZE = 0x00
    CU_LIMIT_PRINTF_FIFO_SIZE = 0x01
    CU_LIMIT_MALLOC_HEAP_SIZE = 0x02
    CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH = 0x03
    CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT = 0x04
    CU_LIMIT_MAX_L2_FETCH_GRANULARITY = 0x05
    CU_LIMIT_PERSISTING_L2_CACHE_SIZE = 0x06
    CU_LIMIT_MAX = CU_LIMIT_PERSISTING_L2_CACHE_SIZE + 1
    CUlimit_enum = enum :CUlimit, [
      :stack_size, 0x00,
      :printf_fifo_size, 0x01,
      :malloc_heap_size, 0x02,
      :dev_runtime_sync_depth, 0x03,
      :dev_runtime_pending_launch_count, 0x04,
      :max_l2_fetch_granularity, 0x05,
      :persisting_l2_cache_size, 0x06,
      :max
    ]

    CU_RESOURCE_TYPE_ARRAY = 0x00
    CU_RESOURCE_TYPE_MIPMAPPED_ARRAY = 0x01
    CU_RESOURCE_TYPE_LINEAR = 0x02
    CU_RESOURCE_TYPE_PITCH2D = 0x03
    CUresourcetype_enum = enum :CUresourcetype, [
      :array, 0x00,
      :mipmapped_array, 0x01,
      :linear, 0x02,
      :pitch2d, 0x03
    ]

    Callback_CUhostFn = callback(:CUhostFn, [:pointer], :void)
    CU_ACCESS_PROPERTY_NORMAL = 0
    CU_ACCESS_PROPERTY_STREAMING = 1
    CU_ACCESS_PROPERTY_PERSISTING = 2
    CUaccessProperty_enum = enum :CUaccessProperty, [
      :normal, 0,
      :streaming, 1,
      :persisting, 2
    ]

    class CUaccessPolicyWindowSt < FFI::Struct
      layout(
        :base_ptr, :pointer,
        :num_bytes, :size_t,
        :hitRatio, :float,
        :hitProp, :CUaccessProperty,
        :missProp, :CUaccessProperty
      )
    end
    typedef CUaccessPolicyWindowSt.by_value, :CUaccessPolicyWindow_v1
    typedef :CUaccessPolicyWindow_v1, :CUaccessPolicyWindow
    class CUDAKERNELNODEPARAMSSt < FFI::Struct
      layout(
        :func, :CUfunction,
        :gridDimX, :uint,
        :gridDimY, :uint,
        :gridDimZ, :uint,
        :blockDimX, :uint,
        :blockDimY, :uint,
        :blockDimZ, :uint,
        :sharedMemBytes, :uint,
        :kernelParams, :pointer,
        :extra, :pointer
      )
    end
    typedef CUDAKERNELNODEPARAMSSt.by_value, :CUDA_KERNEL_NODE_PARAMS_v1
    typedef :CUDA_KERNEL_NODE_PARAMS_v1, :CUDA_KERNEL_NODE_PARAMS
    class CUDAMEMSETNODEPARAMSSt < FFI::Struct
      layout(
        :dst, :CUdeviceptr,
        :pitch, :size_t,
        :value, :uint,
        :elementSize, :uint,
        :width, :size_t,
        :height, :size_t
      )
    end
    typedef CUDAMEMSETNODEPARAMSSt.by_value, :CUDA_MEMSET_NODE_PARAMS_v1
    typedef :CUDA_MEMSET_NODE_PARAMS_v1, :CUDA_MEMSET_NODE_PARAMS
    class CUDAHOSTNODEPARAMSSt < FFI::Struct
      layout(
        :fn, Callback_CUhostFn,
        :userData, :pointer
      )
      def fn=(cb)
        @fn = cb
        self[:fn] = @fn
      end

      attr_reader :fn
    end
    typedef CUDAHOSTNODEPARAMSSt.by_value, :CUDA_HOST_NODE_PARAMS_v1
    typedef :CUDA_HOST_NODE_PARAMS_v1, :CUDA_HOST_NODE_PARAMS
    CU_GRAPH_NODE_TYPE_KERNEL = 0
    CU_GRAPH_NODE_TYPE_MEMCPY = 1
    CU_GRAPH_NODE_TYPE_MEMSET = 2
    CU_GRAPH_NODE_TYPE_HOST = 3
    CU_GRAPH_NODE_TYPE_GRAPH = 4
    CU_GRAPH_NODE_TYPE_EMPTY = 5
    CU_GRAPH_NODE_TYPE_WAIT_EVENT = 6
    CU_GRAPH_NODE_TYPE_EVENT_RECORD = 7
    CU_GRAPH_NODE_TYPE_EXT_SEMAS_SIGNAL = 8
    CU_GRAPH_NODE_TYPE_EXT_SEMAS_WAIT = 9
    CU_GRAPH_NODE_TYPE_MEM_ALLOC = 10
    CU_GRAPH_NODE_TYPE_MEM_FREE = 11
    CUgraphNodeType_enum = enum :CUgraphNodeType, [
      :kernel, 0,
      :memcpy, 1,
      :memset, 2,
      :host, 3,
      :graph, 4,
      :empty, 5,
      :wait_event, 6,
      :event_record, 7,
      :ext_semas_signal, 8,
      :ext_semas_wait, 9,
      :mem_alloc, 10,
      :mem_free, 11
    ]

    CU_SYNC_POLICY_AUTO = 1
    CU_SYNC_POLICY_SPIN = 2
    CU_SYNC_POLICY_YIELD = 3
    CU_SYNC_POLICY_BLOCKING_SYNC = 4
    CUsynchronizationPolicy_enum = enum :CUsynchronizationPolicy, [
      :auto, 1,
      :spin, 2,
      :yield, 3,
      :blocking_sync, 4
    ]

    CU_KERNEL_NODE_ATTRIBUTE_ACCESS_POLICY_WINDOW = 1
    CU_KERNEL_NODE_ATTRIBUTE_COOPERATIVE = 2
    CUkernelNodeAttrID_enum = enum :CUkernelNodeAttrID, [
      :access_policy_window, 1,
      :cooperative, 2
    ]

    class CUkernelNodeAttrValueUnion < FFI::Union
      layout(
        :accessPolicyWindow, :CUaccessPolicyWindow,
        :cooperative, :int
      )
    end
    typedef CUkernelNodeAttrValueUnion.by_value, :CUkernelNodeAttrValue_v1
    typedef :CUkernelNodeAttrValue_v1, :CUkernelNodeAttrValue
    CU_STREAM_CAPTURE_STATUS_NONE = 0
    CU_STREAM_CAPTURE_STATUS_ACTIVE = 1
    CU_STREAM_CAPTURE_STATUS_INVALIDATED = 2
    CUstreamCaptureStatus_enum = enum :CUstreamCaptureStatus, [
      :none, 0,
      :active, 1,
      :invalidated, 2
    ]

    CU_STREAM_CAPTURE_MODE_GLOBAL = 0
    CU_STREAM_CAPTURE_MODE_THREAD_LOCAL = 1
    CU_STREAM_CAPTURE_MODE_RELAXED = 2
    CUstreamCaptureMode_enum = enum :CUstreamCaptureMode, [
      :global, 0,
      :thread_local, 1,
      :relaxed, 2
    ]

    CU_STREAM_ATTRIBUTE_ACCESS_POLICY_WINDOW = 1
    CU_STREAM_ATTRIBUTE_SYNCHRONIZATION_POLICY = 3
    CUstreamAttrID_enum = enum :CUstreamAttrID, [
      :access_policy_window, 1,
      :synchronization_policy, 3
    ]

    class CUstreamAttrValueUnion < FFI::Union
      layout(
        :accessPolicyWindow, :CUaccessPolicyWindow,
        :syncPolicy, :CUsynchronizationPolicy
      )
    end
    typedef CUstreamAttrValueUnion.by_value, :CUstreamAttrValue_v1
    typedef :CUstreamAttrValue_v1, :CUstreamAttrValue
    CU_GET_PROC_ADDRESS_DEFAULT = 0
    CU_GET_PROC_ADDRESS_LEGACY_STREAM = 1 << 0
    CU_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM = 1 << 1
    CUdriverProcAddress_flags_enum = enum :CUdriverProcAddress_flags, [
      :default, 0,
      :legacy_stream, 1 << 0,
      :per_thread_default_stream, 1 << 1
    ]

    CU_EXEC_AFFINITY_TYPE_SM_COUNT = 0
    CU_EXEC_AFFINITY_TYPE_MAX = CU_EXEC_AFFINITY_TYPE_SM_COUNT + 1
    CUexecAffinityType_enum = enum :CUexecAffinityType, [
      :sm_count, 0,
      :max
    ]

    class CUexecAffinitySmCountSt < FFI::Struct
      layout(
        :val, :uint
      )
    end
    typedef CUexecAffinitySmCountSt.by_value, :CUexecAffinitySmCount_v1
    typedef :CUexecAffinitySmCount_v1, :CUexecAffinitySmCount
    class CUexecAffinityParamStParam < FFI::Union
      layout(
        :smCount, :CUexecAffinitySmCount
      )
    end

    class CUexecAffinityParamSt < FFI::Struct
      layout(
        :type, :CUexecAffinityType,
        :param, CUexecAffinityParamStParam
      )
    end
    typedef CUexecAffinityParamSt.by_value, :CUexecAffinityParam_v1
    typedef :CUexecAffinityParam_v1, :CUexecAffinityParam
    CUDA_SUCCESS = 0
    CUDA_ERROR_INVALID_VALUE = 1
    CUDA_ERROR_OUT_OF_MEMORY = 2
    CUDA_ERROR_NOT_INITIALIZED = 3
    CUDA_ERROR_DEINITIALIZED = 4
    CUDA_ERROR_PROFILER_DISABLED = 5
    CUDA_ERROR_PROFILER_NOT_INITIALIZED = 6
    CUDA_ERROR_PROFILER_ALREADY_STARTED = 7
    CUDA_ERROR_PROFILER_ALREADY_STOPPED = 8
    CUDA_ERROR_STUB_LIBRARY = 34
    CUDA_ERROR_NO_DEVICE = 100
    CUDA_ERROR_INVALID_DEVICE = 101
    CUDA_ERROR_DEVICE_NOT_LICENSED = 102
    CUDA_ERROR_INVALID_IMAGE = 200
    CUDA_ERROR_INVALID_CONTEXT = 201
    CUDA_ERROR_CONTEXT_ALREADY_CURRENT = 202
    CUDA_ERROR_MAP_FAILED = 205
    CUDA_ERROR_UNMAP_FAILED = 206
    CUDA_ERROR_ARRAY_IS_MAPPED = 207
    CUDA_ERROR_ALREADY_MAPPED = 208
    CUDA_ERROR_NO_BINARY_FOR_GPU = 209
    CUDA_ERROR_ALREADY_ACQUIRED = 210
    CUDA_ERROR_NOT_MAPPED = 211
    CUDA_ERROR_NOT_MAPPED_AS_ARRAY = 212
    CUDA_ERROR_NOT_MAPPED_AS_POINTER = 213
    CUDA_ERROR_ECC_UNCORRECTABLE = 214
    CUDA_ERROR_UNSUPPORTED_LIMIT = 215
    CUDA_ERROR_CONTEXT_ALREADY_IN_USE = 216
    CUDA_ERROR_PEER_ACCESS_UNSUPPORTED = 217
    CUDA_ERROR_INVALID_PTX = 218
    CUDA_ERROR_INVALID_GRAPHICS_CONTEXT = 219
    CUDA_ERROR_NVLINK_UNCORRECTABLE = 220
    CUDA_ERROR_JIT_COMPILER_NOT_FOUND = 221
    CUDA_ERROR_UNSUPPORTED_PTX_VERSION = 222
    CUDA_ERROR_JIT_COMPILATION_DISABLED = 223
    CUDA_ERROR_UNSUPPORTED_EXEC_AFFINITY = 224
    CUDA_ERROR_INVALID_SOURCE = 300
    CUDA_ERROR_FILE_NOT_FOUND = 301
    CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND = 302
    CUDA_ERROR_SHARED_OBJECT_INIT_FAILED = 303
    CUDA_ERROR_OPERATING_SYSTEM = 304
    CUDA_ERROR_INVALID_HANDLE = 400
    CUDA_ERROR_ILLEGAL_STATE = 401
    CUDA_ERROR_NOT_FOUND = 500
    CUDA_ERROR_NOT_READY = 600
    CUDA_ERROR_ILLEGAL_ADDRESS = 700
    CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES = 701
    CUDA_ERROR_LAUNCH_TIMEOUT = 702
    CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING = 703
    CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED = 704
    CUDA_ERROR_PEER_ACCESS_NOT_ENABLED = 705
    CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE = 708
    CUDA_ERROR_CONTEXT_IS_DESTROYED = 709
    CUDA_ERROR_ASSERT = 710
    CUDA_ERROR_TOO_MANY_PEERS = 711
    CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED = 712
    CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED = 713
    CUDA_ERROR_HARDWARE_STACK_ERROR = 714
    CUDA_ERROR_ILLEGAL_INSTRUCTION = 715
    CUDA_ERROR_MISALIGNED_ADDRESS = 716
    CUDA_ERROR_INVALID_ADDRESS_SPACE = 717
    CUDA_ERROR_INVALID_PC = 718
    CUDA_ERROR_LAUNCH_FAILED = 719
    CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE = 720
    CUDA_ERROR_NOT_PERMITTED = 800
    CUDA_ERROR_NOT_SUPPORTED = 801
    CUDA_ERROR_SYSTEM_NOT_READY = 802
    CUDA_ERROR_SYSTEM_DRIVER_MISMATCH = 803
    CUDA_ERROR_COMPAT_NOT_SUPPORTED_ON_DEVICE = 804
    CUDA_ERROR_MPS_CONNECTION_FAILED = 805
    CUDA_ERROR_MPS_RPC_FAILURE = 806
    CUDA_ERROR_MPS_SERVER_NOT_READY = 807
    CUDA_ERROR_MPS_MAX_CLIENTS_REACHED = 808
    CUDA_ERROR_MPS_MAX_CONNECTIONS_REACHED = 809
    CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED = 900
    CUDA_ERROR_STREAM_CAPTURE_INVALIDATED = 901
    CUDA_ERROR_STREAM_CAPTURE_MERGE = 902
    CUDA_ERROR_STREAM_CAPTURE_UNMATCHED = 903
    CUDA_ERROR_STREAM_CAPTURE_UNJOINED = 904
    CUDA_ERROR_STREAM_CAPTURE_ISOLATION = 905
    CUDA_ERROR_STREAM_CAPTURE_IMPLICIT = 906
    CUDA_ERROR_CAPTURED_EVENT = 907
    CUDA_ERROR_STREAM_CAPTURE_WRONG_THREAD = 908
    CUDA_ERROR_TIMEOUT = 909
    CUDA_ERROR_GRAPH_EXEC_UPDATE_FAILURE = 910
    CUDA_ERROR_EXTERNAL_DEVICE = 911
    CUDA_ERROR_UNKNOWN = 999
    cudaError_enum = enum :CUresult, [
      :success, 0,
      :error_invalid_value, 1,
      :error_out_of_memory, 2,
      :error_not_initialized, 3,
      :error_deinitialized, 4,
      :error_profiler_disabled, 5,
      :error_profiler_not_initialized, 6,
      :error_profiler_already_started, 7,
      :error_profiler_already_stopped, 8,
      :error_stub_library, 34,
      :error_no_device, 100,
      :error_invalid_device, 101,
      :error_device_not_licensed, 102,
      :error_invalid_image, 200,
      :error_invalid_context, 201,
      :error_context_already_current, 202,
      :error_map_failed, 205,
      :error_unmap_failed, 206,
      :error_array_is_mapped, 207,
      :error_already_mapped, 208,
      :error_no_binary_for_gpu, 209,
      :error_already_acquired, 210,
      :error_not_mapped, 211,
      :error_not_mapped_as_array, 212,
      :error_not_mapped_as_pointer, 213,
      :error_ecc_uncorrectable, 214,
      :error_unsupported_limit, 215,
      :error_context_already_in_use, 216,
      :error_peer_access_unsupported, 217,
      :error_invalid_ptx, 218,
      :error_invalid_graphics_context, 219,
      :error_nvlink_uncorrectable, 220,
      :error_jit_compiler_not_found, 221,
      :error_unsupported_ptx_version, 222,
      :error_jit_compilation_disabled, 223,
      :error_unsupported_exec_affinity, 224,
      :error_invalid_source, 300,
      :error_file_not_found, 301,
      :error_shared_object_symbol_not_found, 302,
      :error_shared_object_init_failed, 303,
      :error_operating_system, 304,
      :error_invalid_handle, 400,
      :error_illegal_state, 401,
      :error_not_found, 500,
      :error_not_ready, 600,
      :error_illegal_address, 700,
      :error_launch_out_of_resources, 701,
      :error_launch_timeout, 702,
      :error_launch_incompatible_texturing, 703,
      :error_peer_access_already_enabled, 704,
      :error_peer_access_not_enabled, 705,
      :error_primary_context_active, 708,
      :error_context_is_destroyed, 709,
      :error_assert, 710,
      :error_too_many_peers, 711,
      :error_host_memory_already_registered, 712,
      :error_host_memory_not_registered, 713,
      :error_hardware_stack_error, 714,
      :error_illegal_instruction, 715,
      :error_misaligned_address, 716,
      :error_invalid_address_space, 717,
      :error_invalid_pc, 718,
      :error_launch_failed, 719,
      :error_cooperative_launch_too_large, 720,
      :error_not_permitted, 800,
      :error_not_supported, 801,
      :error_system_not_ready, 802,
      :error_system_driver_mismatch, 803,
      :error_compat_not_supported_on_device, 804,
      :error_mps_connection_failed, 805,
      :error_mps_rpc_failure, 806,
      :error_mps_server_not_ready, 807,
      :error_mps_max_clients_reached, 808,
      :error_mps_max_connections_reached, 809,
      :error_stream_capture_unsupported, 900,
      :error_stream_capture_invalidated, 901,
      :error_stream_capture_merge, 902,
      :error_stream_capture_unmatched, 903,
      :error_stream_capture_unjoined, 904,
      :error_stream_capture_isolation, 905,
      :error_stream_capture_implicit, 906,
      :error_captured_event, 907,
      :error_stream_capture_wrong_thread, 908,
      :error_timeout, 909,
      :error_graph_exec_update_failure, 910,
      :error_external_device, 911,
      :error_unknown, 999
    ]

    CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK = 0x01
    CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED = 0x02
    CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED = 0x03
    CU_DEVICE_P2P_ATTRIBUTE_ACCESS_ACCESS_SUPPORTED = 0x04
    CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED = 0x04
    CUdevice_P2PAttribute_enum = enum :CUdevice_P2PAttribute, [
      :performance_rank, 0x01,
      :access_supported, 0x02,
      :native_atomic_supported, 0x03,
      :access_access_supported, 0x04,
      :cuda_array_access_supported, 0x04
    ]

    Callback_CUstreamCallback = callback(:CUstreamCallback, %i[CUstream CUresult pointer], :void)
    Callback_CUoccupancyB2DSize = callback(:CUoccupancyB2DSize, [:int], :size_t)
    CU_MEMHOSTALLOC_PORTABLE = 0x01
    CU_MEMHOSTALLOC_DEVICEMAP = 0x02
    CU_MEMHOSTALLOC_WRITECOMBINED = 0x04
    CU_MEMHOSTREGISTER_PORTABLE = 0x01
    CU_MEMHOSTREGISTER_DEVICEMAP = 0x02
    CU_MEMHOSTREGISTER_IOMEMORY = 0x04
    CU_MEMHOSTREGISTER_READ_ONLY = 0x08
    class CUDAMEMCPY2DSt < FFI::Struct
      layout(
        :srcXInBytes, :size_t,
        :srcY, :size_t,
        :srcMemoryType, :CUmemorytype,
        :srcHost, :pointer,
        :srcDevice, :CUdeviceptr,
        :srcArray, :CUarray,
        :srcPitch, :size_t,
        :dstXInBytes, :size_t,
        :dstY, :size_t,
        :dstMemoryType, :CUmemorytype,
        :dstHost, :pointer,
        :dstDevice, :CUdeviceptr,
        :dstArray, :CUarray,
        :dstPitch, :size_t,
        :WidthInBytes, :size_t,
        :Height, :size_t
      )
    end
    typedef CUDAMEMCPY2DSt.by_value, :CUDA_MEMCPY2D_v2
    typedef :CUDA_MEMCPY2D_v2, :CUDA_MEMCPY2D
    class CUDAMEMCPY3DSt < FFI::Struct
      layout(
        :srcXInBytes, :size_t,
        :srcY, :size_t,
        :srcZ, :size_t,
        :srcLOD, :size_t,
        :srcMemoryType, :CUmemorytype,
        :srcHost, :pointer,
        :srcDevice, :CUdeviceptr,
        :srcArray, :CUarray,
        :reserved0, :pointer,
        :srcPitch, :size_t,
        :srcHeight, :size_t,
        :dstXInBytes, :size_t,
        :dstY, :size_t,
        :dstZ, :size_t,
        :dstLOD, :size_t,
        :dstMemoryType, :CUmemorytype,
        :dstHost, :pointer,
        :dstDevice, :CUdeviceptr,
        :dstArray, :CUarray,
        :reserved1, :pointer,
        :dstPitch, :size_t,
        :dstHeight, :size_t,
        :WidthInBytes, :size_t,
        :Height, :size_t,
        :Depth, :size_t
      )
    end
    typedef CUDAMEMCPY3DSt.by_value, :CUDA_MEMCPY3D_v2
    typedef :CUDA_MEMCPY3D_v2, :CUDA_MEMCPY3D
    class CUDAMEMCPY3DPEERSt < FFI::Struct
      layout(
        :srcXInBytes, :size_t,
        :srcY, :size_t,
        :srcZ, :size_t,
        :srcLOD, :size_t,
        :srcMemoryType, :CUmemorytype,
        :srcHost, :pointer,
        :srcDevice, :CUdeviceptr,
        :srcArray, :CUarray,
        :srcContext, :CUcontext,
        :srcPitch, :size_t,
        :srcHeight, :size_t,
        :dstXInBytes, :size_t,
        :dstY, :size_t,
        :dstZ, :size_t,
        :dstLOD, :size_t,
        :dstMemoryType, :CUmemorytype,
        :dstHost, :pointer,
        :dstDevice, :CUdeviceptr,
        :dstArray, :CUarray,
        :dstContext, :CUcontext,
        :dstPitch, :size_t,
        :dstHeight, :size_t,
        :WidthInBytes, :size_t,
        :Height, :size_t,
        :Depth, :size_t
      )
    end
    typedef CUDAMEMCPY3DPEERSt.by_value, :CUDA_MEMCPY3D_PEER_v1
    typedef :CUDA_MEMCPY3D_PEER_v1, :CUDA_MEMCPY3D_PEER
    class CUDAARRAYDESCRIPTORSt < FFI::Struct
      layout(
        :Width, :size_t,
        :Height, :size_t,
        :Format, :CUarray_format,
        :NumChannels, :uint
      )
    end
    typedef CUDAARRAYDESCRIPTORSt.by_value, :CUDA_ARRAY_DESCRIPTOR_v2
    typedef :CUDA_ARRAY_DESCRIPTOR_v2, :CUDA_ARRAY_DESCRIPTOR
    class CUDAARRAY3DDESCRIPTORSt < FFI::Struct
      layout(
        :Width, :size_t,
        :Height, :size_t,
        :Depth, :size_t,
        :Format, :CUarray_format,
        :NumChannels, :uint,
        :Flags, :uint
      )
    end
    typedef CUDAARRAY3DDESCRIPTORSt.by_value, :CUDA_ARRAY3D_DESCRIPTOR_v2
    typedef :CUDA_ARRAY3D_DESCRIPTOR_v2, :CUDA_ARRAY3D_DESCRIPTOR
    CU_ARRAY_SPARSE_PROPERTIES_SINGLE_MIPTAIL = 0x1
    class CUDAARRAYSPARSEPROPERTIESStTileExtent < FFI::Struct
      layout(
        :width, :uint,
        :height, :uint,
        :depth, :uint
      )
    end

    class CUDAARRAYSPARSEPROPERTIESSt < FFI::Struct
      layout(
        :tileExtent, CUDAARRAYSPARSEPROPERTIESStTileExtent,
        :miptailFirstLevel, :uint,
        :miptailSize, :ulong_long,
        :flags, :uint,
        :reserved, [:uint, 4]
      )
    end
    typedef CUDAARRAYSPARSEPROPERTIESSt.by_value, :CUDA_ARRAY_SPARSE_PROPERTIES_v1
    typedef :CUDA_ARRAY_SPARSE_PROPERTIES_v1, :CUDA_ARRAY_SPARSE_PROPERTIES
    class CUDARESOURCEDESCStResReserved < FFI::Struct
      layout(
        :reserved, [:int, 32]
      )
    end

    class CUDARESOURCEDESCStResPitch2D < FFI::Struct
      layout(
        :devPtr, :CUdeviceptr,
        :format, :CUarray_format,
        :numChannels, :uint,
        :width, :size_t,
        :height, :size_t,
        :pitchInBytes, :size_t
      )
    end

    class CUDARESOURCEDESCStResLinear < FFI::Struct
      layout(
        :devPtr, :CUdeviceptr,
        :format, :CUarray_format,
        :numChannels, :uint,
        :sizeInBytes, :size_t
      )
    end

    class CUDARESOURCEDESCStResMipmap < FFI::Struct
      layout(
        :hMipmappedArray, :CUmipmappedArray
      )
    end

    class CUDARESOURCEDESCStResArray < FFI::Struct
      layout(
        :hArray, :CUarray
      )
    end

    class CUDARESOURCEDESCStRes < FFI::Union
      layout(
        :array, CUDARESOURCEDESCStResArray,
        :mipmap, CUDARESOURCEDESCStResMipmap,
        :linear, CUDARESOURCEDESCStResLinear,
        :pitch2D, CUDARESOURCEDESCStResPitch2D,
        :reserved, CUDARESOURCEDESCStResReserved
      )
    end

    class CUDARESOURCEDESCSt < FFI::Struct
      layout(
        :resType, :CUresourcetype,
        :res, CUDARESOURCEDESCStRes,
        :flags, :uint
      )
    end
    typedef CUDARESOURCEDESCSt.by_value, :CUDA_RESOURCE_DESC_v1
    typedef :CUDA_RESOURCE_DESC_v1, :CUDA_RESOURCE_DESC
    class CUDATEXTUREDESCSt < FFI::Struct
      layout(
        :addressMode, [:CUaddress_mode, 3],
        :filterMode, :CUfilter_mode,
        :flags, :uint,
        :maxAnisotropy, :uint,
        :mipmapFilterMode, :CUfilter_mode,
        :mipmapLevelBias, :float,
        :minMipmapLevelClamp, :float,
        :maxMipmapLevelClamp, :float,
        :borderColor, [:float, 4],
        :reserved, [:int, 12]
      )
    end
    typedef CUDATEXTUREDESCSt.by_value, :CUDA_TEXTURE_DESC_v1
    typedef :CUDA_TEXTURE_DESC_v1, :CUDA_TEXTURE_DESC
    CU_RES_VIEW_FORMAT_NONE = 0x00
    CU_RES_VIEW_FORMAT_UINT_1X8 = 0x01
    CU_RES_VIEW_FORMAT_UINT_2X8 = 0x02
    CU_RES_VIEW_FORMAT_UINT_4X8 = 0x03
    CU_RES_VIEW_FORMAT_SINT_1X8 = 0x04
    CU_RES_VIEW_FORMAT_SINT_2X8 = 0x05
    CU_RES_VIEW_FORMAT_SINT_4X8 = 0x06
    CU_RES_VIEW_FORMAT_UINT_1X16 = 0x07
    CU_RES_VIEW_FORMAT_UINT_2X16 = 0x08
    CU_RES_VIEW_FORMAT_UINT_4X16 = 0x09
    CU_RES_VIEW_FORMAT_SINT_1X16 = 0x0a
    CU_RES_VIEW_FORMAT_SINT_2X16 = 0x0b
    CU_RES_VIEW_FORMAT_SINT_4X16 = 0x0c
    CU_RES_VIEW_FORMAT_UINT_1X32 = 0x0d
    CU_RES_VIEW_FORMAT_UINT_2X32 = 0x0e
    CU_RES_VIEW_FORMAT_UINT_4X32 = 0x0f
    CU_RES_VIEW_FORMAT_SINT_1X32 = 0x10
    CU_RES_VIEW_FORMAT_SINT_2X32 = 0x11
    CU_RES_VIEW_FORMAT_SINT_4X32 = 0x12
    CU_RES_VIEW_FORMAT_FLOAT_1X16 = 0x13
    CU_RES_VIEW_FORMAT_FLOAT_2X16 = 0x14
    CU_RES_VIEW_FORMAT_FLOAT_4X16 = 0x15
    CU_RES_VIEW_FORMAT_FLOAT_1X32 = 0x16
    CU_RES_VIEW_FORMAT_FLOAT_2X32 = 0x17
    CU_RES_VIEW_FORMAT_FLOAT_4X32 = 0x18
    CU_RES_VIEW_FORMAT_UNSIGNED_BC1 = 0x19
    CU_RES_VIEW_FORMAT_UNSIGNED_BC2 = 0x1a
    CU_RES_VIEW_FORMAT_UNSIGNED_BC3 = 0x1b
    CU_RES_VIEW_FORMAT_UNSIGNED_BC4 = 0x1c
    CU_RES_VIEW_FORMAT_SIGNED_BC4 = 0x1d
    CU_RES_VIEW_FORMAT_UNSIGNED_BC5 = 0x1e
    CU_RES_VIEW_FORMAT_SIGNED_BC5 = 0x1f
    CU_RES_VIEW_FORMAT_UNSIGNED_BC6H = 0x20
    CU_RES_VIEW_FORMAT_SIGNED_BC6H = 0x21
    CU_RES_VIEW_FORMAT_UNSIGNED_BC7 = 0x22
    CUresourceViewFormat_enum = enum :CUresourceViewFormat, [
      :none, 0x00,
      :uint_1x8, 0x01,
      :uint_2x8, 0x02,
      :uint_4x8, 0x03,
      :sint_1x8, 0x04,
      :sint_2x8, 0x05,
      :sint_4x8, 0x06,
      :uint_1x16, 0x07,
      :uint_2x16, 0x08,
      :uint_4x16, 0x09,
      :sint_1x16, 0x0a,
      :sint_2x16, 0x0b,
      :sint_4x16, 0x0c,
      :uint_1x32, 0x0d,
      :uint_2x32, 0x0e,
      :uint_4x32, 0x0f,
      :sint_1x32, 0x10,
      :sint_2x32, 0x11,
      :sint_4x32, 0x12,
      :float_1x16, 0x13,
      :float_2x16, 0x14,
      :float_4x16, 0x15,
      :float_1x32, 0x16,
      :float_2x32, 0x17,
      :float_4x32, 0x18,
      :unsigned_bc1, 0x19,
      :unsigned_bc2, 0x1a,
      :unsigned_bc3, 0x1b,
      :unsigned_bc4, 0x1c,
      :signed_bc4, 0x1d,
      :unsigned_bc5, 0x1e,
      :signed_bc5, 0x1f,
      :unsigned_bc6h, 0x20,
      :signed_bc6h, 0x21,
      :unsigned_bc7, 0x22
    ]

    class CUDARESOURCEVIEWDESCSt < FFI::Struct
      layout(
        :format, :CUresourceViewFormat,
        :width, :size_t,
        :height, :size_t,
        :depth, :size_t,
        :firstMipmapLevel, :uint,
        :lastMipmapLevel, :uint,
        :firstLayer, :uint,
        :lastLayer, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDARESOURCEVIEWDESCSt.by_value, :CUDA_RESOURCE_VIEW_DESC_v1
    typedef :CUDA_RESOURCE_VIEW_DESC_v1, :CUDA_RESOURCE_VIEW_DESC
    class CUDAPOINTERATTRIBUTEP2PTOKENSSt < FFI::Struct
      layout(
        :p2pToken, :ulong_long,
        :vaSpaceToken, :uint
      )
    end
    typedef CUDAPOINTERATTRIBUTEP2PTOKENSSt.by_value, :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1
    typedef :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1, :CUDA_POINTER_ATTRIBUTE_P2P_TOKENS
    CU_POINTER_ATTRIBUTE_ACCESS_FLAG_NONE = 0x0
    CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READ = 0x1
    CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READWRITE = 0x3
    CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum = enum :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS, [
      :none, 0x0,
      :read, 0x1,
      :readwrite, 0x3
    ]

    class CUDALAUNCHPARAMSSt < FFI::Struct
      layout(
        :function, :CUfunction,
        :gridDimX, :uint,
        :gridDimY, :uint,
        :gridDimZ, :uint,
        :blockDimX, :uint,
        :blockDimY, :uint,
        :blockDimZ, :uint,
        :sharedMemBytes, :uint,
        :hStream, :CUstream,
        :kernelParams, :pointer
      )
    end
    typedef CUDALAUNCHPARAMSSt.by_value, :CUDA_LAUNCH_PARAMS_v1
    typedef :CUDA_LAUNCH_PARAMS_v1, :CUDA_LAUNCH_PARAMS
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD = 1
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32 = 2
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT = 3
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP = 4
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE = 5
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE = 6
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE_KMT = 7
    CU_EXTERNAL_MEMORY_HANDLE_TYPE_NVSCIBUF = 8
    CUexternalMemoryHandleType_enum = enum :CUexternalMemoryHandleType, [
      :opaque_fd, 1,
      :opaque_win32, 2,
      :opaque_win32_kmt, 3,
      :d3d12_heap, 4,
      :d3d12_resource, 5,
      :d3d11_resource, 6,
      :d3d11_resource_kmt, 7,
      :nvscibuf, 8
    ]

    CUDA_EXTERNAL_MEMORY_DEDICATED = 0x1
    CUDA_EXTERNAL_SEMAPHORE_SIGNAL_SKIP_NVSCIBUF_MEMSYNC = 0x01
    CUDA_EXTERNAL_SEMAPHORE_WAIT_SKIP_NVSCIBUF_MEMSYNC = 0x02
    CUDA_NVSCISYNC_ATTR_SIGNAL = 0x1
    CUDA_NVSCISYNC_ATTR_WAIT = 0x2
    class CUDAEXTERNALMEMORYHANDLEDESCStHandleWin32 < FFI::Struct
      layout(
        :handle, :pointer,
        :name, :pointer
      )
    end

    class CUDAEXTERNALMEMORYHANDLEDESCStHandle < FFI::Union
      layout(
        :fd, :int,
        :win32, CUDAEXTERNALMEMORYHANDLEDESCStHandleWin32,
        :nvSciBufObject, :pointer
      )
    end

    class CUDAEXTERNALMEMORYHANDLEDESCSt < FFI::Struct
      layout(
        :type, :CUexternalMemoryHandleType,
        :handle, CUDAEXTERNALMEMORYHANDLEDESCStHandle,
        :size, :ulong_long,
        :flags, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALMEMORYHANDLEDESCSt.by_value, :CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1, :CUDA_EXTERNAL_MEMORY_HANDLE_DESC
    class CUDAEXTERNALMEMORYBUFFERDESCSt < FFI::Struct
      layout(
        :offset, :ulong_long,
        :size, :ulong_long,
        :flags, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALMEMORYBUFFERDESCSt.by_value, :CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1, :CUDA_EXTERNAL_MEMORY_BUFFER_DESC
    class CUDAEXTERNALMEMORYMIPMAPPEDARRAYDESCSt < FFI::Struct
      layout(
        :offset, :ulong_long,
        :arrayDesc, :CUDA_ARRAY3D_DESCRIPTOR,
        :numLevels, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALMEMORYMIPMAPPEDARRAYDESCSt.by_value, :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1
    typedef :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1, :CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD = 1
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32 = 2
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT = 3
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE = 4
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_FENCE = 5
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_NVSCISYNC = 6
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX = 7
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX_KMT = 8
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_FD = 9
    CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_WIN32 = 10
    CUexternalSemaphoreHandleType_enum = enum :CUexternalSemaphoreHandleType, [
      :opaque_fd, 1,
      :opaque_win32, 2,
      :opaque_win32_kmt, 3,
      :d3d12_fence, 4,
      :d3d11_fence, 5,
      :nvscisync, 6,
      :d3d11_keyed_mutex, 7,
      :d3d11_keyed_mutex_kmt, 8,
      :timeline_semaphore_fd, 9,
      :timeline_semaphore_win32, 10
    ]

    class CUDAEXTERNALSEMAPHOREHANDLEDESCStHandleWin32 < FFI::Struct
      layout(
        :handle, :pointer,
        :name, :pointer
      )
    end

    class CUDAEXTERNALSEMAPHOREHANDLEDESCStHandle < FFI::Union
      layout(
        :fd, :int,
        :win32, CUDAEXTERNALSEMAPHOREHANDLEDESCStHandleWin32,
        :nvSciSyncObj, :pointer
      )
    end

    class CUDAEXTERNALSEMAPHOREHANDLEDESCSt < FFI::Struct
      layout(
        :type, :CUexternalSemaphoreHandleType,
        :handle, CUDAEXTERNALSEMAPHOREHANDLEDESCStHandle,
        :flags, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALSEMAPHOREHANDLEDESCSt.by_value, :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1, :CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC
    class CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsKeyedMutex < FFI::Struct
      layout(
        :key, :ulong_long
      )
    end

    class CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsNvSciSync < FFI::Union
      layout(
        :fence, :pointer,
        :reserved, :ulong_long
      )
    end

    class CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsFence < FFI::Struct
      layout(
        :value, :ulong_long
      )
    end

    class CUDAEXTERNALSEMAPHORESIGNALPARAMSStParams < FFI::Struct
      layout(
        :fence, CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsFence,
        :nvSciSync, CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsNvSciSync,
        :keyedMutex, CUDAEXTERNALSEMAPHORESIGNALPARAMSStParamsKeyedMutex,
        :reserved, [:uint, 12]
      )
    end

    class CUDAEXTERNALSEMAPHORESIGNALPARAMSSt < FFI::Struct
      layout(
        :params, CUDAEXTERNALSEMAPHORESIGNALPARAMSStParams,
        :flags, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALSEMAPHORESIGNALPARAMSSt.by_value, :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1, :CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS
    class CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsKeyedMutex < FFI::Struct
      layout(
        :key, :ulong_long,
        :timeoutMs, :uint
      )
    end

    class CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsNvSciSync < FFI::Union
      layout(
        :fence, :pointer,
        :reserved, :ulong_long
      )
    end

    class CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsFence < FFI::Struct
      layout(
        :value, :ulong_long
      )
    end

    class CUDAEXTERNALSEMAPHOREWAITPARAMSStParams < FFI::Struct
      layout(
        :fence, CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsFence,
        :nvSciSync, CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsNvSciSync,
        :keyedMutex, CUDAEXTERNALSEMAPHOREWAITPARAMSStParamsKeyedMutex,
        :reserved, [:uint, 10]
      )
    end

    class CUDAEXTERNALSEMAPHOREWAITPARAMSSt < FFI::Struct
      layout(
        :params, CUDAEXTERNALSEMAPHOREWAITPARAMSStParams,
        :flags, :uint,
        :reserved, [:uint, 16]
      )
    end
    typedef CUDAEXTERNALSEMAPHOREWAITPARAMSSt.by_value, :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1
    typedef :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1, :CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS
    class CUDAEXTSEMSIGNALNODEPARAMSSt < FFI::Struct
      layout(
        :extSemArray, :pointer,
        :paramsArray, :pointer,
        :numExtSems, :uint
      )
    end
    typedef CUDAEXTSEMSIGNALNODEPARAMSSt.by_value, :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1
    typedef :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1, :CUDA_EXT_SEM_SIGNAL_NODE_PARAMS
    class CUDAEXTSEMWAITNODEPARAMSSt < FFI::Struct
      layout(
        :extSemArray, :pointer,
        :paramsArray, :pointer,
        :numExtSems, :uint
      )
    end
    typedef CUDAEXTSEMWAITNODEPARAMSSt.by_value, :CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1
    typedef :CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1, :CUDA_EXT_SEM_WAIT_NODE_PARAMS
    typedef :ulong_long, :CUmemGenericAllocationHandle_v1
    typedef :CUmemGenericAllocationHandle_v1, :CUmemGenericAllocationHandle
    CU_MEM_HANDLE_TYPE_NONE = 0x0
    CU_MEM_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR = 0x1
    CU_MEM_HANDLE_TYPE_WIN32 = 0x2
    CU_MEM_HANDLE_TYPE_WIN32_KMT = 0x4
    CU_MEM_HANDLE_TYPE_MAX = 0x7FFFFFFF
    CUmemAllocationHandleType_enum = enum :CUmemAllocationHandleType, [
      :none, 0x0,
      :posix_file_descriptor, 0x1,
      :win32, 0x2,
      :win32_kmt, 0x4,
      :max, 0x7FFFFFFF
    ]

    CU_MEM_ACCESS_FLAGS_PROT_NONE = 0x0
    CU_MEM_ACCESS_FLAGS_PROT_READ = 0x1
    CU_MEM_ACCESS_FLAGS_PROT_READWRITE = 0x3
    CU_MEM_ACCESS_FLAGS_PROT_MAX = 0x7FFFFFFF
    CUmemAccess_flags_enum = enum :CUmemAccess_flags, [
      :none, 0x0,
      :read, 0x1,
      :readwrite, 0x3,
      :max, 0x7FFFFFFF
    ]

    CU_MEM_LOCATION_TYPE_INVALID = 0x0
    CU_MEM_LOCATION_TYPE_DEVICE = 0x1
    CU_MEM_LOCATION_TYPE_MAX = 0x7FFFFFFF
    CUmemLocationType_enum = enum :CUmemLocationType, [
      :invalid, 0x0,
      :device, 0x1,
      :max, 0x7FFFFFFF
    ]

    CU_MEM_ALLOCATION_TYPE_INVALID = 0x0
    CU_MEM_ALLOCATION_TYPE_PINNED = 0x1
    CU_MEM_ALLOCATION_TYPE_MAX = 0x7FFFFFFF
    CUmemAllocationType_enum = enum :CUmemAllocationType, [
      :invalid, 0x0,
      :pinned, 0x1,
      :max, 0x7FFFFFFF
    ]

    CU_MEM_ALLOC_GRANULARITY_MINIMUM = 0x0
    CU_MEM_ALLOC_GRANULARITY_RECOMMENDED = 0x1
    CUmemAllocationGranularity_flags_enum = enum :CUmemAllocationGranularity_flags, [
      :minimum, 0x0,
      :recommended, 0x1
    ]

    CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_SPARSE_LEVEL = 0
    CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_MIPTAIL = 1
    CUarraySparseSubresourceType_enum = enum :CUarraySparseSubresourceType, [
      :sparse_level, 0,
      :miptail, 1
    ]

    CU_MEM_OPERATION_TYPE_MAP = 1
    CU_MEM_OPERATION_TYPE_UNMAP = 2
    CUmemOperationType_enum = enum :CUmemOperationType, [
      :map, 1,
      :unmap, 2
    ]

    CU_MEM_HANDLE_TYPE_GENERIC = 0
    CUmemHandleType_enum = enum :CUmemHandleType, [
      :generic, 0
    ]

    class CUarrayMapInfoStMemHandle < FFI::Union
      layout(
        :memHandle, :CUmemGenericAllocationHandle
      )
    end

    class CUarrayMapInfoStSubresourceMiptail < FFI::Struct
      layout(
        :layer, :uint,
        :offset, :ulong_long,
        :size, :ulong_long
      )
    end

    class CUarrayMapInfoStSubresourceSparseLevel < FFI::Struct
      layout(
        :level, :uint,
        :layer, :uint,
        :offsetX, :uint,
        :offsetY, :uint,
        :offsetZ, :uint,
        :extentWidth, :uint,
        :extentHeight, :uint,
        :extentDepth, :uint
      )
    end

    class CUarrayMapInfoStSubresource < FFI::Union
      layout(
        :sparseLevel, CUarrayMapInfoStSubresourceSparseLevel,
        :miptail, CUarrayMapInfoStSubresourceMiptail
      )
    end

    class CUarrayMapInfoStResource < FFI::Union
      layout(
        :mipmap, :CUmipmappedArray,
        :array, :CUarray
      )
    end

    class CUarrayMapInfoSt < FFI::Struct
      layout(
        :resourceType, :CUresourcetype,
        :resource, CUarrayMapInfoStResource,
        :subresourceType, :CUarraySparseSubresourceType,
        :subresource, CUarrayMapInfoStSubresource,
        :memOperationType, :CUmemOperationType,
        :memHandleType, :CUmemHandleType,
        :memHandle, CUarrayMapInfoStMemHandle,
        :offset, :ulong_long,
        :deviceBitMask, :uint,
        :flags, :uint,
        :reserved, [:uint, 2]
      )
    end
    typedef CUarrayMapInfoSt.by_value, :CUarrayMapInfo_v1
    typedef :CUarrayMapInfo_v1, :CUarrayMapInfo
    class CUmemLocationSt < FFI::Struct
      layout(
        :type, :CUmemLocationType,
        :id, :int
      )
    end
    typedef CUmemLocationSt.by_value, :CUmemLocation_v1
    typedef :CUmemLocation_v1, :CUmemLocation
    CU_MEM_ALLOCATION_COMP_NONE = 0x0
    CU_MEM_ALLOCATION_COMP_GENERIC = 0x1
    CUmemAllocationCompType_enum = enum :CUmemAllocationCompType, [
      :none, 0x0,
      :generic, 0x1
    ]

    CU_MEM_CREATE_USAGE_TILE_POOL = 0x1
    class CUmemAllocationPropStAllocFlags < FFI::Struct
      layout(
        :compressionType, :uchar,
        :gpuDirectRDMACapable, :uchar,
        :usage, :ushort,
        :reserved, [:uchar, 4]
      )
    end

    class CUmemAllocationPropSt < FFI::Struct
      layout(
        :type, :CUmemAllocationType,
        :requestedHandleTypes, :CUmemAllocationHandleType,
        :location, :CUmemLocation,
        :win32HandleMetaData, :pointer,
        :allocFlags, CUmemAllocationPropStAllocFlags
      )
    end
    typedef CUmemAllocationPropSt.by_value, :CUmemAllocationProp_v1
    typedef :CUmemAllocationProp_v1, :CUmemAllocationProp
    class CUmemAccessDescSt < FFI::Struct
      layout(
        :location, :CUmemLocation,
        :flags, :CUmemAccess_flags
      )
    end
    typedef CUmemAccessDescSt.by_value, :CUmemAccessDesc_v1
    typedef :CUmemAccessDesc_v1, :CUmemAccessDesc
    CU_GRAPH_EXEC_UPDATE_SUCCESS = 0x0
    CU_GRAPH_EXEC_UPDATE_ERROR = 0x1
    CU_GRAPH_EXEC_UPDATE_ERROR_TOPOLOGY_CHANGED = 0x2
    CU_GRAPH_EXEC_UPDATE_ERROR_NODE_TYPE_CHANGED = 0x3
    CU_GRAPH_EXEC_UPDATE_ERROR_FUNCTION_CHANGED = 0x4
    CU_GRAPH_EXEC_UPDATE_ERROR_PARAMETERS_CHANGED = 0x5
    CU_GRAPH_EXEC_UPDATE_ERROR_NOT_SUPPORTED = 0x6
    CU_GRAPH_EXEC_UPDATE_ERROR_UNSUPPORTED_FUNCTION_CHANGE = 0x7
    CUgraphExecUpdateResult_enum = enum :CUgraphExecUpdateResult, [
      :success, 0x0,
      :error, 0x1,
      :error_topology_changed, 0x2,
      :error_node_type_changed, 0x3,
      :error_function_changed, 0x4,
      :error_parameters_changed, 0x5,
      :error_not_supported, 0x6,
      :error_unsupported_function_change, 0x7
    ]

    CU_MEMPOOL_ATTR_REUSE_FOLLOW_EVENT_DEPENDENCIES = 1
    CU_MEMPOOL_ATTR_REUSE_ALLOW_OPPORTUNISTIC = CU_MEMPOOL_ATTR_REUSE_FOLLOW_EVENT_DEPENDENCIES + 1
    CU_MEMPOOL_ATTR_REUSE_ALLOW_INTERNAL_DEPENDENCIES = CU_MEMPOOL_ATTR_REUSE_ALLOW_OPPORTUNISTIC + 1
    CU_MEMPOOL_ATTR_RELEASE_THRESHOLD = CU_MEMPOOL_ATTR_REUSE_ALLOW_INTERNAL_DEPENDENCIES + 1
    CU_MEMPOOL_ATTR_RESERVED_MEM_CURRENT = CU_MEMPOOL_ATTR_RELEASE_THRESHOLD + 1
    CU_MEMPOOL_ATTR_RESERVED_MEM_HIGH = CU_MEMPOOL_ATTR_RESERVED_MEM_CURRENT + 1
    CU_MEMPOOL_ATTR_USED_MEM_CURRENT = CU_MEMPOOL_ATTR_RESERVED_MEM_HIGH + 1
    CU_MEMPOOL_ATTR_USED_MEM_HIGH = CU_MEMPOOL_ATTR_USED_MEM_CURRENT + 1
    CUmemPool_attribute_enum = enum :CUmemPool_attribute, [
      :reuse_follow_event_dependencies, 1,
      :reuse_allow_opportunistic,
      :reuse_allow_internal_dependencies,
      :release_threshold,
      :reserved_mem_current,
      :reserved_mem_high,
      :used_mem_current,
      :used_mem_high
    ]

    class CUmemPoolPropsSt < FFI::Struct
      layout(
        :allocType, :CUmemAllocationType,
        :handleTypes, :CUmemAllocationHandleType,
        :location, :CUmemLocation,
        :win32SecurityAttributes, :pointer,
        :reserved, [:uchar, 64]
      )
    end
    typedef CUmemPoolPropsSt.by_value, :CUmemPoolProps_v1
    typedef :CUmemPoolProps_v1, :CUmemPoolProps
    class CUmemPoolPtrExportDataSt < FFI::Struct
      layout(
        :reserved, [:uchar, 64]
      )
    end
    typedef CUmemPoolPtrExportDataSt.by_value, :CUmemPoolPtrExportData_v1
    typedef :CUmemPoolPtrExportData_v1, :CUmemPoolPtrExportData
    class CUDAMEMALLOCNODEPARAMSSt < FFI::Struct
      layout(
        :poolProps, :CUmemPoolProps,
        :accessDescs, :pointer,
        :accessDescCount, :size_t,
        :bytesize, :size_t,
        :dptr, :CUdeviceptr
      )
    end
    CU_GRAPH_MEM_ATTR_USED_MEM_CURRENT = 0
    CU_GRAPH_MEM_ATTR_USED_MEM_HIGH = CU_GRAPH_MEM_ATTR_USED_MEM_CURRENT + 1
    CU_GRAPH_MEM_ATTR_RESERVED_MEM_CURRENT = CU_GRAPH_MEM_ATTR_USED_MEM_HIGH + 1
    CU_GRAPH_MEM_ATTR_RESERVED_MEM_HIGH = CU_GRAPH_MEM_ATTR_RESERVED_MEM_CURRENT + 1
    CUgraphMem_attribute_enum = enum :CUgraphMem_attribute, %i[
      used_mem_current
      used_mem_high
      reserved_mem_current
      reserved_mem_high
    ]

    CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_PRE_LAUNCH_SYNC = 0x01
    CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_POST_LAUNCH_SYNC = 0x02
    CUDA_ARRAY3D_LAYERED = 0x01
    CUDA_ARRAY3D_2DARRAY = 0x01
    CUDA_ARRAY3D_SURFACE_LDST = 0x02
    CUDA_ARRAY3D_CUBEMAP = 0x04
    CUDA_ARRAY3D_TEXTURE_GATHER = 0x08
    CUDA_ARRAY3D_DEPTH_TEXTURE = 0x10
    CUDA_ARRAY3D_COLOR_ATTACHMENT = 0x20
    CUDA_ARRAY3D_SPARSE = 0x40
    CU_TRSA_OVERRIDE_FORMAT = 0x01
    CU_TRSF_READ_AS_INTEGER = 0x01
    CU_TRSF_NORMALIZED_COORDINATES = 0x02
    CU_TRSF_SRGB = 0x10
    CU_TRSF_DISABLE_TRILINEAR_OPTIMIZATION = 0x20
    CU_PARAM_TR_DEFAULT = -1
    CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_HOST = 1 << 0
    CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_MEMOPS = 1 << 1
    CUflushGPUDirectRDMAWritesOptions_enum = enum :CUflushGPUDirectRDMAWritesOptions, [
      :host, 1 << 0,
      :memops, 1 << 1
    ]

    CU_GPU_DIRECT_RDMA_WRITES_ORDERING_NONE = 0
    CU_GPU_DIRECT_RDMA_WRITES_ORDERING_OWNER = 100
    CU_GPU_DIRECT_RDMA_WRITES_ORDERING_ALL_DEVICES = 200
    CUGPUDirectRDMAWritesOrdering_enum = enum :CUGPUDirectRDMAWritesOrdering, [
      :none, 0,
      :owner, 100,
      :all_devices, 200
    ]

    CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_OWNER = 100
    CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_ALL_DEVICES = 200
    CUflushGPUDirectRDMAWritesScope_enum = enum :CUflushGPUDirectRDMAWritesScope, [
      :owner, 100,
      :all_devices, 200
    ]

    CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TARGET_CURRENT_CTX = 0
    CUflushGPUDirectRDMAWritesTarget_enum = enum :CUflushGPUDirectRDMAWritesTarget, [
      :ctx, 0
    ]

    CU_GRAPH_DEBUG_DOT_FLAGS_VERBOSE = 1 << 0
    CU_GRAPH_DEBUG_DOT_FLAGS_RUNTIME_TYPES = 1 << 1
    CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_PARAMS = 1 << 2
    CU_GRAPH_DEBUG_DOT_FLAGS_MEMCPY_NODE_PARAMS = 1 << 3
    CU_GRAPH_DEBUG_DOT_FLAGS_MEMSET_NODE_PARAMS = 1 << 4
    CU_GRAPH_DEBUG_DOT_FLAGS_HOST_NODE_PARAMS = 1 << 5
    CU_GRAPH_DEBUG_DOT_FLAGS_EVENT_NODE_PARAMS = 1 << 6
    CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_SIGNAL_NODE_PARAMS = 1 << 7
    CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_WAIT_NODE_PARAMS = 1 << 8
    CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_ATTRIBUTES = 1 << 9
    CU_GRAPH_DEBUG_DOT_FLAGS_HANDLES = 1 << 10
    CU_GRAPH_DEBUG_DOT_FLAGS_MEM_ALLOC_NODE_PARAMS = 1 << 11
    CU_GRAPH_DEBUG_DOT_FLAGS_MEM_FREE_NODE_PARAMS = 1 << 12
    CUgraphDebugDot_flags_enum = enum :CUgraphDebugDot_flags, [
      :verbose, 1 << 0,
      :runtime_types, 1 << 1,
      :kernel_node_params, 1 << 2,
      :memcpy_node_params, 1 << 3,
      :memset_node_params, 1 << 4,
      :host_node_params, 1 << 5,
      :event_node_params, 1 << 6,
      :ext_semas_signal_node_params, 1 << 7,
      :ext_semas_wait_node_params, 1 << 8,
      :kernel_node_attributes, 1 << 9,
      :handles, 1 << 10,
      :mem_alloc_node_params, 1 << 11,
      :mem_free_node_params, 1 << 12
    ]

    CU_USER_OBJECT_NO_DESTRUCTOR_SYNC = 1
    CUuserObject_flags_enum = enum :CUuserObject_flags, [
      :sync, 1
    ]

    CU_GRAPH_USER_OBJECT_MOVE = 1
    CUuserObjectRetain_flags_enum = enum :CUuserObjectRetain_flags, [
      :move, 1
    ]

    CUDA_GRAPH_INSTANTIATE_FLAG_AUTO_FREE_ON_LAUNCH = 1
    CUgraphInstantiate_flags_enum = enum :CUgraphInstantiate_flags, [
      :launch, 1
    ]

    attach_function :cuGetErrorString, :cuGetErrorString, %i[CUresult pointer], :CUresult
    attach_function :cuGetErrorName, :cuGetErrorName, %i[CUresult pointer], :CUresult
    attach_function :cuInit, :cuInit, [:uint], :CUresult
    attach_function :cuDriverGetVersion, :cuDriverGetVersion, [:pointer], :CUresult
    attach_function :cuDeviceGet, :cuDeviceGet, %i[pointer int], :CUresult
    attach_function :cuDeviceGetCount, :cuDeviceGetCount, [:pointer], :CUresult
<<<<<<< HEAD
    attach_function :cuDeviceGetName, :cuDeviceGetName, %i[string int CUdevice], :CUresult
    attach_function :cuDeviceGetUuid, :cuDeviceGetUuid, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetUuid_v2, :cuDeviceGetUuid_v2, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetLuid, :cuDeviceGetLuid, %i[string pointer CUdevice], :CUresult
=======
    attach_function :cuDeviceGetName, :cuDeviceGetName, %i[pointer int CUdevice], :CUresult
    attach_function :cuDeviceGetUuid, :cuDeviceGetUuid, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetUuid_v2, :cuDeviceGetUuid_v2, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetLuid, :cuDeviceGetLuid, %i[pointer pointer CUdevice], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuDeviceTotalMem_v2, :cuDeviceTotalMem_v2, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetTexture1DLinearMaxWidth, :cuDeviceGetTexture1DLinearMaxWidth, %i[pointer CUarray_format uint CUdevice], :CUresult
    attach_function :cuDeviceGetAttribute, :cuDeviceGetAttribute, %i[pointer CUdevice_attribute CUdevice], :CUresult
    attach_function :cuDeviceGetNvSciSyncAttributes, :cuDeviceGetNvSciSyncAttributes, %i[pointer CUdevice int], :CUresult
    attach_function :cuDeviceSetMemPool, :cuDeviceSetMemPool, %i[CUdevice CUmemoryPool], :CUresult
    attach_function :cuDeviceGetMemPool, :cuDeviceGetMemPool, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetDefaultMemPool, :cuDeviceGetDefaultMemPool, %i[pointer CUdevice], :CUresult
    attach_function :cuFlushGPUDirectRDMAWrites, :cuFlushGPUDirectRDMAWrites, %i[CUflushGPUDirectRDMAWritesTarget CUflushGPUDirectRDMAWritesScope], :CUresult
    attach_function :cuDeviceGetProperties, :cuDeviceGetProperties, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceComputeCapability, :cuDeviceComputeCapability, %i[pointer pointer CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxRetain, :cuDevicePrimaryCtxRetain, %i[pointer CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxRelease_v2, :cuDevicePrimaryCtxRelease_v2, [:CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxSetFlags_v2, :cuDevicePrimaryCtxSetFlags_v2, %i[CUdevice uint], :CUresult
    attach_function :cuDevicePrimaryCtxGetState, :cuDevicePrimaryCtxGetState, %i[CUdevice pointer pointer], :CUresult
    attach_function :cuDevicePrimaryCtxReset_v2, :cuDevicePrimaryCtxReset_v2, [:CUdevice], :CUresult
    attach_function :cuDeviceGetExecAffinitySupport, :cuDeviceGetExecAffinitySupport, %i[pointer CUexecAffinityType CUdevice], :CUresult
    attach_function :cuCtxCreate_v2, :cuCtxCreate_v2, %i[pointer uint CUdevice], :CUresult
    attach_function :cuCtxCreate_v3, :cuCtxCreate_v3, %i[pointer pointer int uint CUdevice], :CUresult
    attach_function :cuCtxDestroy_v2, :cuCtxDestroy_v2, [:CUcontext], :CUresult
    attach_function :cuCtxPushCurrent_v2, :cuCtxPushCurrent_v2, [:CUcontext], :CUresult
    attach_function :cuCtxPopCurrent_v2, :cuCtxPopCurrent_v2, [:pointer], :CUresult
    attach_function :cuCtxSetCurrent, :cuCtxSetCurrent, [:CUcontext], :CUresult
    attach_function :cuCtxGetCurrent, :cuCtxGetCurrent, [:pointer], :CUresult
    attach_function :cuCtxGetDevice, :cuCtxGetDevice, [:pointer], :CUresult
    attach_function :cuCtxGetFlags, :cuCtxGetFlags, [:pointer], :CUresult
    attach_function :cuCtxSynchronize, :cuCtxSynchronize, [], :CUresult
    attach_function :cuCtxSetLimit, :cuCtxSetLimit, %i[CUlimit size_t], :CUresult
    attach_function :cuCtxGetLimit, :cuCtxGetLimit, %i[pointer CUlimit], :CUresult
    attach_function :cuCtxGetCacheConfig, :cuCtxGetCacheConfig, [:pointer], :CUresult
    attach_function :cuCtxSetCacheConfig, :cuCtxSetCacheConfig, [:CUfunc_cache], :CUresult
    attach_function :cuCtxGetSharedMemConfig, :cuCtxGetSharedMemConfig, [:pointer], :CUresult
    attach_function :cuCtxSetSharedMemConfig, :cuCtxSetSharedMemConfig, [:CUsharedconfig], :CUresult
    attach_function :cuCtxGetApiVersion, :cuCtxGetApiVersion, %i[CUcontext pointer], :CUresult
    attach_function :cuCtxGetStreamPriorityRange, :cuCtxGetStreamPriorityRange, %i[pointer pointer], :CUresult
    attach_function :cuCtxResetPersistingL2Cache, :cuCtxResetPersistingL2Cache, [], :CUresult
    attach_function :cuCtxGetExecAffinity, :cuCtxGetExecAffinity, %i[pointer CUexecAffinityType], :CUresult
    attach_function :cuCtxAttach, :cuCtxAttach, %i[pointer uint], :CUresult
    attach_function :cuCtxDetach, :cuCtxDetach, [:CUcontext], :CUresult
<<<<<<< HEAD
    attach_function :cuModuleLoad, :cuModuleLoad, %i[pointer string], :CUresult
=======
    attach_function :cuModuleLoad, :cuModuleLoad, %i[pointer pointer], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuModuleLoadData, :cuModuleLoadData, %i[pointer pointer], :CUresult
    attach_function :cuModuleLoadDataEx, :cuModuleLoadDataEx, %i[pointer pointer uint pointer pointer], :CUresult
    attach_function :cuModuleLoadFatBinary, :cuModuleLoadFatBinary, %i[pointer pointer], :CUresult
    attach_function :cuModuleUnload, :cuModuleUnload, [:CUmodule], :CUresult
<<<<<<< HEAD
    attach_function :cuModuleGetFunction, :cuModuleGetFunction, %i[pointer CUmodule string], :CUresult
    attach_function :cuModuleGetGlobal_v2, :cuModuleGetGlobal_v2, %i[pointer pointer CUmodule string], :CUresult
    attach_function :cuModuleGetTexRef, :cuModuleGetTexRef, %i[pointer CUmodule string], :CUresult
    attach_function :cuModuleGetSurfRef, :cuModuleGetSurfRef, %i[pointer CUmodule string], :CUresult
    attach_function :cuLinkCreate_v2, :cuLinkCreate_v2, %i[uint pointer pointer pointer], :CUresult
    attach_function :cuLinkAddData_v2, :cuLinkAddData_v2, %i[CUlinkState CUjitInputType pointer size_t string uint pointer pointer], :CUresult
    attach_function :cuLinkAddFile_v2, :cuLinkAddFile_v2, %i[CUlinkState CUjitInputType string uint pointer pointer], :CUresult
=======
    attach_function :cuModuleGetFunction, :cuModuleGetFunction, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetGlobal_v2, :cuModuleGetGlobal_v2, %i[pointer pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetTexRef, :cuModuleGetTexRef, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetSurfRef, :cuModuleGetSurfRef, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuLinkCreate_v2, :cuLinkCreate_v2, %i[uint pointer pointer pointer], :CUresult
    attach_function :cuLinkAddData_v2, :cuLinkAddData_v2, %i[CUlinkState CUjitInputType pointer size_t pointer uint pointer pointer], :CUresult
    attach_function :cuLinkAddFile_v2, :cuLinkAddFile_v2, %i[CUlinkState CUjitInputType pointer uint pointer pointer], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuLinkComplete, :cuLinkComplete, %i[CUlinkState pointer pointer], :CUresult
    attach_function :cuLinkDestroy, :cuLinkDestroy, [:CUlinkState], :CUresult
    attach_function :cuMemGetInfo_v2, :cuMemGetInfo_v2, %i[pointer pointer], :CUresult
    attach_function :cuMemAlloc_v2, :cuMemAlloc_v2, %i[pointer size_t], :CUresult
    attach_function :cuMemAllocPitch_v2, :cuMemAllocPitch_v2, %i[pointer pointer size_t size_t uint], :CUresult
    attach_function :cuMemFree_v2, :cuMemFree_v2, [:CUdeviceptr], :CUresult
    attach_function :cuMemGetAddressRange_v2, :cuMemGetAddressRange_v2, %i[pointer pointer CUdeviceptr], :CUresult
    attach_function :cuMemAllocHost_v2, :cuMemAllocHost_v2, %i[pointer size_t], :CUresult
    attach_function :cuMemFreeHost, :cuMemFreeHost, [:pointer], :CUresult
    attach_function :cuMemHostAlloc, :cuMemHostAlloc, %i[pointer size_t uint], :CUresult
    attach_function :cuMemHostGetDevicePointer_v2, :cuMemHostGetDevicePointer_v2, %i[pointer pointer uint], :CUresult
    attach_function :cuMemHostGetFlags, :cuMemHostGetFlags, %i[pointer pointer], :CUresult
    attach_function :cuMemAllocManaged, :cuMemAllocManaged, %i[pointer size_t uint], :CUresult
<<<<<<< HEAD
    attach_function :cuDeviceGetByPCIBusId, :cuDeviceGetByPCIBusId, %i[pointer string], :CUresult
    attach_function :cuDeviceGetPCIBusId, :cuDeviceGetPCIBusId, %i[string int CUdevice], :CUresult
=======
    attach_function :cuDeviceGetByPCIBusId, :cuDeviceGetByPCIBusId, %i[pointer pointer], :CUresult
    attach_function :cuDeviceGetPCIBusId, :cuDeviceGetPCIBusId, %i[pointer int CUdevice], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuIpcGetEventHandle, :cuIpcGetEventHandle, %i[pointer CUevent], :CUresult
    attach_function :cuIpcOpenEventHandle, :cuIpcOpenEventHandle, %i[pointer CUipcEventHandle], :CUresult
    attach_function :cuIpcGetMemHandle, :cuIpcGetMemHandle, %i[pointer CUdeviceptr], :CUresult
    attach_function :cuIpcOpenMemHandle_v2, :cuIpcOpenMemHandle_v2, %i[pointer CUipcMemHandle uint], :CUresult
    attach_function :cuIpcCloseMemHandle, :cuIpcCloseMemHandle, [:CUdeviceptr], :CUresult
    attach_function :cuMemHostRegister_v2, :cuMemHostRegister_v2, %i[pointer size_t uint], :CUresult
    attach_function :cuMemHostUnregister, :cuMemHostUnregister, [:pointer], :CUresult
    attach_function :cuMemcpy, :cuMemcpy, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyPeer, :cuMemcpyPeer, %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t], :CUresult
    attach_function :cuMemcpyHtoD_v2, :cuMemcpyHtoD_v2, %i[CUdeviceptr pointer size_t], :CUresult
    attach_function :cuMemcpyDtoH_v2, :cuMemcpyDtoH_v2, %i[pointer CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoD_v2, :cuMemcpyDtoD_v2, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoA_v2, :cuMemcpyDtoA_v2, %i[CUarray size_t CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyAtoD_v2, :cuMemcpyAtoD_v2, %i[CUdeviceptr CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyHtoA_v2, :cuMemcpyHtoA_v2, %i[CUarray size_t pointer size_t], :CUresult
    attach_function :cuMemcpyAtoH_v2, :cuMemcpyAtoH_v2, %i[pointer CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyAtoA_v2, :cuMemcpyAtoA_v2, %i[CUarray size_t CUarray size_t size_t], :CUresult
    attach_function :cuMemcpy2D_v2, :cuMemcpy2D_v2, [:pointer], :CUresult
    attach_function :cuMemcpy2DUnaligned_v2, :cuMemcpy2DUnaligned_v2, [:pointer], :CUresult
    attach_function :cuMemcpy3D_v2, :cuMemcpy3D_v2, [:pointer], :CUresult
    attach_function :cuMemcpy3DPeer, :cuMemcpy3DPeer, [:pointer], :CUresult
    attach_function :cuMemcpyAsync, :cuMemcpyAsync, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyPeerAsync, :cuMemcpyPeerAsync, %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoDAsync_v2, :cuMemcpyHtoDAsync_v2, %i[CUdeviceptr pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoHAsync_v2, :cuMemcpyDtoHAsync_v2, %i[pointer CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoDAsync_v2, :cuMemcpyDtoDAsync_v2, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoAAsync_v2, :cuMemcpyHtoAAsync_v2, %i[CUarray size_t pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyAtoHAsync_v2, :cuMemcpyAtoHAsync_v2, %i[pointer CUarray size_t size_t CUstream], :CUresult
    attach_function :cuMemcpy2DAsync_v2, :cuMemcpy2DAsync_v2, %i[pointer CUstream], :CUresult
    attach_function :cuMemcpy3DAsync_v2, :cuMemcpy3DAsync_v2, %i[pointer CUstream], :CUresult
    attach_function :cuMemcpy3DPeerAsync, :cuMemcpy3DPeerAsync, %i[pointer CUstream], :CUresult
    attach_function :cuMemsetD8_v2, :cuMemsetD8_v2, %i[CUdeviceptr uchar size_t], :CUresult
    attach_function :cuMemsetD16_v2, :cuMemsetD16_v2, %i[CUdeviceptr ushort size_t], :CUresult
    attach_function :cuMemsetD32_v2, :cuMemsetD32_v2, %i[CUdeviceptr uint size_t], :CUresult
    attach_function :cuMemsetD2D8_v2, :cuMemsetD2D8_v2, %i[CUdeviceptr size_t uchar size_t size_t], :CUresult
    attach_function :cuMemsetD2D16_v2, :cuMemsetD2D16_v2, %i[CUdeviceptr size_t ushort size_t size_t], :CUresult
    attach_function :cuMemsetD2D32_v2, :cuMemsetD2D32_v2, %i[CUdeviceptr size_t uint size_t size_t], :CUresult
    attach_function :cuMemsetD8Async, :cuMemsetD8Async, %i[CUdeviceptr uchar size_t CUstream], :CUresult
    attach_function :cuMemsetD16Async, :cuMemsetD16Async, %i[CUdeviceptr ushort size_t CUstream], :CUresult
    attach_function :cuMemsetD32Async, :cuMemsetD32Async, %i[CUdeviceptr uint size_t CUstream], :CUresult
    attach_function :cuMemsetD2D8Async, :cuMemsetD2D8Async, %i[CUdeviceptr size_t uchar size_t size_t CUstream], :CUresult
    attach_function :cuMemsetD2D16Async, :cuMemsetD2D16Async, %i[CUdeviceptr size_t ushort size_t size_t CUstream], :CUresult
    attach_function :cuMemsetD2D32Async, :cuMemsetD2D32Async, %i[CUdeviceptr size_t uint size_t size_t CUstream], :CUresult
    attach_function :cuArrayCreate_v2, :cuArrayCreate_v2, %i[pointer pointer], :CUresult
    attach_function :cuArrayGetDescriptor_v2, :cuArrayGetDescriptor_v2, %i[pointer CUarray], :CUresult
    attach_function :cuArrayGetSparseProperties, :cuArrayGetSparseProperties, %i[pointer CUarray], :CUresult
    attach_function :cuMipmappedArrayGetSparseProperties, :cuMipmappedArrayGetSparseProperties, %i[pointer CUmipmappedArray], :CUresult
    attach_function :cuArrayGetPlane, :cuArrayGetPlane, %i[pointer CUarray uint], :CUresult
    attach_function :cuArrayDestroy, :cuArrayDestroy, [:CUarray], :CUresult
    attach_function :cuArray3DCreate_v2, :cuArray3DCreate_v2, %i[pointer pointer], :CUresult
    attach_function :cuArray3DGetDescriptor_v2, :cuArray3DGetDescriptor_v2, %i[pointer CUarray], :CUresult
    attach_function :cuMipmappedArrayCreate, :cuMipmappedArrayCreate, %i[pointer pointer uint], :CUresult
    attach_function :cuMipmappedArrayGetLevel, :cuMipmappedArrayGetLevel, %i[pointer CUmipmappedArray uint], :CUresult
    attach_function :cuMipmappedArrayDestroy, :cuMipmappedArrayDestroy, [:CUmipmappedArray], :CUresult
    attach_function :cuMemAddressReserve, :cuMemAddressReserve, %i[pointer size_t size_t CUdeviceptr ulong_long], :CUresult
    attach_function :cuMemAddressFree, :cuMemAddressFree, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemCreate, :cuMemCreate, %i[pointer size_t pointer ulong_long], :CUresult
    attach_function :cuMemRelease, :cuMemRelease, [:CUmemGenericAllocationHandle], :CUresult
    attach_function :cuMemMap, :cuMemMap, %i[CUdeviceptr size_t size_t CUmemGenericAllocationHandle ulong_long], :CUresult
    attach_function :cuMemMapArrayAsync, :cuMemMapArrayAsync, %i[pointer uint CUstream], :CUresult
    attach_function :cuMemUnmap, :cuMemUnmap, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemSetAccess, :cuMemSetAccess, %i[CUdeviceptr size_t pointer size_t], :CUresult
    attach_function :cuMemGetAccess, :cuMemGetAccess, %i[pointer pointer CUdeviceptr], :CUresult
    attach_function :cuMemExportToShareableHandle, :cuMemExportToShareableHandle, %i[pointer CUmemGenericAllocationHandle CUmemAllocationHandleType ulong_long], :CUresult
    attach_function :cuMemImportFromShareableHandle, :cuMemImportFromShareableHandle, %i[pointer pointer CUmemAllocationHandleType], :CUresult
    attach_function :cuMemGetAllocationGranularity, :cuMemGetAllocationGranularity, %i[pointer pointer CUmemAllocationGranularity_flags], :CUresult
    attach_function :cuMemGetAllocationPropertiesFromHandle, :cuMemGetAllocationPropertiesFromHandle, %i[pointer CUmemGenericAllocationHandle], :CUresult
    attach_function :cuMemRetainAllocationHandle, :cuMemRetainAllocationHandle, %i[pointer pointer], :CUresult
    attach_function :cuMemFreeAsync, :cuMemFreeAsync, %i[CUdeviceptr CUstream], :CUresult
    attach_function :cuMemAllocAsync, :cuMemAllocAsync, %i[pointer size_t CUstream], :CUresult
    attach_function :cuMemPoolTrimTo, :cuMemPoolTrimTo, %i[CUmemoryPool size_t], :CUresult
    attach_function :cuMemPoolSetAttribute, :cuMemPoolSetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolGetAttribute, :cuMemPoolGetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolSetAccess, :cuMemPoolSetAccess, %i[CUmemoryPool pointer size_t], :CUresult
    attach_function :cuMemPoolGetAccess, :cuMemPoolGetAccess, %i[pointer CUmemoryPool pointer], :CUresult
    attach_function :cuMemPoolCreate, :cuMemPoolCreate, %i[pointer pointer], :CUresult
    attach_function :cuMemPoolDestroy, :cuMemPoolDestroy, [:CUmemoryPool], :CUresult
    attach_function :cuMemAllocFromPoolAsync, :cuMemAllocFromPoolAsync, %i[pointer size_t CUmemoryPool CUstream], :CUresult
    attach_function :cuMemPoolExportToShareableHandle, :cuMemPoolExportToShareableHandle, %i[pointer CUmemoryPool CUmemAllocationHandleType ulong_long], :CUresult
    attach_function :cuMemPoolImportFromShareableHandle, :cuMemPoolImportFromShareableHandle, %i[pointer pointer CUmemAllocationHandleType ulong_long], :CUresult
    attach_function :cuMemPoolExportPointer, :cuMemPoolExportPointer, %i[pointer CUdeviceptr], :CUresult
    attach_function :cuMemPoolImportPointer, :cuMemPoolImportPointer, %i[pointer CUmemoryPool pointer], :CUresult
    attach_function :cuPointerGetAttribute, :cuPointerGetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuMemPrefetchAsync, :cuMemPrefetchAsync, %i[CUdeviceptr size_t CUdevice CUstream], :CUresult
    attach_function :cuMemAdvise, :cuMemAdvise, %i[CUdeviceptr size_t CUmem_advise CUdevice], :CUresult
    attach_function :cuMemRangeGetAttribute, :cuMemRangeGetAttribute, %i[pointer size_t CUmem_range_attribute CUdeviceptr size_t], :CUresult
    attach_function :cuMemRangeGetAttributes, :cuMemRangeGetAttributes, %i[pointer pointer pointer size_t CUdeviceptr size_t], :CUresult
    attach_function :cuPointerSetAttribute, :cuPointerSetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuPointerGetAttributes, :cuPointerGetAttributes, %i[uint pointer pointer CUdeviceptr], :CUresult
    attach_function :cuStreamCreate, :cuStreamCreate, %i[pointer uint], :CUresult
    attach_function :cuStreamCreateWithPriority, :cuStreamCreateWithPriority, %i[pointer uint int], :CUresult
    attach_function :cuStreamGetPriority, :cuStreamGetPriority, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetFlags, :cuStreamGetFlags, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetCtx, :cuStreamGetCtx, %i[CUstream pointer], :CUresult
    attach_function :cuStreamWaitEvent, :cuStreamWaitEvent, %i[CUstream CUevent uint], :CUresult
    attach_function :cuStreamAddCallback, :cuStreamAddCallback, [:CUstream, Callback_CUstreamCallback, :pointer, :uint], :CUresult
    attach_function :cuStreamBeginCapture_v2, :cuStreamBeginCapture_v2, %i[CUstream CUstreamCaptureMode], :CUresult
    attach_function :cuThreadExchangeStreamCaptureMode, :cuThreadExchangeStreamCaptureMode, [:pointer], :CUresult
    attach_function :cuStreamEndCapture, :cuStreamEndCapture, %i[CUstream pointer], :CUresult
    attach_function :cuStreamIsCapturing, :cuStreamIsCapturing, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetCaptureInfo, :cuStreamGetCaptureInfo, %i[CUstream pointer pointer], :CUresult
    attach_function :cuStreamGetCaptureInfo_v2, :cuStreamGetCaptureInfo_v2, %i[CUstream pointer pointer pointer pointer pointer], :CUresult
    attach_function :cuStreamUpdateCaptureDependencies, :cuStreamUpdateCaptureDependencies, %i[CUstream pointer size_t uint], :CUresult
    attach_function :cuStreamAttachMemAsync, :cuStreamAttachMemAsync, %i[CUstream CUdeviceptr size_t uint], :CUresult
    attach_function :cuStreamQuery, :cuStreamQuery, [:CUstream], :CUresult
    attach_function :cuStreamSynchronize, :cuStreamSynchronize, [:CUstream], :CUresult
    attach_function :cuStreamDestroy_v2, :cuStreamDestroy_v2, [:CUstream], :CUresult
    attach_function :cuStreamCopyAttributes, :cuStreamCopyAttributes, %i[CUstream CUstream], :CUresult
    attach_function :cuStreamGetAttribute, :cuStreamGetAttribute, %i[CUstream CUstreamAttrID pointer], :CUresult
    attach_function :cuStreamSetAttribute, :cuStreamSetAttribute, %i[CUstream CUstreamAttrID pointer], :CUresult
    attach_function :cuEventCreate, :cuEventCreate, %i[pointer uint], :CUresult
    attach_function :cuEventRecord, :cuEventRecord, %i[CUevent CUstream], :CUresult
    attach_function :cuEventRecordWithFlags, :cuEventRecordWithFlags, %i[CUevent CUstream uint], :CUresult
    attach_function :cuEventQuery, :cuEventQuery, [:CUevent], :CUresult
    attach_function :cuEventSynchronize, :cuEventSynchronize, [:CUevent], :CUresult
    attach_function :cuEventDestroy_v2, :cuEventDestroy_v2, [:CUevent], :CUresult
    attach_function :cuEventElapsedTime, :cuEventElapsedTime, %i[pointer CUevent CUevent], :CUresult
    attach_function :cuImportExternalMemory, :cuImportExternalMemory, %i[pointer pointer], :CUresult
    attach_function :cuExternalMemoryGetMappedBuffer, :cuExternalMemoryGetMappedBuffer, %i[pointer CUexternalMemory pointer], :CUresult
    attach_function :cuExternalMemoryGetMappedMipmappedArray, :cuExternalMemoryGetMappedMipmappedArray, %i[pointer CUexternalMemory pointer], :CUresult
    attach_function :cuDestroyExternalMemory, :cuDestroyExternalMemory, [:CUexternalMemory], :CUresult
    attach_function :cuImportExternalSemaphore, :cuImportExternalSemaphore, %i[pointer pointer], :CUresult
    attach_function :cuSignalExternalSemaphoresAsync, :cuSignalExternalSemaphoresAsync, %i[pointer pointer uint CUstream], :CUresult
    attach_function :cuWaitExternalSemaphoresAsync, :cuWaitExternalSemaphoresAsync, %i[pointer pointer uint CUstream], :CUresult
    attach_function :cuDestroyExternalSemaphore, :cuDestroyExternalSemaphore, [:CUexternalSemaphore], :CUresult
    attach_function :cuStreamWaitValue32, :cuStreamWaitValue32, %i[CUstream CUdeviceptr cuuint32_t uint], :CUresult
    attach_function :cuStreamWaitValue64, :cuStreamWaitValue64, %i[CUstream CUdeviceptr cuuint64_t uint], :CUresult
    attach_function :cuStreamWriteValue32, :cuStreamWriteValue32, %i[CUstream CUdeviceptr cuuint32_t uint], :CUresult
    attach_function :cuStreamWriteValue64, :cuStreamWriteValue64, %i[CUstream CUdeviceptr cuuint64_t uint], :CUresult
    attach_function :cuStreamBatchMemOp, :cuStreamBatchMemOp, %i[CUstream uint pointer uint], :CUresult
    attach_function :cuFuncGetAttribute, :cuFuncGetAttribute, %i[pointer CUfunction_attribute CUfunction], :CUresult
    attach_function :cuFuncSetAttribute, :cuFuncSetAttribute, %i[CUfunction CUfunction_attribute int], :CUresult
    attach_function :cuFuncSetCacheConfig, :cuFuncSetCacheConfig, %i[CUfunction CUfunc_cache], :CUresult
    attach_function :cuFuncSetSharedMemConfig, :cuFuncSetSharedMemConfig, %i[CUfunction CUsharedconfig], :CUresult
    attach_function :cuFuncGetModule, :cuFuncGetModule, %i[pointer CUfunction], :CUresult
    attach_function :cuLaunchKernel, :cuLaunchKernel, %i[CUfunction uint uint uint uint uint uint uint CUstream pointer pointer], :CUresult
    attach_function :cuLaunchCooperativeKernel, :cuLaunchCooperativeKernel, %i[CUfunction uint uint uint uint uint uint uint CUstream pointer], :CUresult
    attach_function :cuLaunchCooperativeKernelMultiDevice, :cuLaunchCooperativeKernelMultiDevice, %i[pointer uint uint], :CUresult
    attach_function :cuLaunchHostFunc, :cuLaunchHostFunc, [:CUstream, Callback_CUhostFn, :pointer], :CUresult
    attach_function :cuFuncSetBlockShape, :cuFuncSetBlockShape, %i[CUfunction int int int], :CUresult
    attach_function :cuFuncSetSharedSize, :cuFuncSetSharedSize, %i[CUfunction uint], :CUresult
    attach_function :cuParamSetSize, :cuParamSetSize, %i[CUfunction uint], :CUresult
    attach_function :cuParamSeti, :cuParamSeti, %i[CUfunction int uint], :CUresult
    attach_function :cuParamSetf, :cuParamSetf, %i[CUfunction int float], :CUresult
    attach_function :cuParamSetv, :cuParamSetv, %i[CUfunction int pointer uint], :CUresult
    attach_function :cuLaunch, :cuLaunch, [:CUfunction], :CUresult
    attach_function :cuLaunchGrid, :cuLaunchGrid, %i[CUfunction int int], :CUresult
    attach_function :cuLaunchGridAsync, :cuLaunchGridAsync, %i[CUfunction int int CUstream], :CUresult
    attach_function :cuParamSetTexRef, :cuParamSetTexRef, %i[CUfunction int CUtexref], :CUresult
    attach_function :cuGraphCreate, :cuGraphCreate, %i[pointer uint], :CUresult
    attach_function :cuGraphAddKernelNode, :cuGraphAddKernelNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphKernelNodeGetParams, :cuGraphKernelNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphKernelNodeSetParams, :cuGraphKernelNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddMemcpyNode, :cuGraphAddMemcpyNode, %i[pointer CUgraph pointer size_t pointer CUcontext], :CUresult
    attach_function :cuGraphMemcpyNodeGetParams, :cuGraphMemcpyNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemcpyNodeSetParams, :cuGraphMemcpyNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddMemsetNode, :cuGraphAddMemsetNode, %i[pointer CUgraph pointer size_t pointer CUcontext], :CUresult
    attach_function :cuGraphMemsetNodeGetParams, :cuGraphMemsetNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemsetNodeSetParams, :cuGraphMemsetNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddHostNode, :cuGraphAddHostNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphHostNodeGetParams, :cuGraphHostNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphHostNodeSetParams, :cuGraphHostNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddChildGraphNode, :cuGraphAddChildGraphNode, %i[pointer CUgraph pointer size_t CUgraph], :CUresult
    attach_function :cuGraphChildGraphNodeGetGraph, :cuGraphChildGraphNodeGetGraph, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddEmptyNode, :cuGraphAddEmptyNode, %i[pointer CUgraph pointer size_t], :CUresult
    attach_function :cuGraphAddEventRecordNode, :cuGraphAddEventRecordNode, %i[pointer CUgraph pointer size_t CUevent], :CUresult
    attach_function :cuGraphEventRecordNodeGetEvent, :cuGraphEventRecordNodeGetEvent, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphEventRecordNodeSetEvent, :cuGraphEventRecordNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphAddEventWaitNode, :cuGraphAddEventWaitNode, %i[pointer CUgraph pointer size_t CUevent], :CUresult
    attach_function :cuGraphEventWaitNodeGetEvent, :cuGraphEventWaitNodeGetEvent, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphEventWaitNodeSetEvent, :cuGraphEventWaitNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphAddExternalSemaphoresSignalNode, :cuGraphAddExternalSemaphoresSignalNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeGetParams, :cuGraphExternalSemaphoresSignalNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeSetParams, :cuGraphExternalSemaphoresSignalNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddExternalSemaphoresWaitNode, :cuGraphAddExternalSemaphoresWaitNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeGetParams, :cuGraphExternalSemaphoresWaitNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeSetParams, :cuGraphExternalSemaphoresWaitNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddMemAllocNode, :cuGraphAddMemAllocNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphMemAllocNodeGetParams, :cuGraphMemAllocNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphAddMemFreeNode, :cuGraphAddMemFreeNode, %i[pointer CUgraph pointer size_t CUdeviceptr], :CUresult
    attach_function :cuGraphMemFreeNodeGetParams, :cuGraphMemFreeNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuDeviceGraphMemTrim, :cuDeviceGraphMemTrim, [:CUdevice], :CUresult
    attach_function :cuDeviceGetGraphMemAttribute, :cuDeviceGetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuDeviceSetGraphMemAttribute, :cuDeviceSetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuGraphClone, :cuGraphClone, %i[pointer CUgraph], :CUresult
    attach_function :cuGraphNodeFindInClone, :cuGraphNodeFindInClone, %i[pointer CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphNodeGetType, :cuGraphNodeGetType, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphGetNodes, :cuGraphGetNodes, %i[CUgraph pointer pointer], :CUresult
    attach_function :cuGraphGetRootNodes, :cuGraphGetRootNodes, %i[CUgraph pointer pointer], :CUresult
    attach_function :cuGraphGetEdges, :cuGraphGetEdges, %i[CUgraph pointer pointer pointer], :CUresult
    attach_function :cuGraphNodeGetDependencies, :cuGraphNodeGetDependencies, %i[CUgraphNode pointer pointer], :CUresult
    attach_function :cuGraphNodeGetDependentNodes, :cuGraphNodeGetDependentNodes, %i[CUgraphNode pointer pointer], :CUresult
    attach_function :cuGraphAddDependencies, :cuGraphAddDependencies, %i[CUgraph pointer pointer size_t], :CUresult
    attach_function :cuGraphRemoveDependencies, :cuGraphRemoveDependencies, %i[CUgraph pointer pointer size_t], :CUresult
    attach_function :cuGraphDestroyNode, :cuGraphDestroyNode, [:CUgraphNode], :CUresult
<<<<<<< HEAD
    attach_function :cuGraphInstantiate_v2, :cuGraphInstantiate_v2, %i[pointer CUgraph pointer string size_t], :CUresult
=======
    attach_function :cuGraphInstantiate_v2, :cuGraphInstantiate_v2, %i[pointer CUgraph pointer pointer size_t], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuGraphInstantiateWithFlags, :cuGraphInstantiateWithFlags, %i[pointer CUgraph ulong_long], :CUresult
    attach_function :cuGraphExecKernelNodeSetParams, :cuGraphExecKernelNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphExecMemcpyNodeSetParams, :cuGraphExecMemcpyNodeSetParams, %i[CUgraphExec CUgraphNode pointer CUcontext], :CUresult
    attach_function :cuGraphExecMemsetNodeSetParams, :cuGraphExecMemsetNodeSetParams, %i[CUgraphExec CUgraphNode pointer CUcontext], :CUresult
    attach_function :cuGraphExecHostNodeSetParams, :cuGraphExecHostNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphExecChildGraphNodeSetParams, :cuGraphExecChildGraphNodeSetParams, %i[CUgraphExec CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphExecEventRecordNodeSetEvent, :cuGraphExecEventRecordNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecEventWaitNodeSetEvent, :cuGraphExecEventWaitNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecExternalSemaphoresSignalNodeSetParams, :cuGraphExecExternalSemaphoresSignalNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphExecExternalSemaphoresWaitNodeSetParams, :cuGraphExecExternalSemaphoresWaitNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphUpload, :cuGraphUpload, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuGraphLaunch, :cuGraphLaunch, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuGraphExecDestroy, :cuGraphExecDestroy, [:CUgraphExec], :CUresult
    attach_function :cuGraphDestroy, :cuGraphDestroy, [:CUgraph], :CUresult
    attach_function :cuGraphExecUpdate, :cuGraphExecUpdate, %i[CUgraphExec CUgraph pointer pointer], :CUresult
    attach_function :cuGraphKernelNodeCopyAttributes, :cuGraphKernelNodeCopyAttributes, %i[CUgraphNode CUgraphNode], :CUresult
    attach_function :cuGraphKernelNodeGetAttribute, :cuGraphKernelNodeGetAttribute, %i[CUgraphNode CUkernelNodeAttrID pointer], :CUresult
    attach_function :cuGraphKernelNodeSetAttribute, :cuGraphKernelNodeSetAttribute, %i[CUgraphNode CUkernelNodeAttrID pointer], :CUresult
<<<<<<< HEAD
    attach_function :cuGraphDebugDotPrint, :cuGraphDebugDotPrint, %i[CUgraph string uint], :CUresult
=======
    attach_function :cuGraphDebugDotPrint, :cuGraphDebugDotPrint, %i[CUgraph pointer uint], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuUserObjectCreate, :cuUserObjectCreate, [:pointer, :pointer, Callback_CUhostFn, :uint, :uint], :CUresult
    attach_function :cuUserObjectRetain, :cuUserObjectRetain, %i[CUuserObject uint], :CUresult
    attach_function :cuUserObjectRelease, :cuUserObjectRelease, %i[CUuserObject uint], :CUresult
    attach_function :cuGraphRetainUserObject, :cuGraphRetainUserObject, %i[CUgraph CUuserObject uint uint], :CUresult
    attach_function :cuGraphReleaseUserObject, :cuGraphReleaseUserObject, %i[CUgraph CUuserObject uint], :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessor, :cuOccupancyMaxActiveBlocksPerMultiprocessor, %i[pointer CUfunction int size_t], :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags, :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags, %i[pointer CUfunction int size_t uint], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSize, :cuOccupancyMaxPotentialBlockSize, [:pointer, :pointer, :CUfunction, Callback_CUoccupancyB2DSize, :size_t, :int], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSizeWithFlags, :cuOccupancyMaxPotentialBlockSizeWithFlags, [:pointer, :pointer, :CUfunction, Callback_CUoccupancyB2DSize, :size_t, :int, :uint], :CUresult
    attach_function :cuOccupancyAvailableDynamicSMemPerBlock, :cuOccupancyAvailableDynamicSMemPerBlock, %i[pointer CUfunction int int], :CUresult
    attach_function :cuTexRefSetArray, :cuTexRefSetArray, %i[CUtexref CUarray uint], :CUresult
    attach_function :cuTexRefSetMipmappedArray, :cuTexRefSetMipmappedArray, %i[CUtexref CUmipmappedArray uint], :CUresult
    attach_function :cuTexRefSetAddress_v2, :cuTexRefSetAddress_v2, %i[pointer CUtexref CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetAddress2D_v3, :cuTexRefSetAddress2D_v3, %i[CUtexref pointer CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetFormat, :cuTexRefSetFormat, %i[CUtexref CUarray_format int], :CUresult
    attach_function :cuTexRefSetAddressMode, :cuTexRefSetAddressMode, %i[CUtexref int CUaddress_mode], :CUresult
    attach_function :cuTexRefSetFilterMode, :cuTexRefSetFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetMipmapFilterMode, :cuTexRefSetMipmapFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetMipmapLevelBias, :cuTexRefSetMipmapLevelBias, %i[CUtexref float], :CUresult
    attach_function :cuTexRefSetMipmapLevelClamp, :cuTexRefSetMipmapLevelClamp, %i[CUtexref float float], :CUresult
    attach_function :cuTexRefSetMaxAnisotropy, :cuTexRefSetMaxAnisotropy, %i[CUtexref uint], :CUresult
    attach_function :cuTexRefSetBorderColor, :cuTexRefSetBorderColor, %i[CUtexref pointer], :CUresult
    attach_function :cuTexRefSetFlags, :cuTexRefSetFlags, %i[CUtexref uint], :CUresult
    attach_function :cuTexRefGetAddress_v2, :cuTexRefGetAddress_v2, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetArray, :cuTexRefGetArray, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmappedArray, :cuTexRefGetMipmappedArray, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetAddressMode, :cuTexRefGetAddressMode, %i[pointer CUtexref int], :CUresult
    attach_function :cuTexRefGetFilterMode, :cuTexRefGetFilterMode, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetFormat, :cuTexRefGetFormat, %i[pointer pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapFilterMode, :cuTexRefGetMipmapFilterMode, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelBias, :cuTexRefGetMipmapLevelBias, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelClamp, :cuTexRefGetMipmapLevelClamp, %i[pointer pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMaxAnisotropy, :cuTexRefGetMaxAnisotropy, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetBorderColor, :cuTexRefGetBorderColor, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetFlags, :cuTexRefGetFlags, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefCreate, :cuTexRefCreate, [:pointer], :CUresult
    attach_function :cuTexRefDestroy, :cuTexRefDestroy, [:CUtexref], :CUresult
    attach_function :cuSurfRefSetArray, :cuSurfRefSetArray, %i[CUsurfref CUarray uint], :CUresult
    attach_function :cuSurfRefGetArray, :cuSurfRefGetArray, %i[pointer CUsurfref], :CUresult
    attach_function :cuTexObjectCreate, :cuTexObjectCreate, %i[pointer pointer pointer pointer], :CUresult
    attach_function :cuTexObjectDestroy, :cuTexObjectDestroy, [:CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceDesc, :cuTexObjectGetResourceDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuTexObjectGetTextureDesc, :cuTexObjectGetTextureDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceViewDesc, :cuTexObjectGetResourceViewDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuSurfObjectCreate, :cuSurfObjectCreate, %i[pointer pointer], :CUresult
    attach_function :cuSurfObjectDestroy, :cuSurfObjectDestroy, [:CUsurfObject], :CUresult
    attach_function :cuSurfObjectGetResourceDesc, :cuSurfObjectGetResourceDesc, %i[pointer CUsurfObject], :CUresult
    attach_function :cuDeviceCanAccessPeer, :cuDeviceCanAccessPeer, %i[pointer CUdevice CUdevice], :CUresult
    attach_function :cuCtxEnablePeerAccess, :cuCtxEnablePeerAccess, %i[CUcontext uint], :CUresult
    attach_function :cuCtxDisablePeerAccess, :cuCtxDisablePeerAccess, [:CUcontext], :CUresult
    attach_function :cuDeviceGetP2PAttribute, :cuDeviceGetP2PAttribute, %i[pointer CUdevice_P2PAttribute CUdevice CUdevice], :CUresult
    attach_function :cuGraphicsUnregisterResource, :cuGraphicsUnregisterResource, [:CUgraphicsResource], :CUresult
    attach_function :cuGraphicsSubResourceGetMappedArray, :cuGraphicsSubResourceGetMappedArray, %i[pointer CUgraphicsResource uint uint], :CUresult
    attach_function :cuGraphicsResourceGetMappedMipmappedArray, :cuGraphicsResourceGetMappedMipmappedArray, %i[pointer CUgraphicsResource], :CUresult
    attach_function :cuGraphicsResourceGetMappedPointer_v2, :cuGraphicsResourceGetMappedPointer_v2, %i[pointer pointer CUgraphicsResource], :CUresult
    attach_function :cuGraphicsResourceSetMapFlags_v2, :cuGraphicsResourceSetMapFlags_v2, %i[CUgraphicsResource uint], :CUresult
    attach_function :cuGraphicsMapResources, :cuGraphicsMapResources, %i[uint pointer CUstream], :CUresult
    attach_function :cuGraphicsUnmapResources, :cuGraphicsUnmapResources, %i[uint pointer CUstream], :CUresult
<<<<<<< HEAD
    attach_function :cuGetProcAddress, :cuGetProcAddress, %i[string pointer int cuuint64_t], :CUresult
=======
    attach_function :cuGetProcAddress, :cuGetProcAddress, %i[pointer pointer int cuuint64_t], :CUresult
>>>>>>> ab399306e6cc00de7ba3e6c210b5a08988f6b623
    attach_function :cuGetExportTable, :cuGetExportTable, %i[pointer pointer], :CUresult
  end
end

# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Naming/VariableNumber
