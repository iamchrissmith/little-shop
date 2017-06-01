require 'rails_helper'

Rspec.describe "User wants to see items in cart" do

  before do
    @items = create_list(:item, 3)
    visit(root_path)
    within(page.find('div', text: "#{@item[0].name}")) do
      click_on "Add to Cart"
      click_on "Add to Cart"
    end
  end

  scenario "They see items in cart, create account, and still see items in cart" do
    click_on('Cart')
    expect(path).to eq('/cart')

    within(page.find('div', text: "#{@items[0].name}")) do
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total:")
    end
    expect(page).to_not have_link "Checkout"
    expect(page).to have_link "Login or Create Account to Checkout"
    click_on "Login or Create Account to Checkout"

    expect(path).to eq('/login')
    click_on "Create Account"

    fill_in 'First Name', with: 'Dude'
    fill_in 'Last Name', with: "Sky"
    fill_in 'Email', with: 'dude@sky.net'
    fill_in 'Password', with: 'dude'
    click_button 'Submit'

    expect(path).to eq(root_path)
    click_on('Cart')

    within(page.find('div', text: "#{@items[0].name}")) do
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Total:")
    end

    expect(page).to have_link "Checkout"
    expect(page).to_not have_link "Login or Create Account to Checkout"
  end

end