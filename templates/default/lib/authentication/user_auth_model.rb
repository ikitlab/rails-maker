
run 'mkdir app/models/user'

create_file 'app/models/user/auth.rb' do

<<-RUBY
module User::Auth

  module ClassMethods

    def new_with_session(params, session)
      super.tap do |user|
        data = session["devise.omniauth"] && session["devise.omniauth"]["extra"]["raw_info"]

        if data
          user.email = data["email"]
        end
      end
    end

    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup

      login = conditions.delete(:login)

      if login
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end

  def self.included(base)
    base.has_many :authentications, dependent: :delete_all

    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :lockable, :timeoutable,
    base.devise :database_authenticatable, :registerable, :confirmable,
                :recoverable, :rememberable, :trackable, :omniauthable, :validatable

    base.extend(ClassMethods)
  end

  def apply_omniauth(auth_hash)

    name, email, token, info = nil, nil, nil, nil

    puts auth_hash.inspect

    name = auth_hash.info.name
    email = auth_hash.extra.raw_info.email
    token = auth_hash.credentials.token
    info = auth_hash.extra.raw_info

    self.email = email
    self.username = make_pretty_username name
    self.authentications.build(
        provider: auth_hash['provider'],
        uid: auth_hash['uid'],
        token: token,
        info: info.to_json
    )
  end

  protected

  def make_pretty_username name
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
    ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'

    #convert double underscores to single
    ret.gsub! /_+/,"_"

    #strip off leading/trailing underscore
    ret.gsub! /\A[_\.]+|[_\.]+\z/,""

    ret
  end

end
RUBY

end
