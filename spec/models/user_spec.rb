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