# frozen_string_literal: true

require 'bundler/setup'
require 'nmax'
require 'aruba/rspec'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus unless ENV['CI']

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Эта конфигурация раскидывает по всем example-ам тег `aggregate_failures`, что снимает
  # необходимость оборачивать код в него в явном виде
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end
