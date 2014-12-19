require_relative File.expand_path('../../last_commit_getter', __FILE__)
require_relative File.expand_path('../../repository', __FILE__)
require_relative File.expand_path('../helpers/test_dir_helper', __FILE__)
require_relative File.expand_path('../helpers/mock_ci', __FILE__)
require 'ostruct'

describe LastCommitGetter do
  let(:getter) { described_class.new(ci_project_info, @project, logger) }
  let(:logger) { OpenStruct.new(klass: 'Logger') }

  describe '#call' do
    subject(:commit) { getter.call }
    let(:projects) { [ci_project_info] }
    let(:ci_project_info) { CIProjectsInfo.new(@project) }

    context 'there is a local project' do
      before do
        @test_dir = TestDirHelper.new('last_commit_getter').setup
        @project = @test_dir.add_project('foo')
      end

      after do
        @test_dir.teardown
      end

      context 'there is no passing commit' do
        it "logs there is no passing commit" do
          expect(logger).to receive(:log).with(/no passing commits.*#{@project.name}/i)
          expect{commit}.to raise_error LastCommitGetter::Error
        end
      end

      context 'there is no dev branch' do
        it "logs there is no passing commit" do
          @project.git.branch('master').checkout
          @project.git.branch('dev').delete
          expect(logger).to receive(:log).with(/no dev branch.*#{@project.name}/i)
          expect{commit}.to raise_error LastCommitGetter::Error
        end
      end

      context 'the last passing commit is the latest dev commit' do
        before do
          @commit_sha = @project.repository.last_commit('dev').sha
          ci_project_info.projects.first.get_branch('dev').set_last_good_build @commit_sha
        end

        it 'returns the dev commit' do
          expect(commit).to eq @commit_sha
        end
      end

      context 'the last passing commit is 2 back from dev' do
        before do
          @commit_sha = @project.repository.last_commit('dev').sha
          @project.make_commits(2)
          ci_project_info.projects.first.get_branch('dev').set_last_good_build @commit_sha
        end

        it 'returns the dev commit' do
          expect(commit).to eq @commit_sha
        end
      end
    end

    context 'there is no matching project for the repo' do
      let(:ci_project_info) { CIProjectsInfo.new }
      before { @project = OpenStruct.new(name: 'notInCI') }
      it "logs there was no project" do
        expect(logger).to receive(:log).with(/no project named #{@project.name} found in ci/i)
        expect{commit}.to raise_error LastCommitGetter::Error
      end
    end
  end
end
