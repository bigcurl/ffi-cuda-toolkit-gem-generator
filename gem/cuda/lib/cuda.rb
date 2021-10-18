# frozen_string_literal: true

require "ffi"

# Version
require_relative "cuda/version"

# Driver API

# check if lib is available
unless File.exist? "/usr/lib/x86_64-linux-gnu/libcuda.so"
  puts "Could not open library '/usr/lib/x86_64-linux-gnu/libcuda.so'"
  puts "Install the Cuda Toolkit first."
  exit(-1)
end

# Enums
require_relative "cuda/driver/enums/enums"

# Functions
require_relative "cuda/driver/functions/context_management_deprecated"
require_relative "cuda/driver/functions/context_management"
require_relative "cuda/driver/functions/device_management_deprecated"
require_relative "cuda/driver/functions/device_management"
require_relative "cuda/driver/functions/driver_entry_point_access"
require_relative "cuda/driver/functions/egl_interoperability"
require_relative "cuda/driver/functions/error_handling"
require_relative "cuda/driver/functions/event_management"
require_relative "cuda/driver/functions/execution_control_deprecated"
require_relative "cuda/driver/functions/execution_control"
require_relative "cuda/driver/functions/external_resource_interoperability"
require_relative "cuda/driver/functions/graphics_interoperability"
require_relative "cuda/driver/functions/graph_management"
require_relative "cuda/driver/functions/initialization"
require_relative "cuda/driver/functions/memory_management"
require_relative "cuda/driver/functions/module_management"
require_relative "cuda/driver/functions/occupancy"
require_relative "cuda/driver/functions/opengl_interoperability_deprecated"
require_relative "cuda/driver/functions/opengl_interoperability"
require_relative "cuda/driver/functions/peer_context_memory_access"
require_relative "cuda/driver/functions/primary_context_management"
require_relative "cuda/driver/functions/profiler_control_deprecated"
require_relative "cuda/driver/functions/profiler_control"
require_relative "cuda/driver/functions/stream_management"
require_relative "cuda/driver/functions/stream_memory_operations"
require_relative "cuda/driver/functions/stream_ordered_memory_allocator"
require_relative "cuda/driver/functions/surface_object_management"
require_relative "cuda/driver/functions/surface_reference_management_deprecated"
require_relative "cuda/driver/functions/texture_object_management"
require_relative "cuda/driver/functions/texture_reference_management_deprecated"
require_relative "cuda/driver/functions/unified_addressing"
require_relative "cuda/driver/functions/vdpau_interoperability"
require_relative "cuda/driver/functions/version_management"
require_relative "cuda/driver/functions/virtual_memory_management"

module Cuda
  class Error < StandardError; end
  # Your code goes here...
end
