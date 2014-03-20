class SeriesPresenter
  
  def initialize(series)
    @series = series
  end
  
  def present
    presented = {
      "title" => @series.title,
      "description" => @series.description
    }
  end
end