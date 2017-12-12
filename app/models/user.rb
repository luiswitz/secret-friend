class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :campaigns, dependent: :destroy

  def last_campaigns
    campaigns.order(updated_at: :desc).limit(5)
  end
end
