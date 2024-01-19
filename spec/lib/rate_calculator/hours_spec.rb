require 'rails_helper'
require 'rate_calculator'
require 'rate_calculator/hours'

describe 'Hours' do
  let(:hours) {Hours.new(hours_info)}

  it 'calculates billable per cent' do
    billable_percent = hours.billable_percent

    expected_billable_percent = 80
    expect(billable_percent).to eq(expected_billable_percent)
  end

  it 'calculates total billable hours per year' do

    hours_per_year = hours.hours_per_year

    expected_hours_year = 1070.4
    expect(hours_per_year).to eq(expected_hours_year)
  end


  def hours_info
    {
      "hours_day"=>"6",
      "non_billable"=>"20",
      "days_week"=>"5",
      "holidays"=>"25",
      "training"=>"6",
      "sick"=>"6"
    }
  end
end