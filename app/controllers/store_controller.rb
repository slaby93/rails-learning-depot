class StoreController < ApplicationController
  before_action :initialize_counter, only: :index

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
