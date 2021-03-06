# frozen_string_literal: true

require_relative 'lib/cuda/version'

Gem::Specification.new do |spec|
  spec.name          = 'cuda'
  spec.version       = Cuda::VERSION
  spec.authors       = ['Dr. Samuel Goebert', 'Abrar']
  spec.email         = ['samuel.goebert@bigcurl.de', 's96mini.cube@gmail.com']

  spec.summary       = 'FFI wrapper for the NVIDIA Cuda Toolkit'
  spec.homepage      = 'https://github.com/bigcurl/ffi-cuda-toolkit-gem-generator'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ffi', '~> 1.15.4'
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
