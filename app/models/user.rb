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

class User < ActiveRecord::Base
  include CinnamonRoles
  include UserCache
  
  authenticates_with_sorcery!

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password, message: "should match confirmation", :if => :password

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates_format_of :first_name, :last_name, with: /\A[a-zA-Z\.\-\s\']*\z/
  validates :first_name, :last_name, presence: true

  before_validation :set_username, on: :create
  before_create :generate_gravatar, :generate_full_name

  before_save :change_name, :check_profile_picture, :check_for_disabled

  def to_s
    full_name
  end

  def set_username
    if first_name && last_name
      self.username = generate_username
      self.username = "#{generate_username}#{get_user_id}" if user_exists
    end
  end

  def generate_username
    "#{first_name.downcase}#{last_name.downcase}".gsub(/\W/, '')
  end

  def user_exists
    User.exists? username: generate_username
  end

  def get_user_id
    id || User.last.id + 1
  end

  def generate_full_name
    self.full_name = "#{first_name} #{last_name}"
  end

  def change_name
    if name_changed?
      generate_username
      generate_full_name
    end
  end

  def name_changed?
    (['first_name', 'last_name'] & changed).present? && (changed.exclude?('username'))
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

end
