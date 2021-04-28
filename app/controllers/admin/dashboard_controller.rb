class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'] 
  
  def show
    @category = Category.count(:all)
    @products = Product.count(:all)
  end
  
  
end
