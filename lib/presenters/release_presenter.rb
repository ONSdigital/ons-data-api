class ReleasePresenter < ModelPresenter
  
  def present
    return {} unless @model
    presented = default
    presented.merge!({
      "notes" => @model.notes,
      "comments" => @model.comments,
      "state" => @model.state,
      "series" => ModelPresenter.new( @model.series ).present
    })
    presented["contact"] = ContactPresenter.new( @model.contact ).present if @model.contact
    presented["datasets"] = []
    @model.datasets.each do |d|
      presented["datasets"] << ModelPresenter.new(d).present
    end
    presented
  end
end