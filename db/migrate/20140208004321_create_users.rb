class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :email
      t.string :profile_picture
      t.string :member_state
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at
      t.timestamps
    end
  end
end
