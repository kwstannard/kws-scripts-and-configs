require __FILE__.gsub('_spec.rb', '.rb')

describe CorrespondingFileOpenner do
  subject(:openner) { described_class.new(vim_mock) }

  let(:vim_mock) do
    double commander: commander,
      window: window
  end

  let(:buffer) {double name: file}
  let(:commander) {double}
  let(:window) {double buffer: buffer, width: 80}

  describe '#open' do

#    let(:dir) { Pathname('/tmp/comp/') }
#    around do |ex|
#      dir.mkdir
#      Dir.chdir(dir) do
#        ex.run
#      end
#      dir.rmtree
#    end

    context 'when buffer is spec/models/foo_spec.rb' do
      let(:file) { '/home/spec/models/foo_spec.rb' }

      context 'when there is a corresponding file in app' do
        it 'splits to app/models/foo.rb' do
          expect(commander).to receive(:command).with(":split /home/app/models/foo.rb")
          openner.open
        end
      end

      context 'when there is a corresponding file in lib' do
        it 'splits to lib/models/foo.rb' do
          allow(File).to receive(:exists?).with('/home/lib/models/foo.rb')
          expect(commander).to receive(:command).with(":split /home/lib/models/foo.rb")
          openner.open
        end
      end

      context 'when there is not a corresponding file in app' do
        it 'splits to spec/models/foo.rb' do
          expect(commander).to receive(:command).with(":split /home/app/models/foo.rb")
          openner.open
        end
      end
    end

    context 'when buffer is app/models/foo.rb' do
      let(:file) { '/home/app/models/foo.rb' }

      context 'when there is a file' do
        it 'splits to spec/models/foo_spec.rb' do
          expect(commander).to receive(:command).with(":split /home/spec/models/foo_spec.rb")
          openner.open
        end
      end

      context 'when there is not a file' do
        it 'splits to spec/models/foo_spec.rb' do
          expect(commander).to receive(:command).with(":split /home/spec/models/foo_spec.rb")
          openner.open
        end
      end
    end
  end
end
