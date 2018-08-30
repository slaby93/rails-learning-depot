class StoreController < ApplicationController
  include CurrentCart

  before_action :initialize_counter, only: :index
  before_action :set_cart

  def index
    session[:counter] += 1
    @products = Product.order(:title)
  end

  def initialize_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
  end

end
