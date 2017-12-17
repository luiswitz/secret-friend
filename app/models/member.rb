class Member < ApplicationRecord
  belongs_to :campaign
  validates :name, :email, :campaign, presence: true
  validates :email, email_format: { message: 'Invalid email' }
  after_destroy :set_campaign_pending

  def set_pixel
    self.open = false
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Member.exists?(token: random_token)
    end
    save!
  end

  protected

  def set_campaign_pending
    campaign.update(status: :pending)
  end
end
