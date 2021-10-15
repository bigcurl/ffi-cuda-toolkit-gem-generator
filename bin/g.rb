#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'clamp'

require 'nokogiri'
require 'typhoeus'

require 'byebug'

require 'fileutils'
require 'erubi'
require 'ostruct'
require 'lucky_case/string'

# require all model files
base_path = File.join(__dir__, '../')
Dir[File.join(base_path, 'lib/**/*', '*application_*.rb')].sort.each { |file| require file }
Dir[File.join(base_path, 'lib/**/*', '*.rb')].sort.each { |file| require file }

Clamp do
  option '--version', :flag, 'Show version' do
    puts '11.4.2.0'
    exit(0)
  end

  subcommand 'generate', 'Generator subcommand' do
    subcommand 'driver-api', 'Generates the driver api', GenerateDriverApi
  end
end