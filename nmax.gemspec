# frozen_string_literal: true

require_relative 'lib/nmax/version'

Gem::Specification.new do |spec|
  spec.name          = 'nmax'
  spec.version       = Nmax::VERSION
  spec.authors       = ['Maxim Rydkin']
  spec.email         = ['maks.rydkin@gmail.com']

  spec.summary       = 'Проект содержит скрипт, позволяющий извлечь N самых больших целых чисел из потока входных данных'
  spec.description   = spec.summary + "Подробности - на #{spec.homepage}"
  spec.homepage      = 'https://github.com/inner-whisper/nmax'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/inner-whisper/nmax/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['nmax'] # spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.0'

  # Testing
  spec.add_development_dependency 'aruba', '~> 0.14'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # Style Checking
  spec.add_development_dependency 'rubocop', '~> 0.79'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.37'

  # Debugging
  spec.add_development_dependency 'pry', '~> 0.13'
end
