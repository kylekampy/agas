require 'test_helper'

class MedicalStaffControllerTest < ActionController::TestCase
  test "should get firstname:string" do
    get :firstname:string
    assert_response :success
  end

  test "should get middlename:string" do
    get :middlename:string
    assert_response :success
  end

  test "should get lastname:string" do
    get :lastname:string
    assert_response :success
  end

  test "should get doc_id:integer" do
    get :doc_id:integer
    assert_response :success
  end

end
