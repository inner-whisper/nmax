# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  before do
    run_command 'spec/features/files/cli_test'
  end

  it 'returns content of file' do
    output =
      "If my honey comes back, sometime\nI'm gonna rap that jack, sometimes"

    expect(last_command_started).to have_output output
  end
end
