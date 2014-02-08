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

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates_format_of :first_name, :last_name, with: /\A[a-zA-Z\.\-\s\']*\z/
  validates :first_name, :last_name, presence: true

  before_validation :generate_username, on: :create
  before_create :generate_gravatar, :generate_full_name

  before_save :change_name, :check_profile_picture, :check_for_disabled

  def to_s
    full_name
  end

  def generate_username
    if first_name && last_name
      generated_name = "#{first_name.downcase}#{last_name.downcase}".gsub(/\W/, "")
      if User.exists?(username: generated_name)
        self.username = generated_name + "#{id || User.last.id + 1}"
      else
        self.username = generated_name
      end
    end
  end

  def generate_full_name
    self.full_name = "#{first_name} #{
    last_name}"
  end

  def change_name
    if name_changed?
      generate_username
      generate_full_name
    end
  end

  def name_changed?
    # if first or last name has changed, update the username unless the username has changed as well
    (["first_name", "last_name"] & changed).present? && (changed.exclude?("username"))
  end

  def generate_gravatar
    self.profile_picture = gravatar_url
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}?s=200&d=mm"
  end

  def check_profile_picture
    generate_gravatar unless profile_picture.present?
  end

  private

  def check_for_disabled
    if self.member_state_changed? && self.member_state_change.last && self.disabled?
      # Launch BG process to remove this user from all groups and other thingies
      # DisableUserWorker.perform_in( 1.minute, self.id )
      # remove from ES
      # remove_data_from_es
    end
  end

end
