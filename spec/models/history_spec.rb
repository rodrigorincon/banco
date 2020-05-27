require 'rails_helper'

RSpec.describe History, type: :model do
 	let!(:account) {create(:account, :account1)}
 	let!(:account2) {create(:account, :account2)}

  	it "create a deposit history" do
  		account.deposit(50)
  		expect(History.last.action).to eq("deposito")
  		expect(History.last.source_account_id).to eq(account.id)
  		expect(History.last.dest_account_id).to be_nil
	end

	it "create a withdraw history" do
  		account.update!(money: 1000)
  		account.withdraw(50)

  		expect(History.last.action).to eq("saque")
  		expect(History.last.source_account_id).to eq(account.id)
  		expect(History.last.dest_account_id).to be_nil
	end

	it "create a transfer history" do
		# Wed, midday
  		allow(Date).to receive(:today).and_return Date.new(2020,5,27)
  		allow(Time).to receive(:now).and_return   Time.new(2020,5,27, 12, 0, 0)
  		
  		account.update!(money: 100)
  		account.transfer(5, account2)

  		expect(History.last.action).to eq("transferencia")
  		expect(History.last.source_account_id).to eq(account.id)
  		expect(History.last.dest_account_id).to eq(account2.id)
	end

end
