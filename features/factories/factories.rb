FactoryGirl.define do
  factory :series do
    sequence(:slug) { |s| "an-series-#{s}" }
    title "A series"
    description "A description of this series"
  end

  factory :dataset do
    sequence(:slug) { |s| "an-dataset-#{s}" }
    after(:build) do |dataset|
      dimension = FactoryGirl.create(:dimension)
      product_dimension = FactoryGirl.create(:product_dimension)
      concept_scheme = FactoryGirl.create(:concept_scheme)
      cdid_concept_scheme = FactoryGirl.create(:cdid_concept_scheme)
      dataset.dimensions = {dimension.id => concept_scheme.id, product_dimension.id => cdid_concept_scheme.id}
      dataset.data_attributes = { }
      FactoryGirl.create(:measure, {dataset: dataset})
    end
  end

  factory :measure do
    sequence(:slug) { |s| "an-measure-#{s}" }
    name "price_index"
    title "Price Index"
    description "A value based on a series of economic indicators and toads."
  end
  
  factory :dimension do
    sequence(:slug) { |s| "an-dimension-#{s}" }
    name "date"
    title "An Date"
    dimension_type "stellar"

    factory :product_dimension do
      name "cdid"
      title "Product"
    end
  end


  factory :concept_scheme do
    sequence(:slug) { |s| "an-uk-concept-scheme-#{s}" }
    title "Dates"
    values "2013-12" => "December 2013"

    factory :cdid_concept_scheme do
      title "Price Index Products"
      values "mc6a" => "Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu incl duty"
    end
  end

  factory :observation do
    sequence(:slug) { |s| "a-observation-#{s}"}
    dataset
    price_index 60.5
    date "2013-12"
    cdid "mc6a"
  end
end