# frozen_string_literal: true

# rubocop:disable Naming/VariableNumber
# rubocop:disable Metrics/ModuleLength

module Cuda
  module DriverApi
    extend FFI::Library
    ffi_lib "/usr/lib/x86_64-linux-gnu/libcuda.so"

    # Enums
    # TODO

    # Typedefs
    typedef :ushort, :unsigned_short
    typedef :uchar, :unsigned_char
    typedef :uint, :unsigned_int
    typedef :ulong_long, :unsigned_long_long
    typedef :uint64, :cuuint64_t
    typedef :pointer, :CUhostFn

    typedef :pointer, :CUuserObject
    typedef :pointer, :CUtexref
    typedef :unsigned_long_long, :CUtexObject_v1
    typedef :CUtexObject_v1, :CUtexObject
    typedef :pointer, :CUsurfref
    typedef :unsigned_long_long, :CUsurfObject_v1
    typedef :CUsurfObject_v1, :CUsurfObject
    typedef :pointer, :CUstream
    typedef :pointer, :CUmodule
    typedef :pointer, :CUmipmappedArray
    typedef :pointer, :CUmemoryPool
    typedef :pointer, :CUgraphicsResource
    typedef :pointer, :CUgraphNode
    typedef :pointer, :CUgraphExec
    typedef :pointer, :CUgraph
    typedef :pointer, :CUfunction
    typedef :pointer, :CUexternalSemaphore
    typedef :pointer, :CUexternalMemory
    typedef :pointer, :CUevent
    typedef :pointer, :CUeglStreamConnection
    typedef :unsigned_int, :CUdeviceptr_v2
    typedef :CUdeviceptr_v2, :CUdeviceptr
    typedef :int, :CUdevice_v1
    typedef :CUdevice_v1, :CUdevice
    typedef :pointer, :CUcontext
    typedef :pointer, :CUarray

    # Enums
    enum :CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS, [:CU_POINTER_ATTRIBUTE_ACCESS_FLAG_NONE, 0x0,
                                                :CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READ, 0x1,
                                                :CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READWRITE, 0x3]

    enum :CUGPUDirectRDMAWritesOrdering, [:CU_GPU_DIRECT_RDMA_WRITES_ORDERING_NONE, 0,
                                          :CU_GPU_DIRECT_RDMA_WRITES_ORDERING_OWNER, 100,
                                          :CU_GPU_DIRECT_RDMA_WRITES_ORDERING_ALL_DEVICES, 200]

    enum :CUaccessProperty, [:CU_ACCESS_PROPERTY_NORMAL, 0,
                             :CU_ACCESS_PROPERTY_STREAMING, 1,
                             :CU_ACCESS_PROPERTY_PERSISTING, 2]

    enum :CUaddress_mode, [:CU_TR_ADDRESS_MODE_WRAP, 0,
                           :CU_TR_ADDRESS_MODE_CLAMP, 1,
                           :CU_TR_ADDRESS_MODE_MIRROR,  2,
                           :CU_TR_ADDRESS_MODE_BORDER,  3]

    enum :CUarraySparseSubresourceType, [:CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_SPARSE_LEVEL, 0,
                                         :CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_MIPTAIL, 1]

    enum :CUarray_cubemap_face, [:CU_CUBEMAP_FACE_POSITIVE_X, 0x00,
                                 :CU_CUBEMAP_FACE_NEGATIVE_X,  0x01,
                                 :CU_CUBEMAP_FACE_POSITIVE_Y,  0x02,
                                 :CU_CUBEMAP_FACE_NEGATIVE_Y,  0x03,
                                 :CU_CUBEMAP_FACE_POSITIVE_Z,  0x04,
                                 :CU_CUBEMAP_FACE_NEGATIVE_Z,  0x05]

    enum :CUarray_format, [:CU_AD_FORMAT_UNSIGNED_INT8, 0x01,
                           :CU_AD_FORMAT_UNSIGNED_INT16,  0x02,
                           :CU_AD_FORMAT_UNSIGNED_INT32,  0x03,
                           :CU_AD_FORMAT_SIGNED_INT8, 0x08,
                           :CU_AD_FORMAT_SIGNED_INT16,  0x09,
                           :CU_AD_FORMAT_SIGNED_INT32,  0x0a,
                           :CU_AD_FORMAT_HALF, 0x10,
                           :CU_AD_FORMAT_FLOAT, 0x20,
                           :CU_AD_FORMAT_NV12, 0xb0]

    enum :CUcomputemode, [:CU_COMPUTEMODE_DEFAULT, 0,
                          :CU_COMPUTEMODE_PROHIBITED, 2,
                          :CU_COMPUTEMODE_EXCLUSIVE_PROCESS, 3]

    enum :CUctx_flags, [:CU_CTX_SCHED_AUTO, 0x00,
                        :CU_CTX_SCHED_SPIN, 0x01,
                        :CU_CTX_SCHED_YIELD, 0x02,
                        :CU_CTX_SCHED_BLOCKING_SYNC, 0x04,
                        :CU_CTX_BLOCKING_SYNC, 0x04,
                        :CU_CTX_SCHED_MASK, 0x07,
                        :CU_CTX_MAP_HOST, 0x08,
                        :CU_CTX_LMEM_RESIZE_TO_MAX, 0x10,
                        :CU_CTX_FLAGS_MASK, 0x1f]

    enum :CUdevice_P2PAttribute, [:CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK, 0x01,
                                  :CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED, 0x02,
                                  :CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED,  0x03,
                                  :CU_DEVICE_P2P_ATTRIBUTE_ACCESS_ACCESS_SUPPORTED,  0x04,
                                  :CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED, 0x04]

    enum :CUdevice_attribute, [:CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK, 1,
                               :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X,  2,
                               :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y,  3,
                               :CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z,  4,
                               :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X,  5,
                               :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y,  6,
                               :CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z,  7,
                               :CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK, 8,
                               :CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK, 8,
                               :CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY, 9,
                               :CU_DEVICE_ATTRIBUTE_WARP_SIZE,  10,
                               :CU_DEVICE_ATTRIBUTE_MAX_PITCH,  11,
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
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH,  21,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH,  22,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT,  23,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH, 24,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT, 25,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH, 26,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH, 27,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT,  28,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS,  29,
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
                               :CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT,  40,
                               :CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING,  41,
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
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH,  55,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH,  56,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT, 57,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH, 58,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT, 59,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH, 60,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH, 61,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS, 62,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH, 63,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT,  64,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS,  65,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH, 66,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH, 67,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS, 68,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH,  69,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH,  70,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT, 71,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH,  72,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH, 73,
                               :CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT, 74,
                               :CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR,  75,
                               :CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR,  76,
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
                               :CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS,  93,
                               :CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR,  94,
                               :CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH, 95,
                               :CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH, 96,
                               :CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN, 97,
                               :CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES,  98,
                               :CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED,  99,
                               :CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES, 100,
                               :CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST, 101,
                               :CU_DEVICE_ATTRIBUTE_VIRTUAL_ADDRESS_MANAGEMENT_SUPPORTED, 102,
                               :CU_DEVICE_ATTRIBUTE_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED, 102,
                               :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR_SUPPORTED, 103,
                               :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_HANDLE_SUPPORTED, 104,
                               :CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_KMT_HANDLE_SUPPORTED, 105,
                               :CU_DEVICE_ATTRIBUTE_MAX_BLOCKS_PER_MULTIPROCESSOR,  106,
                               :CU_DEVICE_ATTRIBUTE_GENERIC_COMPRESSION_SUPPORTED,  107,
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
                               :CU_DEVICE_ATTRIBUTE_MAX]

    enum :CUdriverProcAddress_flags, [:CU_GET_PROC_ADDRESS_DEFAULT, 0,
                                      :CU_GET_PROC_ADDRESS_LEGACY_STREAM, 1 << 0,
                                      :CU_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM, 1 << 1]

    enum :CUeglColorFormat, [:CU_EGL_COLOR_FORMAT_YUV420_PLANAR, 0x00,
                             :CU_EGL_COLOR_FORMAT_YUV420_SEMIPLANAR, 0x01,
                             :CU_EGL_COLOR_FORMAT_YUV422_PLANAR, 0x02,
                             :CU_EGL_COLOR_FORMAT_YUV422_SEMIPLANAR, 0x03,
                             :CU_EGL_COLOR_FORMAT_RGB,  0x04,
                             :CU_EGL_COLOR_FORMAT_BGR,  0x05,
                             :CU_EGL_COLOR_FORMAT_ARGB,  0x06,
                             :CU_EGL_COLOR_FORMAT_RGBA,  0x07,
                             :CU_EGL_COLOR_FORMAT_L,  0x08,
                             :CU_EGL_COLOR_FORMAT_R,  0x09,
                             :CU_EGL_COLOR_FORMAT_YUV444_PLANAR, 0x0A,
                             :CU_EGL_COLOR_FORMAT_YUV444_SEMIPLANAR, 0x0B,
                             :CU_EGL_COLOR_FORMAT_YUYV_422,  0x0C,
                             :CU_EGL_COLOR_FORMAT_UYVY_422,  0x0D,
                             :CU_EGL_COLOR_FORMAT_ABGR,  0x0E,
                             :CU_EGL_COLOR_FORMAT_BGRA,  0x0F,
                             :CU_EGL_COLOR_FORMAT_A,  0x10,
                             :CU_EGL_COLOR_FORMAT_RG, 0x11,
                             :CU_EGL_COLOR_FORMAT_AYUV, 0x12,
                             :CU_EGL_COLOR_FORMAT_YVU444_SEMIPLANAR,  0x13,
                             :CU_EGL_COLOR_FORMAT_YVU422_SEMIPLANAR,  0x14,
                             :CU_EGL_COLOR_FORMAT_YVU420_SEMIPLANAR,  0x15,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_444_SEMIPLANAR,  0x16,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_420_SEMIPLANAR,  0x17,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_444_SEMIPLANAR,  0x18,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_420_SEMIPLANAR,  0x19,
                             :CU_EGL_COLOR_FORMAT_VYUY_ER,  0x1A,
                             :CU_EGL_COLOR_FORMAT_UYVY_ER,  0x1B,
                             :CU_EGL_COLOR_FORMAT_YUYV_ER,  0x1C,
                             :CU_EGL_COLOR_FORMAT_YVYU_ER,  0x1D,
                             :CU_EGL_COLOR_FORMAT_YUV_ER, 0x1E,
                             :CU_EGL_COLOR_FORMAT_YUVA_ER,  0x1F,
                             :CU_EGL_COLOR_FORMAT_AYUV_ER,  0x20,
                             :CU_EGL_COLOR_FORMAT_YUV444_PLANAR_ER,  0x21,
                             :CU_EGL_COLOR_FORMAT_YUV422_PLANAR_ER,  0x22,
                             :CU_EGL_COLOR_FORMAT_YUV420_PLANAR_ER,  0x23,
                             :CU_EGL_COLOR_FORMAT_YUV444_SEMIPLANAR_ER,  0x24,
                             :CU_EGL_COLOR_FORMAT_YUV422_SEMIPLANAR_ER,  0x25,
                             :CU_EGL_COLOR_FORMAT_YUV420_SEMIPLANAR_ER,  0x26,
                             :CU_EGL_COLOR_FORMAT_YVU444_PLANAR_ER,  0x27,
                             :CU_EGL_COLOR_FORMAT_YVU422_PLANAR_ER,  0x28,
                             :CU_EGL_COLOR_FORMAT_YVU420_PLANAR_ER,  0x29,
                             :CU_EGL_COLOR_FORMAT_YVU444_SEMIPLANAR_ER,  0x2A,
                             :CU_EGL_COLOR_FORMAT_YVU422_SEMIPLANAR_ER,  0x2B,
                             :CU_EGL_COLOR_FORMAT_YVU420_SEMIPLANAR_ER,  0x2C,
                             :CU_EGL_COLOR_FORMAT_BAYER_RGGB,  0x2D,
                             :CU_EGL_COLOR_FORMAT_BAYER_BGGR,  0x2E,
                             :CU_EGL_COLOR_FORMAT_BAYER_GRBG,  0x2F,
                             :CU_EGL_COLOR_FORMAT_BAYER_GBRG,  0x30,
                             :CU_EGL_COLOR_FORMAT_BAYER10_RGGB,  0x31,
                             :CU_EGL_COLOR_FORMAT_BAYER10_BGGR,  0x32,
                             :CU_EGL_COLOR_FORMAT_BAYER10_GRBG,  0x33,
                             :CU_EGL_COLOR_FORMAT_BAYER10_GBRG,  0x34,
                             :CU_EGL_COLOR_FORMAT_BAYER12_RGGB,  0x35,
                             :CU_EGL_COLOR_FORMAT_BAYER12_BGGR,  0x36,
                             :CU_EGL_COLOR_FORMAT_BAYER12_GRBG,  0x37,
                             :CU_EGL_COLOR_FORMAT_BAYER12_GBRG,  0x38,
                             :CU_EGL_COLOR_FORMAT_BAYER14_RGGB,  0x39,
                             :CU_EGL_COLOR_FORMAT_BAYER14_BGGR,  0x3A,
                             :CU_EGL_COLOR_FORMAT_BAYER14_GRBG,  0x3B,
                             :CU_EGL_COLOR_FORMAT_BAYER14_GBRG,  0x3C,
                             :CU_EGL_COLOR_FORMAT_BAYER20_RGGB,  0x3D,
                             :CU_EGL_COLOR_FORMAT_BAYER20_BGGR,  0x3E,
                             :CU_EGL_COLOR_FORMAT_BAYER20_GRBG,  0x3F,
                             :CU_EGL_COLOR_FORMAT_BAYER20_GBRG,  0x40,
                             :CU_EGL_COLOR_FORMAT_YVU444_PLANAR,  0x41,
                             :CU_EGL_COLOR_FORMAT_YVU422_PLANAR,  0x42,
                             :CU_EGL_COLOR_FORMAT_YVU420_PLANAR,  0x43,
                             :CU_EGL_COLOR_FORMAT_BAYER_ISP_RGGB,  0x44,
                             :CU_EGL_COLOR_FORMAT_BAYER_ISP_BGGR,  0x45,
                             :CU_EGL_COLOR_FORMAT_BAYER_ISP_GRBG,  0x46,
                             :CU_EGL_COLOR_FORMAT_BAYER_ISP_GBRG,  0x47,
                             :CU_EGL_COLOR_FORMAT_BAYER_BCCR,  0x48,
                             :CU_EGL_COLOR_FORMAT_BAYER_RCCB,  0x49,
                             :CU_EGL_COLOR_FORMAT_BAYER_CRBC,  0x4A,
                             :CU_EGL_COLOR_FORMAT_BAYER_CBRC,  0x4B,
                             :CU_EGL_COLOR_FORMAT_BAYER10_CCCC,  0x4C,
                             :CU_EGL_COLOR_FORMAT_BAYER12_BCCR,  0x4D,
                             :CU_EGL_COLOR_FORMAT_BAYER12_RCCB,  0x4E,
                             :CU_EGL_COLOR_FORMAT_BAYER12_CRBC,  0x4F,
                             :CU_EGL_COLOR_FORMAT_BAYER12_CBRC,  0x50,
                             :CU_EGL_COLOR_FORMAT_BAYER12_CCCC,  0x51,
                             :CU_EGL_COLOR_FORMAT_Y, 0x52,
                             :CU_EGL_COLOR_FORMAT_YUV420_SEMIPLANAR_2020,  0x53,
                             :CU_EGL_COLOR_FORMAT_YVU420_SEMIPLANAR_2020,  0x54,
                             :CU_EGL_COLOR_FORMAT_YUV420_PLANAR_2020,  0x55,
                             :CU_EGL_COLOR_FORMAT_YVU420_PLANAR_2020,  0x56,
                             :CU_EGL_COLOR_FORMAT_YUV420_SEMIPLANAR_709,  0x57,
                             :CU_EGL_COLOR_FORMAT_YVU420_SEMIPLANAR_709,  0x58,
                             :CU_EGL_COLOR_FORMAT_YUV420_PLANAR_709,  0x59,
                             :CU_EGL_COLOR_FORMAT_YVU420_PLANAR_709,  0x5A,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_420_SEMIPLANAR_709, 0x5B,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_420_SEMIPLANAR_2020,  0x5C,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_422_SEMIPLANAR_2020,  0x5D,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_422_SEMIPLANAR, 0x5E,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_422_SEMIPLANAR_709, 0x5F,
                             :CU_EGL_COLOR_FORMAT_Y_ER, 0x60,
                             :CU_EGL_COLOR_FORMAT_Y_709_ER, 0x61,
                             :CU_EGL_COLOR_FORMAT_Y10_ER, 0x62,
                             :CU_EGL_COLOR_FORMAT_Y10_709_ER, 0x63,
                             :CU_EGL_COLOR_FORMAT_Y12_ER, 0x64,
                             :CU_EGL_COLOR_FORMAT_Y12_709_ER, 0x65,
                             :CU_EGL_COLOR_FORMAT_YUVA, 0x66,
                             :CU_EGL_COLOR_FORMAT_YUV, 0x67,
                             :CU_EGL_COLOR_FORMAT_YVYU,  0x68,
                             :CU_EGL_COLOR_FORMAT_VYUY,  0x69,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_420_SEMIPLANAR_ER, 0x6A,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_420_SEMIPLANAR_709_ER, 0x6B,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_444_SEMIPLANAR_ER, 0x6C,
                             :CU_EGL_COLOR_FORMAT_Y10V10U10_444_SEMIPLANAR_709_ER, 0x6D,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_420_SEMIPLANAR_ER, 0x6E,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_420_SEMIPLANAR_709_ER, 0x6F,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_444_SEMIPLANAR_ER, 0x70,
                             :CU_EGL_COLOR_FORMAT_Y12V12U12_444_SEMIPLANAR_709_ER, 0x71,
                             :CU_EGL_COLOR_FORMAT_MAX]

    enum :CUeglFrameType, [:CU_EGL_FRAME_TYPE_ARRAY, 0,
                           :CU_EGL_FRAME_TYPE_PITCH, 1]

    enum :CUeglResourceLocationFlags, [:CU_EGL_RESOURCE_LOCATION_SYSMEM, 0x00,
                                       :CU_EGL_RESOURCE_LOCATION_VIDMEM, 0x01]

    enum :CUevent_flags, [:CU_EVENT_DEFAULT, 0x0,
                          :CU_EVENT_BLOCKING_SYNC, 0x1,
                          :CU_EVENT_DISABLE_TIMING, 0x2,
                          :CU_EVENT_INTERPROCESS, 0x4]

    enum :CUevent_record_flags, [:CU_EVENT_RECORD_DEFAULT, 0x0,
                                 :CU_EVENT_RECORD_EXTERNAL, 0x1]

    enum :CUevent_wait_flags, [:CU_EVENT_WAIT_DEFAULT, 0x0,
                               :CU_EVENT_WAIT_EXTERNAL, 0x1]

    enum :CUexecAffinityType, [:CU_EXEC_AFFINITY_TYPE_SM_COUNT, 0,
                               :CU_EXEC_AFFINITY_TYPE_MAX]

    enum :CUexternalMemoryHandleType, [:CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD, 1,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32, 2,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT, 3,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP, 4,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE,  5,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE,  6,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE_KMT, 7,
                                       :CU_EXTERNAL_MEMORY_HANDLE_TYPE_NVSCIBUF, 8]

    enum :CUexternalSemaphoreHandleType, [:CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD, 1,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32, 2,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT, 3,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE,  4,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_FENCE,  5,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_NVSCISYNC, 6,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX, 7,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX_KMT,  8,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_FD,  9,
                                          :CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_WIN32, 10]

    enum :CUfilter_mode, [:CU_TR_FILTER_MODE_POINT, 0,
                          :CU_TR_FILTER_MODE_LINEAR, 1]

    enum :CUflushGPUDirectRDMAWritesOptions, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_HOST, 1 << 0,
                                              :CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_MEMOPS, 1 << 1]

    enum :CUflushGPUDirectRDMAWritesScope, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_OWNER, 100,
                                            :CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_ALL_DEVICES, 200]

    enum :CUflushGPUDirectRDMAWritesTarget, [:CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TARGET_CURRENT_CTX, 0]

    enum :CUfunc_cache, [:CU_FUNC_CACHE_PREFER_NONE, 0x00,
                         :CU_FUNC_CACHE_PREFER_SHARED, 0x01,
                         :CU_FUNC_CACHE_PREFER_L1, 0x02,
                         :CU_FUNC_CACHE_PREFER_EQUAL, 0x03]

    enum :CUfunction_attribute, [:CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, 0,
                                 :CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES, 1,
                                 :CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES,  2,
                                 :CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES,  3,
                                 :CU_FUNC_ATTRIBUTE_NUM_REGS, 4,
                                 :CU_FUNC_ATTRIBUTE_PTX_VERSION, 5,
                                 :CU_FUNC_ATTRIBUTE_BINARY_VERSION, 6,
                                 :CU_FUNC_ATTRIBUTE_CACHE_MODE_CA, 7,
                                 :CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES, 8,
                                 :CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT, 9,
                                 :CU_FUNC_ATTRIBUTE_MAX]

    enum :CUgraphDebugDot_flags, [:CU_GRAPH_DEBUG_DOT_FLAGS_VERBOSE, 1 << 0,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_RUNTIME_TYPES, 1 << 1,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_PARAMS,  1 << 2,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_MEMCPY_NODE_PARAMS,  1 << 3,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_MEMSET_NODE_PARAMS,  1 << 4,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_HOST_NODE_PARAMS, 1 << 5,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_EVENT_NODE_PARAMS, 1 << 6,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_SIGNAL_NODE_PARAMS, 1 << 7,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_WAIT_NODE_PARAMS, 1 << 8,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_ATTRIBUTES, 1 << 9,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_HANDLES, 1 << 10,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_MEM_ALLOC_NODE_PARAMS, 1 << 11,
                                  :CU_GRAPH_DEBUG_DOT_FLAGS_MEM_FREE_NODE_PARAMS, 1 << 12]

    enum :CUgraphInstantiate_flags, [:CUDA_GRAPH_INSTANTIATE_FLAG_AUTO_FREE_ON_LAUNCH, 1]

    enum :CUgraphNodeType, [:CU_GRAPH_NODE_TYPE_KERNEL, 0,
                            :CU_GRAPH_NODE_TYPE_MEMCPY,  1,
                            :CU_GRAPH_NODE_TYPE_MEMSET,  2,
                            :CU_GRAPH_NODE_TYPE_HOST, 3,
                            :CU_GRAPH_NODE_TYPE_GRAPH,  4,
                            :CU_GRAPH_NODE_TYPE_EMPTY,  5,
                            :CU_GRAPH_NODE_TYPE_WAIT_EVENT, 6,
                            :CU_GRAPH_NODE_TYPE_EVENT_RECORD, 7,
                            :CU_GRAPH_NODE_TYPE_EXT_SEMAS_SIGNAL, 8,
                            :CU_GRAPH_NODE_TYPE_EXT_SEMAS_WAIT, 9,
                            :CU_GRAPH_NODE_TYPE_MEM_ALLOC, 10,
                            :CU_GRAPH_NODE_TYPE_MEM_FREE, 11]

    enum :CUgraphicsMapResourceFlags, [:CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE, 0x00,
                                       :CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY, 0x01,
                                       :CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD, 0x02]

    enum :CUgraphicsRegisterFlags, [:CU_GRAPHICS_REGISTER_FLAGS_NONE, 0x00,
                                    :CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY, 0x01,
                                    :CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD, 0x02,
                                    :CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST, 0x04,
                                    :CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER, 0x08]

    enum :CUipcMem_flags, [:CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS, 0x1]

    enum :CUjitInputType, [:CU_JIT_INPUT_CUBIN, 0,
                           :CU_JIT_INPUT_PTX,
                           :CU_JIT_INPUT_FATBINARY,
                           :CU_JIT_INPUT_OBJECT,
                           :CU_JIT_INPUT_LIBRARY,
                           :CU_JIT_INPUT_NVVM,
                           :CU_JIT_NUM_INPUT_TYPES]

    enum :CUjit_cacheMode, [:CU_JIT_CACHE_OPTION_NONE, 0,
                            :CU_JIT_CACHE_OPTION_CG,
                            :CU_JIT_CACHE_OPTION_CA]

    enum :CUjit_fallback, [:CU_PREFER_PTX, 0,
                           :CU_PREFER_BINARY]

    enum :CUjit_option, [:CU_JIT_MAX_REGISTERS,  0,
                         :CU_JIT_THREADS_PER_BLOCK,
                         :CU_JIT_WALL_TIME,
                         :CU_JIT_INFO_LOG_BUFFER,
                         :CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES,
                         :CU_JIT_ERROR_LOG_BUFFER,
                         :CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES,
                         :CU_JIT_OPTIMIZATION_LEVEL,
                         :CU_JIT_TARGET_FROM_CUCONTEXT,
                         :CU_JIT_TARGET,
                         :CU_JIT_FALLBACK_STRATEGY,
                         :CU_JIT_GENERATE_DEBUG_INFO,
                         :CU_JIT_LOG_VERBOSE,
                         :CU_JIT_GENERATE_LINE_INFO,
                         :CU_JIT_CACHE_MODE,
                         :CU_JIT_NEW_SM3X_OPT,
                         :CU_JIT_FAST_COMPILE,
                         :CU_JIT_GLOBAL_SYMBOL_NAMES,
                         :CU_JIT_GLOBAL_SYMBOL_ADDRESSES,
                         :CU_JIT_GLOBAL_SYMBOL_COUNT,
                         :CU_JIT_LTO,
                         :CU_JIT_FTZ,
                         :CU_JIT_PREC_DIV,
                         :CU_JIT_PREC_SQRT,
                         :CU_JIT_FMA,
                         :CU_JIT_NUM_OPTIONS]

    enum :CUjit_target, [:CU_TARGET_COMPUTE_20,  20,
                         :CU_TARGET_COMPUTE_21,  21,
                         :CU_TARGET_COMPUTE_30,  30,
                         :CU_TARGET_COMPUTE_32,  32,
                         :CU_TARGET_COMPUTE_35,  35,
                         :CU_TARGET_COMPUTE_37,  37,
                         :CU_TARGET_COMPUTE_50,  50,
                         :CU_TARGET_COMPUTE_52,  52,
                         :CU_TARGET_COMPUTE_53,  53,
                         :CU_TARGET_COMPUTE_60,  60,
                         :CU_TARGET_COMPUTE_61,  61,
                         :CU_TARGET_COMPUTE_62,  62,
                         :CU_TARGET_COMPUTE_70,  70,
                         :CU_TARGET_COMPUTE_72,  72,
                         :CU_TARGET_COMPUTE_75,  75,
                         :CU_TARGET_COMPUTE_80,  80,
                         :CU_TARGET_COMPUTE_86,  86]

    enum :CUkernelNodeAttrID, [:CU_KERNEL_NODE_ATTRIBUTE_ACCESS_POLICY_WINDOW, 1,
                               :CU_KERNEL_NODE_ATTRIBUTE_COOPERATIVE, 2]

    enum :CUlimit, [:CU_LIMIT_STACK_SIZE, 0x00,
                    :CU_LIMIT_PRINTF_FIFO_SIZE,  0x01,
                    :CU_LIMIT_MALLOC_HEAP_SIZE,  0x02,
                    :CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH, 0x03,
                    :CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT, 0x04,
                    :CU_LIMIT_MAX_L2_FETCH_GRANULARITY,  0x05,
                    :CU_LIMIT_PERSISTING_L2_CACHE_SIZE,  0x06,
                    :CU_LIMIT_MAX]

    enum :CUmemAccess_flags, [:CU_MEM_ACCESS_FLAGS_PROT_NONE, 0x0,
                              :CU_MEM_ACCESS_FLAGS_PROT_READ, 0x1,
                              :CU_MEM_ACCESS_FLAGS_PROT_READWRITE, 0x3,
                              :CU_MEM_ACCESS_FLAGS_PROT_MAX, 0x7FFFFFFF]

    enum :CUmemAllocationCompType, [:CU_MEM_ALLOCATION_COMP_NONE, 0x0,
                                    :CU_MEM_ALLOCATION_COMP_GENERIC, 0x1]

    enum :CUmemAllocationGranularity_flags, [:CU_MEM_ALLOC_GRANULARITY_MINIMUM, 0x0,
                                             :CU_MEM_ALLOC_GRANULARITY_RECOMMENDED, 0x1]

    enum :CUmemAllocationHandleType, [:CU_MEM_HANDLE_TYPE_NONE, 0x0,
                                      :CU_MEM_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR, 0x1,
                                      :CU_MEM_HANDLE_TYPE_WIN32, 0x2,
                                      :CU_MEM_HANDLE_TYPE_WIN32_KMT, 0x4,
                                      :CU_MEM_HANDLE_TYPE_MAX, 0x7FFFFFFF]

    enum :CUmemAllocationType, [:CU_MEM_ALLOCATION_TYPE_INVALID, 0x0,
                                :CU_MEM_ALLOCATION_TYPE_PINNED, 0x1,
                                :CU_MEM_ALLOCATION_TYPE_MAX, 0x7FFFFFFF]

    enum :CUmemAttach_flags, [:CU_MEM_ATTACH_GLOBAL, 0x1,
                              :CU_MEM_ATTACH_HOST, 0x2,
                              :CU_MEM_ATTACH_SINGLE, 0x4]

    enum :CUmemHandleType, [:CU_MEM_HANDLE_TYPE_GENERIC, 0]

    enum :CUmemLocationType, [:CU_MEM_LOCATION_TYPE_INVALID, 0x0,
                              :CU_MEM_LOCATION_TYPE_DEVICE, 0x1,
                              :CU_MEM_LOCATION_TYPE_MAX, 0x7FFFFFFF]

    enum :CUmemOperationType, [:CU_MEM_OPERATION_TYPE_MAP, 1,
                               :CU_MEM_OPERATION_TYPE_UNMAP, 2]

    enum :CUmemPool_attribute, [:CU_MEMPOOL_ATTR_REUSE_FOLLOW_EVENT_DEPENDENCIES, 1,
                                :CU_MEMPOOL_ATTR_REUSE_ALLOW_OPPORTUNISTIC,
                                :CU_MEMPOOL_ATTR_REUSE_ALLOW_INTERNAL_DEPENDENCIES,
                                :CU_MEMPOOL_ATTR_RELEASE_THRESHOLD,
                                :CU_MEMPOOL_ATTR_RESERVED_MEM_CURRENT,
                                :CU_MEMPOOL_ATTR_RESERVED_MEM_HIGH,
                                :CU_MEMPOOL_ATTR_USED_MEM_CURRENT,
                                :CU_MEMPOOL_ATTR_USED_MEM_HIGH]

    enum :CUmem_advise, [:CU_MEM_ADVISE_SET_READ_MOSTLY, 1,
                         :CU_MEM_ADVISE_UNSET_READ_MOSTLY, 2,
                         :CU_MEM_ADVISE_SET_PREFERRED_LOCATION, 3,
                         :CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION, 4,
                         :CU_MEM_ADVISE_SET_ACCESSED_BY, 5,
                         :CU_MEM_ADVISE_UNSET_ACCESSED_BY, 6]

    enum :CUmemorytype, [:CU_MEMORYTYPE_HOST, 0x01,
                         :CU_MEMORYTYPE_DEVICE, 0x02,
                         :CU_MEMORYTYPE_ARRAY, 0x03,
                         :CU_MEMORYTYPE_UNIFIED, 0x04]

    enum :CUoccupancy_flags, [:CU_OCCUPANCY_DEFAULT, 0x0,
                              :CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE, 0x1]

    enum :CUpointer_attribute, [:CU_POINTER_ATTRIBUTE_CONTEXT, 1,
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

    enum :CUresourceViewFormat, [:CU_RES_VIEW_FORMAT_NONE, 0x00,
                                 :CU_RES_VIEW_FORMAT_UINT_1X8,  0x01,
                                 :CU_RES_VIEW_FORMAT_UINT_2X8,  0x02,
                                 :CU_RES_VIEW_FORMAT_UINT_4X8,  0x03,
                                 :CU_RES_VIEW_FORMAT_SINT_1X8,  0x04,
                                 :CU_RES_VIEW_FORMAT_SINT_2X8,  0x05,
                                 :CU_RES_VIEW_FORMAT_SINT_4X8,  0x06,
                                 :CU_RES_VIEW_FORMAT_UINT_1X16,  0x07,
                                 :CU_RES_VIEW_FORMAT_UINT_2X16,  0x08,
                                 :CU_RES_VIEW_FORMAT_UINT_4X16,  0x09,
                                 :CU_RES_VIEW_FORMAT_SINT_1X16,  0x0a,
                                 :CU_RES_VIEW_FORMAT_SINT_2X16,  0x0b,
                                 :CU_RES_VIEW_FORMAT_SINT_4X16,  0x0c,
                                 :CU_RES_VIEW_FORMAT_UINT_1X32,  0x0d,
                                 :CU_RES_VIEW_FORMAT_UINT_2X32,  0x0e,
                                 :CU_RES_VIEW_FORMAT_UINT_4X32,  0x0f,
                                 :CU_RES_VIEW_FORMAT_SINT_1X32,  0x10,
                                 :CU_RES_VIEW_FORMAT_SINT_2X32,  0x11,
                                 :CU_RES_VIEW_FORMAT_SINT_4X32,  0x12,
                                 :CU_RES_VIEW_FORMAT_FLOAT_1X16,  0x13,
                                 :CU_RES_VIEW_FORMAT_FLOAT_2X16,  0x14,
                                 :CU_RES_VIEW_FORMAT_FLOAT_4X16,  0x15,
                                 :CU_RES_VIEW_FORMAT_FLOAT_1X32,  0x16,
                                 :CU_RES_VIEW_FORMAT_FLOAT_2X32,  0x17,
                                 :CU_RES_VIEW_FORMAT_FLOAT_4X32,  0x18,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC1,  0x19,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC2,  0x1a,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC3,  0x1b,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC4,  0x1c,
                                 :CU_RES_VIEW_FORMAT_SIGNED_BC4, 0x1d,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC5, 0x1e,
                                 :CU_RES_VIEW_FORMAT_SIGNED_BC5, 0x1f,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC6H, 0x20,
                                 :CU_RES_VIEW_FORMAT_SIGNED_BC6H, 0x21,
                                 :CU_RES_VIEW_FORMAT_UNSIGNED_BC7, 0x22]

    enum :CUresourcetype, [:CU_RESOURCE_TYPE_ARRAY, 0x00,
                           :CU_RESOURCE_TYPE_MIPMAPPED_ARRAY, 0x01,
                           :CU_RESOURCE_TYPE_LINEAR, 0x02,
                           :CU_RESOURCE_TYPE_PITCH2D,  0x03]

    enum :CUresult, [:CUDA_SUCCESS, 0,
                     :CUDA_ERROR_INVALID_VALUE,  1,
                     :CUDA_ERROR_OUT_OF_MEMORY,  2,
                     :CUDA_ERROR_NOT_INITIALIZED, 3,
                     :CUDA_ERROR_DEINITIALIZED, 4,
                     :CUDA_ERROR_PROFILER_DISABLED, 5,
                     :CUDA_ERROR_PROFILER_NOT_INITIALIZED,  6,
                     :CUDA_ERROR_PROFILER_ALREADY_STARTED,  7,
                     :CUDA_ERROR_PROFILER_ALREADY_STOPPED,  8,
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
                     :CUDA_ERROR_ALREADY_MAPPED,  208,
                     :CUDA_ERROR_NO_BINARY_FOR_GPU, 209,
                     :CUDA_ERROR_ALREADY_ACQUIRED, 210,
                     :CUDA_ERROR_NOT_MAPPED, 211,
                     :CUDA_ERROR_NOT_MAPPED_AS_ARRAY, 212,
                     :CUDA_ERROR_NOT_MAPPED_AS_POINTER, 213,
                     :CUDA_ERROR_ECC_UNCORRECTABLE,  214,
                     :CUDA_ERROR_UNSUPPORTED_LIMIT,  215,
                     :CUDA_ERROR_CONTEXT_ALREADY_IN_USE, 216,
                     :CUDA_ERROR_PEER_ACCESS_UNSUPPORTED, 217,
                     :CUDA_ERROR_INVALID_PTX, 218,
                     :CUDA_ERROR_INVALID_GRAPHICS_CONTEXT, 219,
                     :CUDA_ERROR_NVLINK_UNCORRECTABLE, 220,
                     :CUDA_ERROR_JIT_COMPILER_NOT_FOUND, 221,
                     :CUDA_ERROR_UNSUPPORTED_PTX_VERSION, 222,
                     :CUDA_ERROR_JIT_COMPILATION_DISABLED,  223,
                     :CUDA_ERROR_UNSUPPORTED_EXEC_AFFINITY,  224,
                     :CUDA_ERROR_INVALID_SOURCE,  300,
                     :CUDA_ERROR_FILE_NOT_FOUND,  301,
                     :CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND, 302,
                     :CUDA_ERROR_SHARED_OBJECT_INIT_FAILED, 303,
                     :CUDA_ERROR_OPERATING_SYSTEM, 304,
                     :CUDA_ERROR_INVALID_HANDLE, 400,
                     :CUDA_ERROR_ILLEGAL_STATE, 401,
                     :CUDA_ERROR_NOT_FOUND,  500,
                     :CUDA_ERROR_NOT_READY,  600,
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
                     :CUDA_ERROR_MISALIGNED_ADDRESS,  716,
                     :CUDA_ERROR_INVALID_ADDRESS_SPACE, 717,
                     :CUDA_ERROR_INVALID_PC, 718,
                     :CUDA_ERROR_LAUNCH_FAILED, 719,
                     :CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE, 720,
                     :CUDA_ERROR_NOT_PERMITTED,  800,
                     :CUDA_ERROR_NOT_SUPPORTED,  801,
                     :CUDA_ERROR_SYSTEM_NOT_READY, 802,
                     :CUDA_ERROR_SYSTEM_DRIVER_MISMATCH, 803,
                     :CUDA_ERROR_COMPAT_NOT_SUPPORTED_ON_DEVICE, 804,
                     :CUDA_ERROR_MPS_CONNECTION_FAILED, 805,
                     :CUDA_ERROR_MPS_RPC_FAILURE, 806,
                     :CUDA_ERROR_MPS_SERVER_NOT_READY, 807,
                     :CUDA_ERROR_MPS_MAX_CLIENTS_REACHED, 808,
                     :CUDA_ERROR_MPS_MAX_CONNECTIONS_REACHED, 809,
                     :CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED,  900,
                     :CUDA_ERROR_STREAM_CAPTURE_INVALIDATED,  901,
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

    enum :CUshared_carveout, [:CU_SHAREDMEM_CARVEOUT_DEFAULT, -1,
                              :CU_SHAREDMEM_CARVEOUT_MAX_SHARED, 100,
                              :CU_SHAREDMEM_CARVEOUT_MAX_L1, 0]

    enum :CUsharedconfig, [:CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE, 0x00,
                           :CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE, 0x01,
                           :CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE, 0x02]

    enum :CUstreamAttrID, [:CU_STREAM_ATTRIBUTE_ACCESS_POLICY_WINDOW, 1,
                           :CU_STREAM_ATTRIBUTE_SYNCHRONIZATION_POLICY, 3]

    enum :CUstreamBatchMemOpType, [:CU_STREAM_MEM_OP_WAIT_VALUE_32, 1,
                                   :CU_STREAM_MEM_OP_WRITE_VALUE_32, 2,
                                   :CU_STREAM_MEM_OP_WAIT_VALUE_64, 4,
                                   :CU_STREAM_MEM_OP_WRITE_VALUE_64, 5,
                                   :CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES, 3]

    enum :CUstreamCaptureMode, [:CU_STREAM_CAPTURE_MODE_GLOBAL, 0,
                                :CU_STREAM_CAPTURE_MODE_THREAD_LOCAL, 1,
                                :CU_STREAM_CAPTURE_MODE_RELAXED, 2]

    enum :CUstreamCaptureStatus, [:CU_STREAM_CAPTURE_STATUS_NONE, 0,
                                  :CU_STREAM_CAPTURE_STATUS_ACTIVE, 1,
                                  :CU_STREAM_CAPTURE_STATUS_INVALIDATED, 2]

    enum :CUstreamUpdateCaptureDependencies_flags, [:CU_STREAM_ADD_CAPTURE_DEPENDENCIES, 0x0,
                                                    :CU_STREAM_SET_CAPTURE_DEPENDENCIES, 0x1]

    enum :CUstreamWaitValue_flags, [:CU_STREAM_WAIT_VALUE_GEQ, 0x0,
                                    :CU_STREAM_WAIT_VALUE_EQ, 0x1,
                                    :CU_STREAM_WAIT_VALUE_AND,  0x2,
                                    :CU_STREAM_WAIT_VALUE_NOR,  0x3,
                                    :CU_STREAM_WAIT_VALUE_FLUSH, 1 << 30]

    enum :CUstreamWriteValue_flags, [:CU_STREAM_WRITE_VALUE_DEFAULT, 0x0,
                                     :CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER, 0x1]

    enum :CUstream_flags, [:CU_STREAM_DEFAULT, 0x0,
                           :CU_STREAM_NON_BLOCKING, 0x1]

    enum :CUuserObjectRetain_flags, [:CU_GRAPH_USER_OBJECT_MOVE, 1]

    # Functions

    attach_function :cuCtxCreate, %i[pointer unsigned_int CUdevice], :CUresult
    attach_function :cuCtxCreate_v3, %i[pointer pointer int unsigned_int CUdevice], :CUresult
    attach_function :cuCtxDestroy, [:CUcontext], :CUresult
    attach_function :cuCtxGetApiVersion, %i[CUcontext pointer], :CUresult
    attach_function :cuCtxGetCacheConfig, [:pointer], :CUresult
    attach_function :cuCtxGetCurrent, [:pointer], :CUresult
    attach_function :cuCtxGetDevice, [:pointer], :CUresult
    attach_function :cuCtxGetExecAffinity, %i[pointer CUexecAffinityType], :CUresult
    attach_function :cuCtxGetFlags, [:pointer], :CUresult
    attach_function :cuCtxGetLimit, %i[pointer CUlimit], :CUresult
    attach_function :cuCtxGetSharedMemConfig, [:pointer], :CUresult
    attach_function :cuCtxGetStreamPriorityRange, %i[pointer pointer], :CUresult
    attach_function :cuCtxPopCurrent, [:pointer], :CUresult
    attach_function :cuCtxPushCurrent, [:CUcontext], :CUresult
    attach_function :cuCtxResetPersistingL2Cache, [], :CUresult
    attach_function :cuCtxSetCacheConfig, [:CUfunc_cache], :CUresult
    attach_function :cuCtxSetCurrent, [:CUcontext], :CUresult
    attach_function :cuCtxSetLimit, %i[CUlimit size_t], :CUresult
    attach_function :cuCtxSetSharedMemConfig, [:CUsharedconfig], :CUresult
    attach_function :cuCtxSynchronize, [], :CUresult
    attach_function :cuCtxAttach, %i[pointer unsigned_int], :CUresult
    attach_function :cuCtxDetach, [:CUcontext], :CUresult
    attach_function :cuDeviceGet, %i[pointer int], :CUresult
    attach_function :cuDeviceGetAttribute, %i[pointer CUdevice_attribute CUdevice], :CUresult
    attach_function :cuDeviceGetCount, [:pointer], :CUresult
    attach_function :cuDeviceGetDefaultMemPool, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetLuid, %i[pointer pointer CUdevice], :CUresult
    attach_function :cuDeviceGetMemPool, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetName, %i[pointer int CUdevice], :CUresult
    attach_function :cuDeviceGetNvSciSyncAttributes, %i[pointer CUdevice int], :CUresult
    attach_function :cuDeviceGetTexture1DLinearMaxWidth, %i[pointer CUarray_format unsigned_int CUdevice],
                    :CUresult
    attach_function :cuDeviceGetUuid, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceGetUuid_v2, %i[pointer CUdevice], :CUresult
    attach_function :cuDeviceSetMemPool, %i[CUdevice CUmemoryPool], :CUresult
    attach_function :cuDeviceTotalMem, %i[pointer CUdevice], :CUresult
    attach_function :cuFlushGPUDirectRDMAWrites,
                    %i[CUflushGPUDirectRDMAWritesTarget CUflushGPUDirectRDMAWritesScope], :CUresult
    attach_function :cuDeviceComputeCapability, %i[pointer pointer CUdevice], :CUresult
    attach_function :cuDeviceGetProperties, %i[pointer CUdevice], :CUresult
    attach_function :cuGetProcAddress, %i[pointer pointer int cuuint64_t], :CUresult
    attach_function :cuGetErrorName, %i[CUresult pointer], :CUresult
    attach_function :cuGetErrorString, %i[CUresult pointer], :CUresult
    attach_function :cuEventCreate, %i[pointer unsigned_int], :CUresult
    attach_function :cuEventDestroy, [:CUevent], :CUresult
    attach_function :cuEventElapsedTime, %i[pointer CUevent CUevent], :CUresult
    attach_function :cuEventQuery, [:CUevent], :CUresult
    attach_function :cuEventRecord, %i[CUevent CUstream], :CUresult
    attach_function :cuEventRecordWithFlags, %i[CUevent CUstream unsigned_int], :CUresult
    attach_function :cuEventSynchronize, [:CUevent], :CUresult
    attach_function :cuFuncGetAttribute, %i[pointer CUfunction_attribute CUfunction], :CUresult
    attach_function :cuFuncGetModule, %i[pointer CUfunction], :CUresult
    attach_function :cuFuncSetAttribute, %i[CUfunction CUfunction_attribute int], :CUresult
    attach_function :cuFuncSetCacheConfig, %i[CUfunction CUfunc_cache], :CUresult
    attach_function :cuFuncSetSharedMemConfig, %i[CUfunction CUsharedconfig], :CUresult
    attach_function :cuLaunchCooperativeKernel,
                    %i[CUfunction unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int CUstream pointer], :CUresult
    attach_function :cuLaunchCooperativeKernelMultiDevice, %i[pointer unsigned_int unsigned_int], :CUresult
    attach_function :cuLaunchHostFunc, %i[CUstream CUhostFn pointer], :CUresult
    attach_function :cuLaunchKernel,
                    %i[CUfunction unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int unsigned_int CUstream pointer pointer], :CUresult
    attach_function :cuFuncSetBlockShape, %i[CUfunction int int int], :CUresult
    attach_function :cuFuncSetSharedSize, %i[CUfunction unsigned_int], :CUresult
    attach_function :cuLaunch, [:CUfunction], :CUresult
    attach_function :cuLaunchGrid, %i[CUfunction int int], :CUresult
    attach_function :cuLaunchGridAsync, %i[CUfunction int int CUstream], :CUresult
    attach_function :cuParamSetSize, %i[CUfunction unsigned_int], :CUresult
    attach_function :cuParamSetTexRef, %i[CUfunction int CUtexref], :CUresult
    attach_function :cuParamSetf, %i[CUfunction int float], :CUresult
    attach_function :cuParamSeti, %i[CUfunction int unsigned_int], :CUresult
    attach_function :cuParamSetv, %i[CUfunction int pointer unsigned_int], :CUresult
    attach_function :cuDestroyExternalMemory, [:CUexternalMemory], :CUresult
    attach_function :cuDestroyExternalSemaphore, [:CUexternalSemaphore], :CUresult
    attach_function :cuExternalMemoryGetMappedBuffer, %i[pointer CUexternalMemory pointer], :CUresult
    attach_function :cuExternalMemoryGetMappedMipmappedArray, %i[pointer CUexternalMemory pointer], :CUresult
    attach_function :cuImportExternalMemory, %i[pointer pointer], :CUresult
    attach_function :cuImportExternalSemaphore, %i[pointer pointer], :CUresult
    attach_function :cuSignalExternalSemaphoresAsync, %i[pointer pointer unsigned_int CUstream], :CUresult
    attach_function :cuWaitExternalSemaphoresAsync, %i[pointer pointer unsigned_int CUstream], :CUresult
    attach_function :cuGLCtxCreate, %i[pointer unsigned_int CUdevice], :CUresult
    attach_function :cuGLInit, [], :CUresult
    attach_function :cuGLMapBufferObject, %i[pointer pointer GLuint], :CUresult
    attach_function :cuGLMapBufferObjectAsync, %i[pointer pointer GLuint CUstream], :CUresult
    attach_function :cuGLRegisterBufferObject, [:GLuint], :CUresult
    attach_function :cuGLSetBufferObjectMapFlags, %i[GLuint unsigned_int], :CUresult
    attach_function :cuGLUnmapBufferObject, [:GLuint], :CUresult
    attach_function :cuGLUnmapBufferObjectAsync, %i[GLuint CUstream], :CUresult
    attach_function :cuGLUnregisterBufferObject, [:GLuint], :CUresult
    attach_function :cuDeviceGetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuDeviceGraphMemTrim, [:CUdevice], :CUresult
    attach_function :cuDeviceSetGraphMemAttribute, %i[CUdevice CUgraphMem_attribute pointer], :CUresult
    attach_function :cuGraphAddChildGraphNode, %i[pointer CUgraph pointer size_t CUgraph], :CUresult
    attach_function :cuGraphAddDependencies, %i[CUgraph pointer pointer size_t], :CUresult
    attach_function :cuGraphAddEmptyNode, %i[pointer CUgraph pointer size_t], :CUresult
    attach_function :cuGraphAddEventRecordNode, %i[pointer CUgraph pointer size_t CUevent], :CUresult
    attach_function :cuGraphAddEventWaitNode, %i[pointer CUgraph pointer size_t CUevent], :CUresult
    attach_function :cuGraphAddExternalSemaphoresSignalNode, %i[pointer CUgraph pointer size_t pointer],
                    :CUresult
    attach_function :cuGraphAddExternalSemaphoresWaitNode, %i[pointer CUgraph pointer size_t pointer],
                    :CUresult
    attach_function :cuGraphAddHostNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphAddKernelNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphAddMemAllocNode, %i[pointer CUgraph pointer size_t pointer], :CUresult
    attach_function :cuGraphAddMemFreeNode, %i[pointer CUgraph pointer size_t CUdeviceptr], :CUresult
    attach_function :cuGraphAddMemcpyNode, %i[pointer CUgraph pointer size_t pointer CUcontext],
                    :CUresult
    attach_function :cuGraphAddMemsetNode, %i[pointer CUgraph pointer size_t pointer CUcontext],
                    :CUresult
    attach_function :cuGraphChildGraphNodeGetGraph, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphClone, %i[pointer CUgraph], :CUresult
    attach_function :cuGraphCreate, %i[pointer unsigned_int], :CUresult
    attach_function :cuGraphDebugDotPrint, %i[CUgraph pointer unsigned_int], :CUresult
    attach_function :cuGraphDestroy, [:CUgraph], :CUresult
    attach_function :cuGraphDestroyNode, [:CUgraphNode], :CUresult
    attach_function :cuGraphEventRecordNodeGetEvent, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphEventRecordNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphEventWaitNodeGetEvent, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphEventWaitNodeSetEvent, %i[CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecChildGraphNodeSetParams, %i[CUgraphExec CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphExecDestroy, [:CUgraphExec], :CUresult
    attach_function :cuGraphExecEventRecordNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecEventWaitNodeSetEvent, %i[CUgraphExec CUgraphNode CUevent], :CUresult
    attach_function :cuGraphExecExternalSemaphoresSignalNodeSetParams, %i[CUgraphExec CUgraphNode pointer],
                    :CUresult
    attach_function :cuGraphExecExternalSemaphoresWaitNodeSetParams, %i[CUgraphExec CUgraphNode pointer],
                    :CUresult
    attach_function :cuGraphExecHostNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphExecKernelNodeSetParams, %i[CUgraphExec CUgraphNode pointer], :CUresult
    attach_function :cuGraphExecMemcpyNodeSetParams, %i[CUgraphExec CUgraphNode pointer CUcontext],
                    :CUresult
    attach_function :cuGraphExecMemsetNodeSetParams, %i[CUgraphExec CUgraphNode pointer CUcontext],
                    :CUresult
    attach_function :cuGraphExecUpdate, %i[CUgraphExec CUgraph pointer pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresSignalNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphExternalSemaphoresWaitNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphGetEdges, %i[CUgraph pointer pointer pointer], :CUresult
    attach_function :cuGraphGetNodes, %i[CUgraph pointer pointer], :CUresult
    attach_function :cuGraphGetRootNodes, %i[CUgraph pointer pointer], :CUresult
    attach_function :cuGraphHostNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphHostNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphInstantiate, %i[pointer CUgraph pointer pointer size_t], :CUresult
    attach_function :cuGraphInstantiateWithFlags, %i[pointer CUgraph unsigned_long_long], :CUresult
    attach_function :cuGraphKernelNodeCopyAttributes, %i[CUgraphNode CUgraphNode], :CUresult
    attach_function :cuGraphKernelNodeGetAttribute, %i[CUgraphNode CUkernelNodeAttrID pointer], :CUresult
    attach_function :cuGraphKernelNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphKernelNodeSetAttribute, %i[CUgraphNode CUkernelNodeAttrID pointer], :CUresult
    attach_function :cuGraphKernelNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphLaunch, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuGraphMemAllocNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemFreeNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemcpyNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemcpyNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemsetNodeGetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphMemsetNodeSetParams, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphNodeFindInClone, %i[pointer CUgraphNode CUgraph], :CUresult
    attach_function :cuGraphNodeGetDependencies, %i[CUgraphNode pointer pointer], :CUresult
    attach_function :cuGraphNodeGetDependentNodes, %i[CUgraphNode pointer pointer], :CUresult
    attach_function :cuGraphNodeGetType, %i[CUgraphNode pointer], :CUresult
    attach_function :cuGraphReleaseUserObject, %i[CUgraph CUuserObject unsigned_int], :CUresult
    attach_function :cuGraphRemoveDependencies, %i[CUgraph pointer pointer size_t], :CUresult
    attach_function :cuGraphRetainUserObject, %i[CUgraph CUuserObject unsigned_int unsigned_int], :CUresult
    attach_function :cuGraphUpload, %i[CUgraphExec CUstream], :CUresult
    attach_function :cuUserObjectCreate, %i[pointer pointer CUhostFn unsigned_int unsigned_int],
                    :CUresult
    attach_function :cuUserObjectRelease, %i[CUuserObject unsigned_int], :CUresult
    attach_function :cuUserObjectRetain, %i[CUuserObject unsigned_int], :CUresult
    attach_function :cuInit, [:unsigned_int], :CUresult
    attach_function :cuMemAllocAsync, %i[pointer size_t CUstream], :CUresult
    attach_function :cuMemAllocFromPoolAsync, %i[pointer size_t CUmemoryPool CUstream], :CUresult
    attach_function :cuMemFreeAsync, %i[CUdeviceptr CUstream], :CUresult
    attach_function :cuMemPoolCreate, %i[pointer pointer], :CUresult
    attach_function :cuMemPoolDestroy, [:CUmemoryPool], :CUresult
    attach_function :cuMemPoolExportPointer, %i[pointer CUdeviceptr], :CUresult
    attach_function :cuMemPoolExportToShareableHandle,
                    %i[pointer CUmemoryPool CUmemAllocationHandleType unsigned_long_long], :CUresult
    attach_function :cuMemPoolGetAccess, %i[pointer CUmemoryPool pointer], :CUresult
    attach_function :cuMemPoolGetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolImportFromShareableHandle,
                    %i[pointer pointer CUmemAllocationHandleType unsigned_long_long], :CUresult
    attach_function :cuMemPoolImportPointer, %i[pointer CUmemoryPool pointer], :CUresult
    attach_function :cuMemPoolSetAccess, %i[CUmemoryPool pointer size_t], :CUresult
    attach_function :cuMemPoolSetAttribute, %i[CUmemoryPool CUmemPool_attribute pointer], :CUresult
    attach_function :cuMemPoolTrimTo, %i[CUmemoryPool size_t], :CUresult
    attach_function :cuArray3DCreate, %i[pointer pointer], :CUresult
    attach_function :cuArray3DGetDescriptor, %i[pointer CUarray], :CUresult
    attach_function :cuArrayCreate, %i[pointer pointer], :CUresult
    attach_function :cuArrayDestroy, [:CUarray], :CUresult
    attach_function :cuArrayGetDescriptor, %i[pointer CUarray], :CUresult
    attach_function :cuArrayGetPlane, %i[pointer CUarray unsigned_int], :CUresult
    attach_function :cuArrayGetSparseProperties, %i[pointer CUarray], :CUresult
    attach_function :cuDeviceGetByPCIBusId, %i[pointer pointer], :CUresult
    attach_function :cuDeviceGetPCIBusId, %i[pointer int CUdevice], :CUresult
    attach_function :cuIpcCloseMemHandle, [:CUdeviceptr], :CUresult
    attach_function :cuIpcGetEventHandle, %i[pointer CUevent], :CUresult
    attach_function :cuIpcGetMemHandle, %i[pointer CUdeviceptr], :CUresult
    attach_function :cuIpcOpenEventHandle, %i[pointer CUipcEventHandle], :CUresult
    attach_function :cuIpcOpenMemHandle, %i[pointer CUipcMemHandle unsigned_int], :CUresult
    attach_function :cuMemAlloc, %i[pointer size_t], :CUresult
    attach_function :cuMemAllocHost, %i[pointer size_t], :CUresult
    attach_function :cuMemAllocManaged, %i[pointer size_t unsigned_int], :CUresult
    attach_function :cuMemAllocPitch, %i[pointer pointer size_t size_t unsigned_int], :CUresult
    attach_function :cuMemFree, [:CUdeviceptr], :CUresult
    attach_function :cuMemFreeHost, [:pointer], :CUresult
    attach_function :cuMemGetAddressRange, %i[pointer pointer CUdeviceptr], :CUresult
    attach_function :cuMemGetInfo, %i[pointer pointer], :CUresult
    attach_function :cuMemHostAlloc, %i[pointer size_t unsigned_int], :CUresult
    attach_function :cuMemHostGetDevicePointer, %i[pointer pointer unsigned_int], :CUresult
    attach_function :cuMemHostGetFlags, %i[pointer pointer], :CUresult
    attach_function :cuMemHostRegister, %i[pointer size_t unsigned_int], :CUresult
    attach_function :cuMemHostUnregister, [:pointer], :CUresult
    attach_function :cuMemcpy, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpy2D, [:pointer], :CUresult
    attach_function :cuMemcpy2DAsync, %i[pointer CUstream], :CUresult
    attach_function :cuMemcpy2DUnaligned, [:pointer], :CUresult
    attach_function :cuMemcpy3D, [:pointer], :CUresult
    attach_function :cuMemcpy3DAsync, %i[pointer CUstream], :CUresult
    attach_function :cuMemcpy3DPeer, [:pointer], :CUresult
    attach_function :cuMemcpy3DPeerAsync, %i[pointer CUstream], :CUresult
    attach_function :cuMemcpyAsync, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyAtoA, %i[CUarray size_t CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyAtoD, %i[CUdeviceptr CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyAtoH, %i[pointer CUarray size_t size_t], :CUresult
    attach_function :cuMemcpyAtoHAsync, %i[pointer CUarray size_t size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoA, %i[CUarray size_t CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoD, %i[CUdeviceptr CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoDAsync, %i[CUdeviceptr CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyDtoH, %i[pointer CUdeviceptr size_t], :CUresult
    attach_function :cuMemcpyDtoHAsync, %i[pointer CUdeviceptr size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoA, %i[CUarray size_t pointer size_t], :CUresult
    attach_function :cuMemcpyHtoAAsync, %i[CUarray size_t pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyHtoD, %i[CUdeviceptr pointer size_t], :CUresult
    attach_function :cuMemcpyHtoDAsync, %i[CUdeviceptr pointer size_t CUstream], :CUresult
    attach_function :cuMemcpyPeer, %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t], :CUresult
    attach_function :cuMemcpyPeerAsync,
                    %i[CUdeviceptr CUcontext CUdeviceptr CUcontext size_t CUstream], :CUresult
    attach_function :cuMemsetD16, %i[CUdeviceptr unsigned_short size_t], :CUresult
    attach_function :cuMemsetD16Async, %i[CUdeviceptr unsigned_short size_t CUstream], :CUresult
    attach_function :cuMemsetD2D16, %i[CUdeviceptr size_t unsigned_short size_t size_t], :CUresult
    attach_function :cuMemsetD2D16Async, %i[CUdeviceptr size_t unsigned_short size_t size_t CUstream],
                    :CUresult
    attach_function :cuMemsetD2D32, %i[CUdeviceptr size_t unsigned_int size_t size_t], :CUresult
    attach_function :cuMemsetD2D32Async, %i[CUdeviceptr size_t unsigned_int size_t size_t CUstream],
                    :CUresult
    attach_function :cuMemsetD2D8, %i[CUdeviceptr size_t unsigned_char size_t size_t], :CUresult
    attach_function :cuMemsetD2D8Async, %i[CUdeviceptr size_t unsigned_char size_t size_t CUstream],
                    :CUresult
    attach_function :cuMemsetD32, %i[CUdeviceptr unsigned_int size_t], :CUresult
    attach_function :cuMemsetD32Async, %i[CUdeviceptr unsigned_int size_t CUstream], :CUresult
    attach_function :cuMemsetD8, %i[CUdeviceptr unsigned_char size_t], :CUresult
    attach_function :cuMemsetD8Async, %i[CUdeviceptr unsigned_char size_t CUstream], :CUresult
    attach_function :cuMipmappedArrayCreate, %i[pointer pointer unsigned_int], :CUresult
    attach_function :cuMipmappedArrayDestroy, [:CUmipmappedArray], :CUresult
    attach_function :cuMipmappedArrayGetLevel, %i[pointer CUmipmappedArray unsigned_int], :CUresult
    attach_function :cuMipmappedArrayGetSparseProperties, %i[pointer CUmipmappedArray], :CUresult
    attach_function :cuStreamBatchMemOp, %i[CUstream unsigned_int pointer unsigned_int], :CUresult
    attach_function :cuStreamWaitValue32, %i[CUstream CUdeviceptr cuuint32_t unsigned_int], :CUresult
    attach_function :cuStreamWaitValue64, %i[CUstream CUdeviceptr cuuint64_t unsigned_int], :CUresult
    attach_function :cuStreamWriteValue32, %i[CUstream CUdeviceptr cuuint32_t unsigned_int], :CUresult
    attach_function :cuStreamWriteValue64, %i[CUstream CUdeviceptr cuuint64_t unsigned_int], :CUresult
    attach_function :cuLinkAddData,
                    %i[CUlinkState CUjitInputType pointer size_t pointer unsigned_int pointer pointer], :CUresult
    attach_function :cuLinkAddFile,
                    %i[CUlinkState CUjitInputType pointer unsigned_int pointer pointer], :CUresult
    attach_function :cuLinkComplete, %i[CUlinkState pointer pointer], :CUresult
    attach_function :cuLinkCreate, %i[unsigned_int pointer pointer pointer], :CUresult
    attach_function :cuLinkDestroy, [:CUlinkState], :CUresult
    attach_function :cuModuleGetFunction, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetGlobal, %i[pointer pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetSurfRef, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuModuleGetTexRef, %i[pointer CUmodule pointer], :CUresult
    attach_function :cuModuleLoad, %i[pointer pointer], :CUresult
    attach_function :cuModuleLoadData, %i[pointer pointer], :CUresult
    attach_function :cuModuleLoadDataEx, %i[pointer pointer unsigned_int pointer pointer], :CUresult
    attach_function :cuModuleLoadFatBinary, %i[pointer pointer], :CUresult
    attach_function :cuModuleUnload, [:CUmodule], :CUresult
    attach_function :cuOccupancyAvailableDynamicSMemPerBlock, %i[pointer CUfunction int int], :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessor, %i[pointer CUfunction int size_t],
                    :CUresult
    attach_function :cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags,
                    %i[pointer CUfunction int size_t unsigned_int], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSize,
                    %i[pointer pointer CUfunction CUoccupancyB2DSize size_t int], :CUresult
    attach_function :cuOccupancyMaxPotentialBlockSizeWithFlags,
                    %i[pointer pointer CUfunction CUoccupancyB2DSize size_t int unsigned_int], :CUresult
    attach_function :cuCtxDisablePeerAccess, [:CUcontext], :CUresult
    attach_function :cuCtxEnablePeerAccess, %i[CUcontext unsigned_int], :CUresult
    attach_function :cuDeviceCanAccessPeer, %i[pointer CUdevice CUdevice], :CUresult
    attach_function :cuDeviceGetP2PAttribute, %i[pointer CUdevice_P2PAttribute CUdevice CUdevice],
                    :CUresult
    attach_function :cuDevicePrimaryCtxGetState, %i[CUdevice pointer pointer], :CUresult
    attach_function :cuDevicePrimaryCtxRelease, [:CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxReset, [:CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxRetain, %i[pointer CUdevice], :CUresult
    attach_function :cuDevicePrimaryCtxSetFlags, %i[CUdevice unsigned_int], :CUresult
    attach_function :cuProfilerStart, [], :CUresult
    attach_function :cuProfilerStop, [], :CUresult
    attach_function :cuProfilerInitialize, %i[pointer pointer CUoutput_mode], :CUresult
    attach_function :cuStreamAddCallback, %i[CUstream CUstreamCallback pointer unsigned_int], :CUresult
    attach_function :cuStreamAttachMemAsync, %i[CUstream CUdeviceptr size_t unsigned_int], :CUresult
    attach_function :cuStreamBeginCapture, %i[CUstream CUstreamCaptureMode], :CUresult
    attach_function :cuStreamCopyAttributes, %i[CUstream CUstream], :CUresult
    attach_function :cuStreamCreate, %i[pointer unsigned_int], :CUresult
    attach_function :cuStreamCreateWithPriority, %i[pointer unsigned_int int], :CUresult
    attach_function :cuStreamDestroy, [:CUstream], :CUresult
    attach_function :cuStreamEndCapture, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetAttribute, %i[CUstream CUstreamAttrID pointer], :CUresult
    attach_function :cuStreamGetCaptureInfo, %i[CUstream pointer pointer], :CUresult
    attach_function :cuStreamGetCaptureInfo_v2, %i[CUstream pointer pointer pointer pointer pointer],
                    :CUresult
    attach_function :cuStreamGetCtx, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetFlags, %i[CUstream pointer], :CUresult
    attach_function :cuStreamGetPriority, %i[CUstream pointer], :CUresult
    attach_function :cuStreamIsCapturing, %i[CUstream pointer], :CUresult
    attach_function :cuStreamQuery, [:CUstream], :CUresult
    attach_function :cuStreamSetAttribute, %i[CUstream CUstreamAttrID pointer], :CUresult
    attach_function :cuStreamSynchronize, [:CUstream], :CUresult
    attach_function :cuStreamUpdateCaptureDependencies, %i[CUstream pointer size_t unsigned_int], :CUresult
    attach_function :cuStreamWaitEvent, %i[CUstream CUevent unsigned_int], :CUresult
    attach_function :cuThreadExchangeStreamCaptureMode, [:pointer], :CUresult
    attach_function :cuSurfObjectCreate, %i[pointer pointer], :CUresult
    attach_function :cuSurfObjectDestroy, [:CUsurfObject], :CUresult
    attach_function :cuSurfObjectGetResourceDesc, %i[pointer CUsurfObject], :CUresult
    attach_function :cuSurfRefGetArray, %i[pointer CUsurfref], :CUresult
    attach_function :cuSurfRefSetArray, %i[CUsurfref CUarray unsigned_int], :CUresult
    attach_function :cuTexObjectCreate, %i[pointer pointer pointer pointer], :CUresult
    attach_function :cuTexObjectDestroy, [:CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuTexObjectGetResourceViewDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuTexObjectGetTextureDesc, %i[pointer CUtexObject], :CUresult
    attach_function :cuTexRefCreate, [:pointer], :CUresult
    attach_function :cuTexRefDestroy, [:CUtexref], :CUresult
    attach_function :cuTexRefGetAddress, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetAddressMode, %i[pointer CUtexref int], :CUresult
    attach_function :cuTexRefGetArray, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetBorderColor, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetFilterMode, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetFlags, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetFormat, %i[pointer pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMaxAnisotropy, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapFilterMode, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelBias, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmapLevelClamp, %i[pointer pointer CUtexref], :CUresult
    attach_function :cuTexRefGetMipmappedArray, %i[pointer CUtexref], :CUresult
    attach_function :cuTexRefSetAddress, %i[pointer CUtexref CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetAddress2D, %i[CUtexref pointer CUdeviceptr size_t], :CUresult
    attach_function :cuTexRefSetAddressMode, %i[CUtexref int CUaddress_mode], :CUresult
    attach_function :cuTexRefSetArray, %i[CUtexref CUarray unsigned_int], :CUresult
    attach_function :cuTexRefSetBorderColor, %i[CUtexref pointer], :CUresult
    attach_function :cuTexRefSetFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetFlags, %i[CUtexref unsigned_int], :CUresult
    attach_function :cuTexRefSetFormat, %i[CUtexref CUarray_format int], :CUresult
    attach_function :cuTexRefSetMaxAnisotropy, %i[CUtexref unsigned_int], :CUresult
    attach_function :cuTexRefSetMipmapFilterMode, %i[CUtexref CUfilter_mode], :CUresult
    attach_function :cuTexRefSetMipmapLevelBias, %i[CUtexref float], :CUresult
    attach_function :cuTexRefSetMipmapLevelClamp, %i[CUtexref float float], :CUresult
    attach_function :cuTexRefSetMipmappedArray, %i[CUtexref CUmipmappedArray unsigned_int], :CUresult
    attach_function :cuMemAdvise, %i[CUdeviceptr size_t CUmem_advise CUdevice], :CUresult
    attach_function :cuMemPrefetchAsync, %i[CUdeviceptr size_t CUdevice CUstream], :CUresult
    attach_function :cuMemRangeGetAttribute,
                    %i[pointer size_t CUmem_range_attribute CUdeviceptr size_t], :CUresult
    attach_function :cuMemRangeGetAttributes, %i[pointer pointer pointer size_t CUdeviceptr size_t],
                    :CUresult
    attach_function :cuPointerGetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuPointerGetAttributes, %i[unsigned_int pointer pointer CUdeviceptr], :CUresult
    attach_function :cuPointerSetAttribute, %i[pointer CUpointer_attribute CUdeviceptr], :CUresult
    attach_function :cuMemAddressFree, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuMemAddressReserve, %i[pointer size_t size_t CUdeviceptr unsigned_long_long],
                    :CUresult
    attach_function :cuMemCreate, %i[pointer size_t pointer unsigned_long_long], :CUresult
    attach_function :cuMemExportToShareableHandle,
                    %i[pointer CUmemGenericAllocationHandle CUmemAllocationHandleType unsigned_long_long], :CUresult
    attach_function :cuMemGetAccess, %i[pointer pointer CUdeviceptr], :CUresult
    attach_function :cuMemGetAllocationGranularity, %i[pointer pointer CUmemAllocationGranularity_flags],
                    :CUresult
    attach_function :cuMemGetAllocationPropertiesFromHandle, %i[pointer CUmemGenericAllocationHandle],
                    :CUresult
    attach_function :cuMemImportFromShareableHandle, %i[pointer pointer CUmemAllocationHandleType], :CUresult
    attach_function :cuMemMap,
                    %i[CUdeviceptr size_t size_t CUmemGenericAllocationHandle unsigned_long_long], :CUresult
    attach_function :cuMemMapArrayAsync, %i[pointer unsigned_int CUstream], :CUresult
    attach_function :cuMemRelease, [:CUmemGenericAllocationHandle], :CUresult
    attach_function :cuMemRetainAllocationHandle, %i[pointer pointer], :CUresult
    attach_function :cuMemSetAccess, %i[CUdeviceptr size_t pointer size_t], :CUresult
    attach_function :cuMemUnmap, %i[CUdeviceptr size_t], :CUresult
    attach_function :cuGraphicsVDPAURegisterOutputSurface, %i[pointer VdpOutputSurface unsigned_int],
                    :CUresult
    attach_function :cuGraphicsVDPAURegisterVideoSurface, %i[pointer VdpVideoSurface unsigned_int], :CUresult
    attach_function :cuVDPAUCtxCreate, %i[pointer unsigned_int CUdevice VdpDevice pointer], :CUresult
    attach_function :cuVDPAUGetDevice, %i[pointer VdpDevice pointer], :CUresult
    attach_function :cuDriverGetVersion, [:pointer], :CUresult
  end
end

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Naming/VariableNumber
