class ReleasePresenter
  
  def initialize(release)
    @release = release
  end
  
  def present
    return {} unless @release
    presented = {
      "title" => @release.title,
      "slug" => @release.slug,
      "description" => @release.description,
      "published" => @release.published,
      "notes" => @release.notes,
      "comments" => @release.comments,
      "state" => @release.state,
      "series" => SeriesPresenter.new( @release.series ).present
    }
    presented["contact"] = ContactPresenter.new( @release.contact ).present if @release.contact
    presented
  end
end