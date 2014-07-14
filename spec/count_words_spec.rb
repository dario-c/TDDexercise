#require_relative "../word-cloud/generate.rb"

describe "Counting Description words test suite" do
  before :each do
    POI.clean
  end

  describe "when no POIs" do
    it "no POIs => no words rendered" do
      expect(Wordcloud.new.for([])).to eq({})
    end
  end

end