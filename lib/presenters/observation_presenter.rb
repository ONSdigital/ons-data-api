class ObservationPresenter
  
  def initialize(observation)
    @observation = observation
  end
  
  def present
    #remove mongo keys
    presented = @observation.attributes.reject { |x| x == "_id" || x == "dataset_id"}
    presented['dimensions'] = display_dimensions
    presented['attributes'] = display_attributes
    presented
  end

  def display_dimensions
    presented = {}
    @observation.dataset.dimensions.each_pair do |dimension_id, concept_scheme_id|
      dimension = Dimension.find(dimension_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      display_value = concept_scheme.values[@observation.send(dimension.name)]
      presented[dimension.name] = {
          'title' => dimension.title,
          'description' => dimension.description,
          'value' => display_value
      }
    end
    presented
  end
  
  def display_attributes
    presented = {}
    @observation.dataset.data_attributes.each_pair do |attr_id, concept_scheme_id|
      attribute = DataAttribute.find(attr_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      if @observation.respond_to?(attribute.name)
        display_value = concept_scheme.values[@observation.send(attribute.name)]
        presented[attribute.name] = {
            'title' => attribute.title,
            'value' => display_value
        }
      end
    end
    presented
  end

end