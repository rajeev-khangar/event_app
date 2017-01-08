require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryGirl.build(:event) }

  it { should belong_to(:user)}
  it { should validate_presence_of(:event_date) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
end