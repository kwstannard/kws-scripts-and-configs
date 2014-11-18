require 'rspec'
require_relative 'find_and_replace'

describe FindAndReplacePath do
  subject(:replacer) { described_class.new(find_pattern, replace_pattern) }
  before do
    @here = Dir.pwd
    @there = '/tmp/find_and_replace_test_dir'
    @file = "#{@there}/file.rb"

    Dir.mkdir @there
    Dir.chdir @there
  end

  after do
    `rm -r #{@there}`
    Dir.chdir @here
  end

  describe '#call' do
    context 'when replacing foo' do
      let(:find_pattern) { 'foo' }

      context 'with bar' do
        let(:replace_pattern) { 'bar' }

        it 'foobar.rb becomes barbar.rb' do
          file = "#{@there}/foobar.rb"
          expected_file = "#{@there}/barbar.rb"
          File.open(file, 'w+') do |f|
            f.write 'hello world'
          end
          replacer.call
          expect(File.exist?(file)).to eq false
          expect(File.exist?(expected_file)).to eq true
        end
      end
    end
  end
end

describe FindAndReplaceText do
  before do
    @here = Dir.pwd
    @there = '/tmp/find_and_replace_test_dir'
    @file = "#{@there}/file.rb"

    Dir.mkdir @there
    Dir.chdir @there

    File.open(@file, 'w+') do |f|
      f.write 'hello world'
    end
  end

  after do
    `rm -r #{@there}`
    Dir.chdir @here
  end

  describe "#call" do
    context "search string is 'hello'" do
      let(:find_str) { 'hello' }

      context "replace string is 'goodbye'"do
        let(:replace_str) { 'goodbye' }

        context "setting the file pattern" do
          let(:file_pattern) { "*.foo" }
          before do
            File.open("#{@there}/file_2.foo", 'w+') do |f|
              f.write 'hello world'
            end
          end

          it 'changes only the specified files' do
            described_class.new(find_str, replace_str, file_pattern).call
            expect(File.read("#{@there}/file_2.foo")).to eq 'goodbye world'
            expect(File.read("#{@there}/file.rb")).to eq 'hello world'
          end
        end

        context "multiple files" do
          before do
            File.open("#{@there}/file_2.rb", 'w+') do |f|
              f.write 'hello world'
            end
          end

          it "changes all files to read 'goodbye world'" do
            described_class.new(find_str, replace_str).call
            Dir.glob("#{@there}/*") do |file|
              expect(File.read(file)).to eq 'goodbye world'
            end
          end
        end

        context "multiple directories" do
          before do
            Dir.mkdir "#{@there}/dir"
            File.open("#{@there}/dir/file_2.rb", 'w+') do |f|
              f.write 'hello world'
            end
          end

          it "changes all files to read 'goodbye world'" do
            described_class.new(find_str, replace_str).call
            Dir.glob("#{@there}/**/*.rb") do |file|
              expect(File.read(file)).to eq 'goodbye world'
            end
          end
        end
      end
    end
  end
end
