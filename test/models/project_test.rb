require "test_helper"

class ProjectTest < ActiveSupport::TestCase

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
    project.client_id = clients(:ecorp).id

    assert project.valid?
  end
end