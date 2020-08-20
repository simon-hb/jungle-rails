class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_AUTH_LOGIN'], password: ENV['ADMIN_AUTH_PASSWORD']
  #MUST RESTART SERVER AFTER CHANGING AUTHENTICATE TO ENV

  def show
    @products = Product.all
    @categories = Category.all
  end
end
