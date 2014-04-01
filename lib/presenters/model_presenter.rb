class ModelPresenter
  
  def initialize(model)
    @model = model
  end
  
  def present
    default
  end
  
  def default
    return {} unless @model
    presented = {
      "url"  => ModelPresenter.url_for(@model),
      "title" => @model.title,
      "description" => @model.description,
      "slug" => @model.slug
    }
    if @model.respond_to?(:published)
      presented["published"] = @model.published.xmlschema
    end
    presented
  end
  
  def self.url_for(model)
    case model.class
    when Series
      "/series/#{model.slug}"
    when Release
      "#{ModelPresenter.url_for( model.series )}/releases/#{model.slug}"
    when Dataset
      "#{ModelPresenter.url_for( model.release )}/datasets/#{model.slug}"
    when Observation
      "#{ModelPresenter.url_for( model.dataset )}/observations/#{model.slug}"
    else
      model.slug
    end
  end
  
end