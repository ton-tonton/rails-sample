require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    assign(:book, Book.create!(
      title: "Title",
      author: "Author",
      status: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/2/)
  end
end
