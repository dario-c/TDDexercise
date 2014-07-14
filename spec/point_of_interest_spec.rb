require_relative "../test.rb"

describe "POI test suite" do
  before :each do
    POI.clean
  end

	describe "adding a POI" do
		it "creates an object with name Sagrada Familia, description to be 'Church'" do
			p = POI.new("Sagrada Familia" , "Church", "monument", 4)
			expect(p.name).to eq("Sagrada Familia")
			expect(p.description).to eq("Church")
		end
	end

	describe "Filter by" do
		it "category (monument) should return 2 objects" do
			POI.new("Sagrada Familia", "Church", "monument", 4)
			POI.new("Colon", "Statue", "monument", 3)
			POI.new("Parc Guell", "Big Park", "park", 5)
			expect(POI.filter_by_category('monument').length).to eq(2)
		end
	end

	describe "sorts by" do
		it "by name" do
			p = POI.new("Sagrada Familia", "Church", "monument", 4)
			p2 = POI.new("Colon", "Statue", "monument", 3)
			p3 = POI.new("Parc Guell", "Big Park", "park", 5)

			expect(POI.sort_by_name).to eq([p2,p3,p])
		end
	end

  describe "Histograms" do
    it "is empty histogram when there are no POIs" do
      expect(Histogram.new.for([])).to eq({})
    end
    it "when one POI, Histogram score is the same as POI score" do
      poi = POI.new("XYZ", "description", "monument", 5)
      expect(Histogram.new.for([poi])).to eq({5 => 1})
    end
    it "When two POI with the same score, the score count should be 2" do
      poi1 = POI.new("ABC", "description", "monument", 5)
      poi2 = POI.new("XYZ", "description", "monument", 5)
      expect(Histogram.new.for(POI.all)).to eq({5 => 2})
    end

    it "When more than one POI with the different scores, count how many POIs are passed for each score" do
      poi3 = POI.new("ABC", "description", "monument", 5)
      poi4 = POI.new("XYZ", "description", "monument", 5)
      poi5 = POI.new("ABC", "description", "monument", 4)
      poi6 = POI.new("XYZ", "description", "monument", 3)
      poi7 = POI.new("ABC", "description", "monument", 3)
      poi8 = POI.new("XYZ", "description", "monument", 1)
      expect(Histogram.new.for(POI.all)).to eq({5 => 2, 4 => 1, 3 =>2, 1 => 1})
    end
  end

end