require 'rails_helper'

RSpec.describe "rentals/index", type: :view do
  before(:each) do
    assign(:rentals, [
      Rental.create!(
        book: nil,
        renter_name: "Renter Name"
      ),
      Rental.create!(
        book: nil,
        renter_name: "Renter Name"
      )
    ])
  end

  it "renders a list of rentals" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Renter Name".to_s), count: 2
  end
end
