# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  before do
    run_command 'nmax'
  end

  context 'returns output' do
    it { expect(last_command_started).to have_output 'Hello world' }
  end
end
