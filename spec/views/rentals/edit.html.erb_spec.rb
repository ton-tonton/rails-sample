require 'rails_helper'

RSpec.describe "rentals/edit", type: :view do
  let(:rental) {
    Rental.create!(
      book: nil,
      renter_name: "MyString"
    )
  }

  before(:each) do
    assign(:rental, rental)
  end

  it "renders the edit rental form" do
    render

    assert_select "form[action=?][method=?]", rental_path(rental), "post" do

      assert_select "input[name=?]", "rental[book_id]"

      assert_select "input[name=?]", "rental[renter_name]"
    end
  end
end
