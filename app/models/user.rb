class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { usuario: 0, admin: 1 }

  validates :role, presence: true, inclusion: { in: roles.keys }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "usuario"
  end
end
