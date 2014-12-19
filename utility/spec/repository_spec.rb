require File.expand_path('../../repository', __FILE__)
require File.expand_path('../helpers/test_dir_helper.rb', __FILE__)

describe Repository do
  before do
    @test_dir = TestDirHelper.new('release_generator').setup
  end
  after { @test_dir.teardown }

  let(:repo) { described_class.new(project.path, []) }
  let(:project) { @test_dir.add_project(project_name) }
  let(:project_name) { "project1" }

  describe "#name" do
    subject { repo.name }
    it { should eq(project_name) }
  end
  
  describe "#deployable?" do
    subject { repo.deployable? }

    context "there is a Capfile" do
      before { project.write_file "Capfile" }
      it {should eq true}
    end

    context "there is not a cap file" do
      it { should eq false }
    end
  end

  describe "#tickets_between" do
    it "returns all tickets with merged branches in dev" do
      tickets = ['FY-12', 'FY-2345', 'FY-09865431']
      project.merge_tickets *tickets
      repo.tickets_between('master', 'dev').should match_array(tickets)
    end
  end

  describe "#last_release" do
    subject(:last_release) { repo.last_release }
    it "returns the lastest release branch on remote" do
      context "no release branches" do
        it "returns a null release" do
          expect(last_release).to be_a(UnexistantRelease)
        end
      end
    end
  end
end
