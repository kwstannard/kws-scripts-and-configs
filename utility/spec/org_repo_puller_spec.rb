require_relative '../lib/org_repo_puller'

describe OrgRepoPuller do
  describe '.call' do
    let(:io) { IO.pipe }
    let(:read_io) { io.first }
    let(:write_io) { io.last }
    let(:run) {
      write_io.puts('lendkey')
      OrgRepoPuller.call(read_io, $stdout)
      read_io.close
      write_io.close
    }
    let(:external_response) {
      [{
        name: 'repo_1',
        ssh_url: 'git@derp.com'
      }].to_json
    }

    it 'loads lendkey repos' do
      expect($stdout).to receive(:print).with('org name: ')
      expect($stdout).to receive(:puts).with('getting repos for lendkey')
      expect($stdout).to receive(:puts).with('edulink')
      expect($stdout).to receive(:puts).with(/base.*dir/)
      run
    end
  end
end
