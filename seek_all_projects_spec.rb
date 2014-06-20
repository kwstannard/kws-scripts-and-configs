describe "seek_all_projects" do
  context "looking for 'foo'" do
    it 'looks in all the projects' do
      self.should have_received("system").with("seek foo ~/Sites/gems/bucare")
    end
    context 'with args -i' do
      it 'looks in all projects with arg -i' do
        self.should have_received("system").with("seek foo -i ~/Sites/gems/bucare")
      end
    end
  end
end
