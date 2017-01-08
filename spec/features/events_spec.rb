require "rails_helper"

RSpec.feature "Event", :type => :feature do
  let(:user) { User.where(id: 1).first || FactoryGirl.create(:user, id: 1) }
  let(:event) {FactoryGirl.create(:event)}

  scenario "User creates a new event" do   
    visit new_user_event_path(user.id)

    fill_in "event[name]", :with => "My Widget"
    click_button "Create Event"
    expect(page).to have_text("Event was successfully created.")
  end

  scenario "User updates a event" do   
    visit edit_user_event_path(user.id, event.id)

    fill_in "event[name]", :with => "My Widget"
    click_button "Update Event"
    expect(page).to have_text("Event was successfully updated.")
  end

  scenario "User can show event" do   
    visit user_event_path(user.id, event.id)
    expect(page).to have_text("Event Information")
  end

  scenario "User can show all events" do   
    visit user_events_path(user.id)
    expect(page).to have_text("All Events")
  end
end