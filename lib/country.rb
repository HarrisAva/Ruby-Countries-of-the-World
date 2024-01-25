class Country
  attr_accessor :name, :capital, :population, :area

  @@all = [] # Class variable

  def initialize(name, capital, population, area)
    @name = name
    @capital = capital
    @population = population
    @area = area
    @@all << self # add country to the list of all countries
  end

  def self.all # return all countries
    @@all
  end
end