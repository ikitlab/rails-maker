say 'Building roles..'

run 'rails g rolify:role Role User'

inject_into_file 'app/models/user.rb', :after => "include User::Auth\n" do
<<-RUBY
  rolify
RUBY
end

run 'rm app/models/role.rb'
create_file 'app/models/role.rb' do
<<-RUBY
  class Role < ActiveRecord::Base

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  scopify
end
RUBY
end

create_file 'app/models/ability.rb' do
<<-RUBY
class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
 
    if user.role? :admin
      can :manage, :all
    # elsif user.role? :writter
    #   can :manage, [Post, Asset]
    # elsif user.role? :memeber
    #   can :read, [MemberPost, Asset]
    #   # manage posts, assets user owns
    #   can :manage, Post do |p|
    #     p.try(:owner) == user
    #   end
    #   can :manage, Asset do |a|
    #     a.try(:owner) == user
    #   end
    end
  end
end
RUBY
end

inject_into_file 'app/controllers/application_controller.rb', :before => "end\n" do
<<-RUBY

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end
RUBY
end

inject_into_file 'db/seeds.rb', :before => "user.save" do
<<-RUBY
  user.add_role, :admin

RUBY
end
=begin
append_file 'db/seeds.rb' do
<<-FILE
Role.create! :name => 'Admin'
Role.create! :name => 'Member'

user1 = User.find_by_email('#{ENV['RAILSMAKER_USER_EMAIL']}')
user1.role_ids = [1,2]
user1.save
FILE
end
=end