class ObservationPresenter
  
  def initialize(observation)
    @observation = observation
  end
  
  def present
    presented = {
      "measure" => @observation.measure,
    }
    presented.merge(display_dimensions)
  end

  def display_dimensions
    presented = {}
    @observation.dataset.structure.each_pair do |dimension_id, concept_scheme_id|
      dimension_name = Dimension.find(dimension_id).name
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      display_value = concept_scheme.values[@observation.send(dimension_name)]
      presented[dimension_name] = display_value
    end
    presented
  end

end