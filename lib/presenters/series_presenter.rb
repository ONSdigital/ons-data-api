class SeriesPresenter < ModelPresenter
  
  def present
    presented = default
    presented["contact"] = ContactPresenter.new( @model.contact ).present if @model.contact
    presented["releases"] = []
    @model.releases.where(:state=>"released").order_by(:slug.asc).each do |release|
      presented["releases"] << ModelPresenter.new( release ).present
    end
    latest_release = @model.releases.where(:state=>"released").order_by(:slug.desc).first
    presented["latest_release"] = ModelPresenter.new( latest_release ).present
    next_release = @model.releases.where(:state=>"scheduled").order_by(:slug.desc).first
    presented["next_release"] = ModelPresenter.new( next_release ).present

    presented
  end
end