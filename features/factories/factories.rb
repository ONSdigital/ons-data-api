FactoryGirl.define do
  factory :series do
    sequence(:slug) { |s| "an-series-#{s}" }
    title "A series"
    description "A description of this series"
  end

  factory :release do
    sequence(:slug) { |s| "a-release-#{s}" }
    series = FactoryGirl.create(:series)  
    title "A release"
    state "published"
    published "2014-04-01"
    description "A description of this release"
  end
  
  factory :dataset do
    sequence(:slug) { |s| "an-dataset-#{s}" }
    after(:build) do |dataset|
      measure = FactoryGirl.create(:measure)
      measure_concept_scheme = FactoryGirl.create(:measure_concept_scheme)
      dimension = FactoryGirl.create(:dimension)
      product_dimension = FactoryGirl.create(:product_dimension)
      concept_scheme = FactoryGirl.create(:concept_scheme)
      cdid_concept_scheme = FactoryGirl.create(:cdid_concept_scheme)
      dataset.dimensions = {dimension.id => concept_scheme.id, product_dimension.id => cdid_concept_scheme.id}
      dataset.data_attributes = { }
      dataset.measures = {measure.id => measure_concept_scheme.id}
      release = FactoryGirl.create(:release)
    end
  end

  factory :measure do
    sequence(:slug) { |s| "an-measure-#{s}" }
    name "price_index"
    title "Price Index"
    description "A value based on a series of economic indicators and toads."
  end

  factory :measure_concept_scheme, class: ConceptScheme do
    sequence(:slug) { |s| "an-measure-concept-scheme-#{s}" }
    title "Units of Measure"
    values {{"price_index" => {
        "title" => "Price Index"
        }
      }}
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