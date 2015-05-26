# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  username                     :string
#  first_name                   :string
#  last_name                    :string
#  full_name                    :string
#  email                        :string
#  profile_picture              :string
#  member_state                 :string
#  password_reset_token         :string
#  password_reset_sent_at       :datetime
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#  crypted_password             :string
#  salt                         :string
#

FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   'password'
  end

end
