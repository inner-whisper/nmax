# frozen_string_literal: true

RSpec.describe 'nmax CLI', type: :aruba do
  before do
    # example_path = '../../spec/features/files/example_data.txt'
    # run_command "cat #{example_path} | grep "Hey'"
    # run_command "cat #{example_path} | nmax 10000"
    run_command 'testish'
  end

  it { expect(last_command_started).to have_output 'Hey, honey!' }
end
