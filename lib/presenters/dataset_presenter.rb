class DatasetPresenter < ModelPresenter
  
  def present
    presented = default
    release = @model.release
    presented.merge!({
      "total_observations" => @model.observations.count,
      "release" => ModelPresenter.new( release ).present
    })
  end
  
end