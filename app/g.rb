#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'clamp'

require 'ox'
require 'typhoeus'

require 'byebug'

# require all model files
base_path = File.join(__dir__, '../')
Dir[File.join(base_path, 'app/**/*', '*application_*.rb')].sort.each { |file| require file }
Dir[File.join(base_path, 'app/**/*', '*.rb')].sort.each { |file| require file }

Clamp do
  option '--version', :flag, 'Show version' do
    puts '0.0.1'
    exit(0)
  end

  subcommand 'generate', 'Generator subcommand' do
    subcommand 'gem', 'Generates the gem', GenerateGem
  end
end
