require_relative 'observation_presenter'

class ResultSetPresenter
  
  def initialize(dataset, observations)
    @result_set = observations
    @dataset = dataset
  end

  def present
#    presented = {
#      "total" => @result_set.count
#    }
#    presented["dataset"] = DatasetPresenter.new(@dataset).present
#    presented["results"] = @result_set.map do |result|
#      ObservationPresenter.new(result).present
#    end
    presented = []
    @result_set.map do |result|
      presented << ObservationPresenter.new(result).present
    end
    presented
  end  
end
