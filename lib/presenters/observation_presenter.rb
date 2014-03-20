class ObservationPresenter
  
  def initialize(observation)
    @observation = observation
  end
  
  def present
    {
      "measure" => @observation.measure, 
      "date" => @observation.date,
      "cdid" => @observation.cdid
    }
  end
  
end