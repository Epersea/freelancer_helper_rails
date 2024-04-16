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
    project.client_id = @ecorp.id
    project.description = "Proposal for new logo with bolder colors"

    assert project.valid?
  end

  test "updates client stats after creating" do
    project = Project.new

    project.name = "Website front-end"
    project.hours_worked = 100
    project.amount_billed = 5000
    project.client_id = @ecorp.id
    project.save

    client = Client.find_by(id: @ecorp.id)
    assert_equal client.hours_worked, 100
    assert_equal client.amount_billed, 5000
    assert_equal client.rate, 50

    project2 = Project.new

    project2.name = "Website back-end"
    project2.hours_worked = 100
    project2.amount_billed = 6000
    project2.client_id = @ecorp.id
    project2.save

    client = Client.find_by(id: @ecorp.id)
    assert_equal client.hours_worked, 200
    assert_equal client.amount_billed, 11000
    assert_equal client.rate, 55

  end
end