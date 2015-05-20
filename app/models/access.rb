class Access < ActiveRecord::Base
  before_create :generate_token

  belongs_to :user

  # Time for Accesses to live, in seconds (this is 30 minutes)
  TTL = 60*30

  def self.destroy_old
    Access.destroy_all(["updated_at < ?", Access::TTL.seconds.ago])
  end

  private
    def generate_token
      begin
        self.token = SecureRandom.hex
      end while Access.exists?(token: token)
    end
end
