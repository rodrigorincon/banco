class Account < ApplicationRecord
  include DestroyedAt
  include TransferTaxRules
  
  belongs_to :user

  validates_presence_of :user_id, :agency, :bank_account, :money
  validates :bank_account, uniqueness: { scope: :agency,  message: "Já existe essa conta nesta agência."}
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  # for this test exist only one agency, like Inter 
  ACCOUNT_AGENCY = 1

  def withdraw(value)
    if value <= 0
      self.errors.add(:money, "Você não pode sacar um valor negativo ou zero")
      return false
    end

  	ActiveRecord::Base.transaction do
  		self.update!(money: self.money - value)
  		History.create!(source_account_id: self.id, action: History::ACTION_WITHDRAW, value: value)
		true
	rescue  ActiveRecord::RecordInvalid => e
    self.money += value
    self.errors.delete(:money)
    self.errors.add(:money, "Você não tem saldo suficiente")
		false
	end
  end

  def transfer(value, dest)
    if dest.nil?
      self.errors.add(:money, "Conta destino inexistente. Verifique os campos e tente novamente.")
      return false
    end

    if self.id == dest.id
      self.errors.add(:money, "Você não pode transferir para a mesma conta.")
      return false
    end

    transfer_tax = get_transfer_tax(value)

  	ActiveRecord::Base.transaction do
  		self.update!(money: self.money - value - transfer_tax)
  		dest.update!(money: dest.money + value)
  		History.create!(source_account_id: self.id, dest_account_id: dest.id, action: History::ACTION_TRANSFER, value: value)
		true
	rescue  ActiveRecord::RecordInvalid => e
    self.money += value + transfer_tax
    self.errors.delete(:money)
    self.errors.add(:money, "Você não tem saldo suficiente. Verifique as taxas de transferência")
		false
	end
  end

  def deposit(value)
  	if value <= 0
      self.errors.add(:money, "Você não pode depositar um valor negativo ou zero")
      return false
    end

    ActiveRecord::Base.transaction do
  		self.update!(money: self.money + value)
  		History.create!(source_account_id: self.id, action: History::ACTION_DEPOSIT, value: value)
		true
	rescue  ActiveRecord::RecordInvalid => e
		false
	end
  end

end
