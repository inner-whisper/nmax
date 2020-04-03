# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  let(:test_script_path) { 'spec/features/files/cli_test' }

  before do
    run_command test_script_path
  end

  it 'returns numbers from file' do
    output = "4251241\n2534342\n52323"

    expect(last_command_started).to be_successfully_executed
    expect(last_command_started).to have_output output
  end

  context 'when N parameter is not passed' do
    let(:test_script_path) { 'spec/features/files/cli_test_error' }

    it 'returns error code and error message' do
      output = 'В скрипт должен быть передан атрибут N.'

      expect(last_command_started).to have_exit_status(1)
      expect(last_command_started).to have_output output
    end
  end
end
