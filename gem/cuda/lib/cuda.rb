# frozen_string_literal: true

require "ffi"

# Version
require_relative "cuda/version"

# Driver API

# check if lib is available

binary_list = `whereis -b libcuda`.strip.split("libcuda: ")
binary_path = "/usr/lib/x86_64-linux-gnu/libcuda.so"
binary_path = binary_list[1] unless binary_list[1].nil?
unless File.exist? binary_path
  puts "Could not open library '<%= binary_path %>'"
  puts "Install the Cuda Toolkit first."
  exit(-1)
end

require_relative "cuda/driver/wrapper"
