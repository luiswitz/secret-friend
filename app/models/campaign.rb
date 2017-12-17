class Campaign < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  before_validation :set_member, on: :create
  before_validation :set_status, on: :create
  enum status: %i[pending finished]
  validates :title, :description, :user, :status, presence: true

  def count_opened
    members.where(open: true).count
  end

  private

  def set_status
    self.status = :pending
  end

  def set_member
    members << Member.create(name: user.name, email: user.email)
  end
end
