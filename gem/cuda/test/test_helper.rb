# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cuda'

require 'minitest/debugger' if ENV['DEBUG'] # run like "DEBUG=1 rake test"
require 'minitest/autorun'
