class User < ActiveRecord::Base
  include Clearance::User

  def self.groped_collection
    User.all.group_by(&:role)
  end

  def self.groped_collection_by_role
    {
      'admin' => User.limit(10),
      'moderator' => User.limit(10),
      'user' => User.limit(10)
    }
  end

end
