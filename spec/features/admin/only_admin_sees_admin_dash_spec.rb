require 'rails_helper'

RSpec.describe 'Only admin sees admin dash' do

  scenario 'admin logs in and sees dash' do
    admin = create(:user, role: 'admin')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_content('Admin Dashboard')
  end

  scenario 'user logs in and does not see admin dash' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'guest user does not see admin dash' do
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
