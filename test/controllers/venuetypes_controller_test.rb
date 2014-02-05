require 'test_helper'

class VenuetypesControllerTest < ActionController::TestCase
  setup do
    @venuetype = venuetypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venuetypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venuetype" do
    assert_difference('Venuetype.count') do
      post :create, venuetype: { name: @venuetype.name, parenttypeid: @venuetype.parenttypeid }
    end

    assert_redirected_to venuetype_path(assigns(:venuetype))
  end

  test "should show venuetype" do
    get :show, id: @venuetype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venuetype
    assert_response :success
  end

  test "should update venuetype" do
    patch :update, id: @venuetype, venuetype: { name: @venuetype.name, parenttypeid: @venuetype.parenttypeid }
    assert_redirected_to venuetype_path(assigns(:venuetype))
  end

  test "should destroy venuetype" do
    assert_difference('Venuetype.count', -1) do
      delete :destroy, id: @venuetype
    end

    assert_redirected_to venuetypes_path
  end
end
