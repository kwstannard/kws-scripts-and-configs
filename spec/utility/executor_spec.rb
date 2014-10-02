require 'rspec-advanced_subject'
require 'utility/executor'

describe Executor do
  let(:executor) { described_class.new(*init_args) }
  let(:init_args) { [logger, command] }
  let(:logger) { double(log: 'log') }
  describe '#call' do
    subject(:call) { executor.call }
    context 'when passed nothing' do
      let(:init_args) { }
      it { expect{call}.to raise_error }
    end

    context "when passed 'echo foo'" do
      let(:command) { "FOO=baz ruby -e 'puts ENV[\"FOO\"]'" }
      let(:search) { command.gsub(/[\[\]\/]/, '\\\\\0') }

      it 'sends the command to the logger' do
        expect(logger).to receive(:log).with(Regexp.new(search))
        call
      end

      it 'sends the result to the logger' do
        expect(logger).to receive(:log).with(/^baz$/)
        call
      end
    end

    context "when the command returns an error code" do
      let(:command) { "cat herblegurble" }

      it "raises and error" do
        expect{ call }.to raise_error
      end

      it "sends the command to the logger" do
        expect(logger).to receive(:log_error).with(/#{command}/)
        call rescue nil
      end

      it "sends the error to the logger" do
        expect(logger).to receive(:log_error).with(/cat: herblegurble: No such file or directory\n/)
        call rescue nil
      end
    end
  end
end
