require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
    @company = Company.new(name: "Test company", zip_code: "94105")
  end

  test "should not save company when email invalid" do
    @company.email = "test@test.com"
    assert_not @company.save

    @company.email = "test%$@getmainstreet.com"
    assert_not @company.save
  end

  test "should save company when email is vaild" do
    @company.email = "test@getmainstreet.com"
    assert @company.save

    @company.email = "test.+_-@getmainstreet.com"
    assert @company.save
  end

  test "email should be unique" do
    @company.email = "test@getmainstreet.com"
    @company.save

    new_company = Company.new(name: "Test company", zip_code: "94105", email: "test@getmainstreet.com")

    assert_not new_company.save
  end

  test "should allow blank email" do
    @company.email = ""
    assert @company.save
  end

  test "must be valid zip code" do
    @company.zip_code = nil
    assert_not @company.save
    
    @company.zip_code = "abc"
    assert_not @company.save

    @company.zip_code = "1234"
    assert_not @company.save

    @company.zip_code = "123456"
    assert_not @company.save

    @company.zip_code = "93003"
    assert @company.save
  end

  test "should create city and state" do
    @company.save
    assert_not_nil @company.city
    assert_not_nil @company.state
  end

  test "should city and state change when zip changed" do
    @company.save
    old_city = @company.city
    old_state = @company.state

    @company.zip_code = "93003"
    @company.save

    assert_not_equal  old_city, @company.city
    assert_not_equal  old_state, @company.city
  end

end
