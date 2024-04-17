require "test_helper"

class ProjectTest < ActiveSupport::TestCase

  setup do
    @ecorp = clients(:ecorp)
  end

  test "project attributes must not be empty" do
    project = Project.new

    assert project.invalid?
    assert project.errors[:name].any?
    assert project.errors[:hours_worked].any?
    assert project.errors[:amount_billed].any?
    assert project.errors[:start_date].any?
    assert project.errors[:end_date].any?
    assert project.errors[:client_id].any?
  end

  test "project attributes must be numeric" do
    project = Project.new

    project.hours_worked = 'abc'
    project.amount_billed = 'abc'

    assert project.invalid?
    assert_equal ["is not a number"], project.errors[:hours_worked]
    assert_equal ["is not a number"], project.errors[:amount_billed]
  end

  test "project attributes must be equal or greater than 0.5" do
    project = Project.new

    project.hours_worked = 0
    project.amount_billed = -7

    assert project.invalid?
    assert_equal ["must be greater than or equal to 0.5"], project.errors[:hours_worked]
    assert_equal ["must be greater than or equal to 0.5"], project.errors[:amount_billed]
  end

  test "validates a correct project" do
    project = Project.new

    project.name = "Logo design"
    project.hours_worked = 5.5
    project.amount_billed = 200
    project.start_date = start_date
    project.end_date = end_date
    project.client_id = @ecorp.id
    project.description = "Proposal for new logo with bolder colors"

    assert project.valid?
  end

  test "calculates and adds rate" do
    project = Project.create(client: @ecorp, name: "Website front-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 5000)

    assert_equal project.rate, 50
  end

  test "updates client stats after creating" do
    Project.create(client: @ecorp, name: "Website front-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 5000)

    @ecorp.reload
    assert_equal @ecorp.hours_worked, 100
    assert_equal @ecorp.amount_billed, 5000
    assert_equal @ecorp.rate, 50

    Project.create(client: @ecorp, name: "Website back-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 6000)
    
    @ecorp.reload
    assert_equal @ecorp.hours_worked, 200
    assert_equal @ecorp.amount_billed, 11000
    assert_equal @ecorp.rate, 55
  end

  test "updates client stats after update" do
    Project.create(client: @ecorp, name: "Website front-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 5000)
    second_project = Project.create(client: @ecorp, name: "Website back-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 6000)
    @ecorp.reload
    
    second_project.update(hours_worked: 150, amount_billed: 10500)
   
    assert_equal @ecorp.hours_worked, 250
    assert_equal @ecorp.amount_billed, 15500
    assert_equal @ecorp.rate, 62
  end

  test "updates client stats after destroy" do
    Project.create(client: @ecorp, name: "Website front-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 5000)
    second_project = Project.create(client: @ecorp, name: "Website back-end", hours_worked: 100, start_date: start_date, end_date: end_date, amount_billed: 6000)
    
    second_project.destroy
    
    assert_equal @ecorp.hours_worked, 100
    assert_equal @ecorp.amount_billed, 5000
    assert_equal @ecorp.rate, 50
  end

  def start_date
    Date.new(2024, 4, 15)
  end

  def end_date
    Date.new(2024, 4, 17)
  end
end