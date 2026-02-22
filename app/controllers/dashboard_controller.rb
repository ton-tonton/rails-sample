class DashboardController < ApplicationController
  def index
    @pagy, @books = pagy(:offset, Book.includes(:rentals).all.order(title: :asc))
  end
end
