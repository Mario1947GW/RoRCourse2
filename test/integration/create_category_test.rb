require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "admin", email: "admin@admin.com",
                              password: "password123", admin: true)
    sign_in_as(@admin_user)
  end

  test "get new category form and create category" do
    get new_category_path
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Muzyka"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Muzyka", response.body 
  end

  test "get new category form and reject invalid category submission" do
    get new_category_path
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ""} }
   end
    assert_match "błędy", response.body 
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
