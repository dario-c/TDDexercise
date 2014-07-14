class POI
  attr_reader :name, :description, :category, :score
  @@POIs = []
  def initialize(name, description, category, score)
    @name = name
    @description = description
    @category = category
    @score = score
    @@POIs << self
  end

  def ==(other)
    self.class === other and
      other.name == @name and
      other.description == @description and
      other.category == @category and
      other.score == @score
  end

  alias eql? ==

  #def hash
  #  @name.hash ^ @description.hash ^ @category.hash ^ @category.score # XOR
  #end

  def self.filter_by_category(category)
  	@@POIs.select{|c| c.category == category}
  end

  def self.sort_by_name
  	@@POIs.sort { |p, n| p.name <=> n.name }
  end

  def self.clean()
  	@@POIs.clear
  end

  def self.all
  	@@POIs
  end
end

#POI1 = POI.new('sagrada', 'cool church', 'monument', '4')
#POI2 = POI.new('picasso', 'cool museum', 'museum', '1')

class Histogram
  def for(pois)
    if POI.all != []
      histogram = {}
      # count = 0
      pois.each {|item|
        if histogram == {}
          histogram = {item.score => 1}
        else
          newvalue = false
          histogram.each do |key, value|
            if item.score == key
              histogram[key] = value + 1
              newvalue = false
            else
              newvalue = true
            end
          end
          if newvalue == true
            histogram[item.score] = 1
          end
        end
        # histogram = {item.score => (count=count+1)}
      }
      histogram
    else
      histogram = {}
    end

  end
end
