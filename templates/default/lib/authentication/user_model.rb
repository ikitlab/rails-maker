run 'rm app/models/user.rb'
create_file 'app/models/user.rb' do

<<-RUBY

class User < ActiveRecord::Base
  include User::Auth

  rolify

  default_scope :conditions => { :deleted_at => nil }
  validates_presence_of     :name, :email
  validates_presence_of     :password, :on => :create
  validates_confirmation_of :password, :on => :create
  validates_length_of       :password, :within => 6..30, :allow_blank => false
  validates_uniqueness_of   :email, :case_sensitive => false, :scope => :deleted_at
  validates_format_of       :email, :with => Devise::email_regexp

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end

  def self.find_with_destroyed *args
    self.with_exclusive_scope { find(*args) }
  end

  def self.find_only_destroyed
    self.with_exclusive_scope :find => { :conditions => "deleted_at IS NOT NULL" } do
      all
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def mark_as_confirmed
    self.confirmation_token = nil
    self.confirmed_at = Time.now
  end

  def admin?
    self.has_role? :admin
  end

  def possible_name
    if self.firstname.blank? && self.lastname.blank? && self.nickname.blank?
      '<noname user>'    # TODO
    else
      if self.firstname.blank? && self.lastname.blank?
        self.nickname
      else
        [self.firstname, self.lastname].join(' ').strip
      end
    end
  end
end
RUBY

end