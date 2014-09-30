require 'test_helper'

class ItemRatingsControllerTest < ActionController::TestCase
  setup do
    @item_rating = item_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_rating" do
    assert_difference('ItemRating.count') do
      post :create, item_rating: { default: @item_rating.default, item_id: @item_rating.item_id, liked: @item_rating.liked, true: @item_rating.true, user_id: @item_rating.user_id }
    end

    assert_redirected_to item_rating_path(assigns(:item_rating))
  end

  test "should show item_rating" do
    get :show, id: @item_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_rating
    assert_response :success
  end

  test "should update item_rating" do
    patch :update, id: @item_rating, item_rating: { default: @item_rating.default, item_id: @item_rating.item_id, liked: @item_rating.liked, true: @item_rating.true, user_id: @item_rating.user_id }
    assert_redirected_to item_rating_path(assigns(:item_rating))
  end

  test "should destroy item_rating" do
    assert_difference('ItemRating.count', -1) do
      delete :destroy, id: @item_rating
    end

    assert_redirected_to item_ratings_path
  end
end
