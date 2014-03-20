class ObservationPresenter
  
  def initialize(observation)
    @observation = observation
  end
  
  def present
    {
      "measure" => @observation.measure
    }
  end
  
end