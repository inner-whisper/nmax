# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  before do
    run_command 'spec/features/files/cli_test'
  end

  it 'returns numbers from file' do
    # output = "123\n4251241\n1223\n52323\n2534342"
    output = "4251241\n2534342"

    expect(last_command_started).to have_output output
  end
end
