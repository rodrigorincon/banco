class User < ApplicationRecord
  include DestroyedAt
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name

  after_create_commit :create_account

  has_one :account

  def create_account
    # for this test exist only one agency, like Inter 
    last_number_account = Account.unscoped.maximum(:bank_account).to_i
    bank_account = last_number_account + 1
  	Account.create(user_id: self.id, agency: Account::ACCOUNT_AGENCY, bank_account: bank_account)
  end

end
