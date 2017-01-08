require "rails_helper"

RSpec.feature "User", :type => :feature do
  let(:user) { User.where(id: 1).first || FactoryGirl.create(:user, id: 1) }

  scenario "User creates a new account" do   
    visit new_user_path(user.id)

    fill_in "user[name]", :with => "My Widget"
    fill_in "user[email]", :with => "new@mailinator.com"
    fill_in "user[password]", :with => "12345678"
    click_button "Create User"
    expect(page).to have_text("User was successfully created.")
  end

  scenario "User creates a new account with valid params" do   
    visit new_user_path(user.id)

    fill_in "user[name]", :with => "My Widget"
    fill_in "user[email]", :with => "new@mailinator.com"
    fill_in "user[password]", :with => "12345678"
    click_button "Create User"
    expect(page).to have_text("User was successfully created.")
  end

  scenario "User creates a new account without email" do   
    visit new_user_path(user.id)

    fill_in "user[name]", :with => "My Widget"
    fill_in "user[password]", :with => "12345678"
    click_button "Create User"
    expect(page).to have_text("Email can't be blank")
  end

  scenario "User creates a new account without name" do   
    visit new_user_path(user.id)

    fill_in "user[email]", :with => "new@mailinator.com"
    fill_in "user[password]", :with => "12345678"
    click_button "Create User"
    expect(page).to have_text("Name can't be blank")
  end

  scenario "User creates a new account without password" do   
    visit new_user_path(user.id)

    fill_in "user[email]", :with => "new@mailinator.com"
    fill_in "user[name]", :with => "user"
    click_button "Create User"
    expect(page).to have_text("Password can't be blank")
  end

  scenario "User updates account" do   
    visit edit_user_path(user.id)

    fill_in "user[name]", :with => "updated Widget"
    click_button "Update User"
    expect(page).to have_text("User was successfully updated.")
  end

  scenario "User can see account" do   
    visit user_path(user.id)
    expect(page).to have_text("User Information")
  end

  scenario "User can see all users" do   
    visit users_path
    expect(page).to have_text("All Users")
  end
end