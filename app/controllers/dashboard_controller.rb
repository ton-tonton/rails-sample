class DashboardController < ApplicationController
  def index
    @books = Book.includes(:rentals).all.order(title: :asc)
  end
end
