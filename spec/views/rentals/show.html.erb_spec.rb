require 'rails_helper'

RSpec.describe "rentals/show", type: :view do
  before(:each) do
    assign(:rental, Rental.create!(
      book: nil,
      renter_name: "Renter Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Renter Name/)
  end
end
