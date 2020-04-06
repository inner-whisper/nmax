# frozen_string_literal: true

RSpec.shared_context 'with suppressed stderr and stdout' do
  let!(:original_stdout) { $stdout }
  let!(:original_stderr) { $stderr }

  before do
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  after do
    $stdout = original_stdout
    $stderr = original_stderr
  end
end
