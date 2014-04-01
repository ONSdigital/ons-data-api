class ObservationPresenter < ModelPresenter
  
  def present
    #remove mongo keys
    presented = @model.attributes.reject { |x| x == "_id" || x == "dataset_id"}
    presented['url'] = ModelPresenter.url_for(@model)
    presented['dimensions'] = display_dimensions
    presented['data_attributes'] = display_attributes
    presented['measures'] = display_measures
    presented['dataset'] = ModelPresenter.new(@model.dataset).present
    presented
  end

  def display_dimensions
    presented = {}
    @model.dataset.dimensions.each_pair do |dimension_id, concept_scheme_id|
      dimension = Dimension.find(dimension_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      display_value = concept_scheme.values[@model.send(dimension.name)]
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
    return {} unless @model.dataset.data_attributes
    @model.dataset.data_attributes.each_pair do |attr_id, concept_scheme_id|
      attribute = DataAttribute.find(attr_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      if @model.respond_to?(attribute.name)
        display_value = concept_scheme.values[@model.send(attribute.name)]
        presented[attribute.name] = {
            'title' => attribute.title,
            'description' => attribute.description,
            'value' => display_value
        }
      end
    end
    presented
  end

  def display_measures
    presented = []
    return {} unless @model.dataset.measures
    @model.dataset.measures.each do |measure_id|
      measure = Measure.find(measure_id)
      if @model.respond_to?(measure.name)
        presented << {
            'title' => measure.title,
            'description' => measure.description,
            'slug' => measure.slug
        }
      end
    end

    presented
  end
  
end