class ObservationPresenter
  
  def initialize(observation)
    @observation = observation
  end
  
  def present
    presented = {
      "measure" => @observation.measure,
    }
    presented['dimensions'] = display_dimensions
    presented
  end

  def display_dimensions
    presented = {}
    @observation.dataset.structure.each_pair do |dimension_id, concept_scheme_id|
      dimension = Dimension.find(dimension_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      display_value = concept_scheme.values[@observation.send(dimension.name)]
      presented[dimension.name] = {
          'title' => dimension.title,
          'value' => display_value
      }
    end
    presented
  end

end