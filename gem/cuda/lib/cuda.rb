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

require_relative "cuda/driver/wrapper"