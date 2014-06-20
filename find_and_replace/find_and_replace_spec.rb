require 'rspec'
require_relative 'find_and_replace'

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

        context "multiple files" do
          before do
            File.open("#{@there}/file_2.rb", 'w+') do |f|
              f.write 'hello world'
            end
          end

          it "changes all files to read 'goodbye world'" do
            described_class.new(find_str, replace_str).call
            Dir.glob("#{@there}/*") do |file|
              File.read(file).should eq 'goodbye world'
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
              File.read(file).should eq 'goodbye world'
            end
          end
        end
      end
    end
  end
end
