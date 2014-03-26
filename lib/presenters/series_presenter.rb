class SeriesPresenter
  
  def initialize(series)
    @series = series
  end
  
  def present
    presented = {
      "title" => @series.title,
      "description" => @series.description,
    }
    presented["contact"] = ContactPresenter.new( @series.contact ).present if @series.contact
    presented
  end
end