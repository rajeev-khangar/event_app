FactoryGirl.define do
  factory :event do
    sequence :name do |n|
      "event #{n}"
    end
    
    user { User.where(id: 1).first || create(:user, id: 1) }
    event_date Time.now
  end
end