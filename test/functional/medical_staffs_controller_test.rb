require 'test_helper'

class MedicalStaffsControllerTest < ActionController::TestCase
  setup do
    @medical_staff = medical_staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medical_staff" do
    assert_difference('MedicalStaff.count') do
      post :create, :medical_staff => @medical_staff.attributes
    end

    assert_redirected_to medical_staff_path(assigns(:medical_staff))
  end

  test "should show medical_staff" do
    get :show, :id => @medical_staff.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @medical_staff.to_param
    assert_response :success
  end

  test "should update medical_staff" do
    put :update, :id => @medical_staff.to_param, :medical_staff => @medical_staff.attributes
    assert_redirected_to medical_staff_path(assigns(:medical_staff))
  end

  test "should destroy medical_staff" do
    assert_difference('MedicalStaff.count', -1) do
      delete :destroy, :id => @medical_staff.to_param
    end

    assert_redirected_to medical_staffs_path
  end
end
