class DashboardController < ApplicationController
  def index
    @pagy, @books = pagy(:offset, Book.includes(:active_rental).all.order(title: :asc))
  end
end
