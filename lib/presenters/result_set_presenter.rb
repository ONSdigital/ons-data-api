require_relative 'observation_presenter'

class ResultSetPresenter
  
  def initialize(dataset, observations)
    @result_set = observations
    @dataset = dataset
  end

  def present
    presented = []
    @result_set.map do |result|
      presented << ObservationPresenter.new(result,false).present
    end
    presented
  end  
end

class ObservationResultPresenter < ModelPresenter
  
  
end
