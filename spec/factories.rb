FactoryGirl.define do
  factory :user do
    name     "Michael Everett"
    email    "mfe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end