# frozen_string_literal: true

require 'test_helper'
require 'minitest/hooks/test'

class CudaContextManagementTest < Minitest::Test
  include Minitest::Hooks

  @@cuDevice = 0
  @@cuCtx = FFI::MemoryPointer.new :pointer

  def setup
    Cuda::DriverApi.cuInit(0)

    device_pointer = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuDeviceGet(device_pointer, 0)
    @@cuDevice = device_pointer.read(:int)

    Cuda::DriverApi.cuCtxCreate_v2(@@cuCtx, Cuda::DriverApi::CU_CTX_SCHED_AUTO, @@cuDevice)
  end

  def after_all
    Cuda::DriverApi.cuCtxDestroy_v2(@@cuCtx.read_pointer)
  end

  def test_cu_ctx_create
    p_ctx = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuCtxCreate_v2(p_ctx, Cuda::DriverApi::CU_CTX_SCHED_AUTO, @@cuDevice))

    # have to destroy a context after creating it
    assert_equal(:success, Cuda::DriverApi.cuCtxDestroy_v2(p_ctx.read_pointer))
  end

  def test_cu_ctx_destroy
    p_ctx = FFI::MemoryPointer.new :pointer
    Cuda::DriverApi.cuCtxCreate_v2(p_ctx, Cuda::DriverApi::CU_CTX_SCHED_AUTO, @@cuDevice)

    # have to destroy a context after creating it
    assert_equal(:success, Cuda::DriverApi.cuCtxDestroy_v2(p_ctx.read_pointer))
  end

  def test_cu_ctx_create_v3
    p_ctx = FFI::MemoryPointer.new :pointer
    num_params = 1

    sm_count_st = Cuda::DriverApi::CUexecAffinitySmCountSt.new
    sm_count_st[:val] = 3

    struct_param = Cuda::DriverApi::CUexecAffinityParamStParam.new
    struct_param[:smCount] = sm_count_st

    affinity_st = Cuda::DriverApi::CUexecAffinityParamSt.new
    affinity_st[:type] = :sm_count
    affinity_st[:param] = struct_param

    params_array = FFI::MemoryPointer.new(:pointer, 1)
    params_array.write_array_of_pointer([affinity_st])

    # FIXME: No understanding about the param array
    assert_equal(:success, Cuda::DriverApi.cuCtxCreate_v3(p_ctx, params_array, num_params, Cuda::DriverApi::CU_CTX_SCHED_AUTO, @@cuDevice))
  end

  def test_cu_ctx_get_api_version
    version = FFI::MemoryPointer.new(:uint, 1)
    assert_equal(:success, Cuda::DriverApi.cuCtxGetApiVersion(@@cuCtx.read_pointer, version))
    refute_nil(version.read(:uint))
  end

  def test_cu_ctx_get_set_cache_config
    p_config = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuCtxGetCacheConfig(p_config))
    assert_equal(:success, Cuda::DriverApi.cuCtxSetCacheConfig(p_config.read(:int)))
  end

  def test_cu_ctx_get_set_current
    p_ctx = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuCtxGetCurrent(p_ctx))
    assert_equal(p_ctx.read_pointer, @@cuCtx.read_pointer)

    assert_equal(:success, Cuda::DriverApi.cuCtxSetCurrent(p_ctx.read_pointer))
  end

  def test_cu_ctx_get_device
    device = FFI::MemoryPointer.new :int, 1
    assert_equal :success, Cuda::DriverApi.cuCtxGetDevice(device)
    assert_equal device.read(:int), @@cuDevice
  end

  def test_cu_ctx_get_exec_affinity
    p_exec_affinity = FFI::MemoryPointer.new :pointer
    assert_equal :success, Cuda::DriverApi.cuCtxGetExecAffinity(p_exec_affinity, Cuda::DriverApi::CU_EXEC_AFFINITY_TYPE_SM_COUNT)

    cuExecAffinityParam = Cuda::DriverApi::CUexecAffinityParamSt.new p_exec_affinity
    assert_equal :sm_count, cuExecAffinityParam[:type]
    refute_nil cuExecAffinityParam[:param][:smCount][:val]
  end

  def test_cu_ctx_get_flags
    flags = FFI::MemoryPointer.new(:uint, 1)
    assert_equal :success, Cuda::DriverApi.cuCtxGetFlags(flags)
    assert_equal Cuda::DriverApi::CU_CTX_SCHED_AUTO, flags.read(:uint)
  end

  def test_cu_ctx_get_set_limit
    p_value = FFI::MemoryPointer.new(:uint, 1)
    assert_equal(:success, Cuda::DriverApi.cuCtxGetLimit(p_value, Cuda::DriverApi::CU_LIMIT_STACK_SIZE))
    assert_equal(:success, Cuda::DriverApi.cuCtxSetLimit(Cuda::DriverApi::CU_LIMIT_STACK_SIZE, p_value.read(:uint)))
  end

  def test_cu_ctx_get_set_shared_mem_config
    p_config = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuCtxGetSharedMemConfig(p_config))
    refute_equal(0, p_config.read(:int))

    assert_equal(:success, Cuda::DriverApi.cuCtxSetSharedMemConfig(p_config.read(:int)))
  end

  def test_cu_ctx_get_stream_priority_range
    least_priority = FFI::MemoryPointer.new(:int, 1)
    greatest_priority = FFI::MemoryPointer.new(:int, 1)
    assert_equal(:success, Cuda::DriverApi.cuCtxGetStreamPriorityRange(least_priority, greatest_priority))
  end

  def test_cu_ctx_pop_push_current
    p_ctx = FFI::MemoryPointer.new :pointer
    assert_equal(:success, Cuda::DriverApi.cuCtxPopCurrent_v2(p_ctx))
    assert_equal(:success, Cuda::DriverApi.cuCtxPushCurrent_v2(p_ctx.read_pointer))
  end

  def test_cu_ctx_reset_persisting_L2_cache
    assert_equal(:success, Cuda::DriverApi.cuCtxResetPersistingL2Cache())
  end

  def test_cu_ctx_synchronize
    assert_equal(:success, Cuda::DriverApi.cuCtxSynchronize())
  end
end
