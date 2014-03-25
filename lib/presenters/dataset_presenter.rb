class DatasetPresenter
  
  def initialize(dataset)
    @dataset = dataset
  end
  
  def present
    presented = {
      "title" => @dataset.title,
      "slug" => @dataset.slug,
      "description" => @dataset.description,
      "release" => ReleasePresenter.new( @dataset.release ).present
    }
  end
end