class DatasetPresenter < ModelPresenter
  
  def present
    presented = default
    release = @model.release
    presented.merge!({
      "total_observations" => @model.observations.count,
      "release" => ModelPresenter.new( release ).present,
      "dimensions" => display_dimensions,
      "data_attributes" => display_attributes,
      "measures" => display_measures
    })
  end

  def display_dimensions
    presented = {}
    @model.dimensions.each_pair do |dimension_id, concept_scheme_id|
      dimension = Dimension.find(dimension_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      presented[dimension.name] = {
          'title' => dimension.title,
          'description' => dimension.description #,
          #'values' => concept_scheme.values
      }
    end
    presented
  end
  
  def display_attributes
    presented = {}
    return {} unless @model.data_attributes
    @model.data_attributes.each_pair do |attr_id, concept_scheme_id|
      attribute = DataAttribute.find(attr_id)
      concept_scheme = ConceptScheme.find(concept_scheme_id)
      presented[attribute.name] = {
            'title' => attribute.title,
            'description' => attribute.description#,
            #'values' => concept_scheme.values
        }
    end
    presented
  end

  def display_measures
    presented = []
    return {} unless @model.measures
    @model.measures.each do |measure_id|
      measure = Measure.find(measure_id)
      presented << {
          'title' => measure.title,
          'description' => measure.description,
          'slug' => measure.slug
      }
    end

    presented
  end    
end