require 'rails_helper'

RSpec.describe 'Only admin sees admin dash' do

  xscenario 'admin logs in and sees dash' do
    admin = create(:user, :as_admin)
    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(admin)

    visit admin_dashboard_path(admin) #not sure if this is will be a dash show or index?

    expect(page).to have_content('Admin Dashboard')
  end

  xscenario 'user logs in and does not see admin dash' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(user)

    visit admin_dashboard_path(user)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  xscenario 'guest user does not see admin dash' do
    visit admin_dashboard_path(user)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
