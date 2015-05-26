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

require 'spec_helper'

describe User do

  it 'has valid factories' do
    user = create(:user)
    expect( user ).to be_valid
  end

  context 'when created' do
    let(:params)      { { first_name: 'test', last_name: 'user' } }
    let!(:user1)      { create(:user, params) }
    let!(:user_count) { User.count }
    let!(:user2)      { create(:user, params) }

    it 'should have a valid username' do
      expect( user1 ).to be_valid
      expect( user1.username ).to eq 'testuser'
    end

    it 'should not have a duplicate username' do
      expect( user2 ).to be_valid
      expect( user2.username ).to eq "testuser#{user_count+1}"
    end
  end

end
