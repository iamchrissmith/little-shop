require 'rails_helper'

RSpec.feature "user can browse items by category" do
  it "user can visit category and browse items belonging to that category" do
    category = Category.create(name: "Tech")
    category.items = Item.create(name: "computer",
                                 desc: "makes a rock think",
                                 price: 300,
                                 status: 0,
                                 photo: "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macbookpro/macos-sierra-macbook-pro-thunderbolt3-hero.jpg"
    )
    category.items = Item.create(name: "USB",
                                 desc: "saves data",
                                 price: 10,
                                 status: 0,
                                 photo: "https://s3-ap-southeast-2.amazonaws.com/wc-prod-pim/JPEG_1000x1000/SDCZ5532GB_sandisk_32gb_cruzer_facet_usb_flash_drive.jpg"
    )
    category1 = Category.create(name: "Gardening")
    category1.items = Item.create(name: "rake",
                                  desc: "rakes stuff",
                                  price: 20,
                                  status: 0,
                                  photo: "https://images-na.ssl-images-amazon.com/images/I/41OAkKR1CmL._SX355_.jpg"
    )
    category1.items = Item.create(name: "hose",
                                  desc: "makes things wet",
                                  price: 20,
                                  status: 0,
                                  photo: "http://gilmour.com/wordpress/wp-content/uploads/formidable/garden-hose-medium-duty-15058050.jpg"
    )

    visit items_path
    expect(page).to have_content("computer")
    expect(page).to have_content("USB")
    expect(page).to have_content("rake")
    expect(page).to have_content("hose")

    within "header nav" do
      click_link "Categories"
      click_link "Tech"
    end

    expect(page).to have_content("computer")
    expect(page).to have_content("USB")
    expect(page).to_not have_content("rake")
    expect(page).to_not have_content("hose")
  end
end