class DatasetPresenter
  
  def initialize(dataset)
    @dataset = dataset
  end
  
  def present
    presented = {
      "title" => @dataset.title,
      "slug" => @dataset.slug,
      "description" => @dataset.description,
      "total_observations" => @dataset.observations.count,
      "release" => ReleasePresenter.new( @dataset.release ).present
    }
  end
end