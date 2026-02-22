require 'rails_helper'

RSpec.describe "rentals/new", type: :view do
  before(:each) do
    assign(:rental, Rental.new(
      book: nil,
      renter_name: "MyString"
    ))
  end

  it "renders new rental form" do
    render

    assert_select "form[action=?][method=?]", rentals_path, "post" do

      assert_select "input[name=?]", "rental[book_id]"

      assert_select "input[name=?]", "rental[renter_name]"
    end
  end
end
