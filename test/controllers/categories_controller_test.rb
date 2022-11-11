require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
   @category = Category.create(name: "sports")
  end
test "should get categories index" do
   get categories_path
   assert_response :success
end

test "should get categories new" do
   get new_category_path
   assert_response :success
end
test "should get categories show" do
   get category_path(@category)
   assert_response :success
end
end
