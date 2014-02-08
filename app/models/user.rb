# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  username                     :string(255)
#  first_name                   :string(255)
#  last_name                    :string(255)
#  full_name                    :string(255)
#  email                        :string(255)
#  profile_picture              :string(255)
#  member_state                 :string(255)
#  password_reset_token         :string(255)
#  password_reset_sent_at       :datetime
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#  crypted_password             :string(255)
#  salt                         :string(255)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password, message: "should match confirmation", :if => :password
end
