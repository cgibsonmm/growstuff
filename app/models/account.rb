class Account < ApplicationRecord
  belongs_to :member
  belongs_to :account_type

  validates :member_id, uniqueness: {
    message: 'already has account details associated with it'
  }

  before_validation do
    # If not account type, set to the free account
    unless account_type
      self.account_type = AccountType.find_or_create_by(name:
        Rails.application.config.default_account_type)
    end
  end

  def paid_until_string
    if account_type.is_permanent_paid
      "forever"
    elsif account_type.is_paid
      paid_until.to_s
    end
  end
end
