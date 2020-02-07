# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  before do
    run_command 'spec/features/files/cli_test'
  end

  it { expect(last_command_started).to have_output 'Hey, honey!' }
end
