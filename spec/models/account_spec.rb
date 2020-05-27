require 'rails_helper'

RSpec.describe Account, type: :model do
 	let!(:account) {create(:account, :account1)}
 	let!(:account2) {create(:account, :account2)}

 	describe "2 bank accounts in the same agency" do
	  	it "doesnt create a new account" do
	  		account_number = Account.count
	  		new_account = Account.create(user_id: account.user_id, agency: account.agency, bank_account: account.bank_account)
	  		expect(new_account.id).to be_nil
	  		expect(Account.count).to eq(account_number)
	  	end
	end

  	describe "deposit" do
	  	it "deposit works" do
	  		last_value = account.money
	  		account.deposit(50)
	  		expect(account.money).to eq(last_value + 50)
	  	end

	  	it "cant deposit 0 value" do
	  		last_value = account.money
	  		account.deposit(0)
	  		expect(account.money).to eq(last_value)
	  		expect(account.errors.any?).to be_truthy
	  	end

	  	it "cant deposit negative value" do
	  		last_value = account.money
	  		account.deposit(-2)
	  		expect(account.money).to eq(last_value)
	  		expect(account.errors.any?).to be_truthy
	  	end
  	end

  	describe "withdraw" do
	  	before(:each) do
			account.update!(money: 1000)
		end

	  	it "withdraw works" do
	  		account.withdraw(50)
	  		expect(account.money).to eq(950)
	  	end

	  	it "cant withdraw 0 value" do
	  		account.withdraw(0)
	  		expect(account.money).to eq(1000)
	  		expect(account.errors.any?).to be_truthy  	end

	  	it "cant withdraw negative value" do
	  		account.withdraw(-2)
	  		expect(account.money).to eq(1000)
	  		expect(account.errors.any?).to be_truthy
	  	end
  	end

  	describe "transfer" do
  	
	  	describe "transfer in day of week" do
		  	before(:each) do
		  		# Wed, midday
		  		allow(Date).to receive(:today).and_return Date.new(2020,5,27)
		  		allow(Time).to receive(:now).and_return   Time.new(2020,5,27, 12, 0, 0)
		  	end

		  	it "transfer works with 5 of taxes" do
		  		account.update!(money: 1000)
		  		init_src_money = account.money
		  		init_dst_money = account2.money

		  		account.transfer(5, account2)
		  		expect(account.money).to eq(990)
		  		expect(account2.money).to eq(init_dst_money + 5)
		  	end

		  	it "cant transfer because dont have the amount" do
		  		account.update!(money: 10)
		  		account2.update!(money: 0)
		  		account.transfer(20, account2)

		  		expect(account.money).to eq(10)
		  		expect(account2.money).to eq(0)
		  		expect(account.errors.any?).to be_truthy
		  	end

		  	it "cant transfer because amount + tax is bigger than money" do
		  		account.update!(money: 10)
		  		account2.update!(money: 0)
		  		account.transfer(8, account2) # + 5 of taxes

		  		expect(account.money).to eq(10)
		  		expect(account2.money).to eq(0)
		  		expect(account.errors.any?).to be_truthy
		  	end
		end

		describe "transfer in day of week out of commercial time" do
		  	before(:each) do
		  		# Wed, 23h
		  		allow(Date).to receive(:today).and_return Date.new(2020,5,27)
		  		allow(Time).to receive(:now).and_return   Time.new(2020,5,27, 23, 0, 0)
		  	end

		  	it "transfer works with 7 of taxes" do
		  		account.update!(money: 1000)
		  		init_src_money = account.money
		  		init_dst_money = account2.money

		  		account.transfer(3, account2)
		  		expect(account.money).to eq(990)
		  		expect(account2.money).to eq(init_dst_money + 3)
		  	end

		  	it "cant transfer because dont have the amount" do
		  		account.update!(money: 10)
		  		account2.update!(money: 0)
		  		account.transfer(20, account2)

		  		expect(account.money).to eq(10)
		  		expect(account2.money).to eq(0)
		  		expect(account.errors.any?).to be_truthy
		  	end

		  	it "cant transfer because amount + tax is bigger than money" do
		  		account.update!(money: 10)
		  		account2.update!(money: 0)
		  		account.transfer(8, account2) # + 5 of taxes

		  		expect(account.money).to eq(10)
		  		expect(account2.money).to eq(0)
		  		expect(account.errors.any?).to be_truthy
		  	end
		end

		describe "transfer in the weekend" do
		  	before(:each) do
		  		# Sat, midday
		  		allow(Date).to receive(:today).and_return Date.new(2020,5,23)
		  		allow(Time).to receive(:now).and_return   Time.new(2020,5,23, 12, 0, 0)
		  	end

		  	it "transfer works with 7 of taxes" do
		  		account.update!(money: 1000)
		  		init_src_money = account.money
		  		init_dst_money = account2.money

		  		account.transfer(3, account2)
		  		expect(account.money).to eq(990)
		  		expect(account2.money).to eq(init_dst_money + 3)
		  	end

		end

		describe "transfer more than 1000 reais in the weekend" do
		  	before(:each) do
		  		# Sat, midday
		  		allow(Date).to receive(:today).and_return Date.new(2020,5,23)
		  		allow(Time).to receive(:now).and_return   Time.new(2020,5,23, 12, 0, 0)
		  	end

		  	it "transfer works with 17 of taxes" do
		  		account.update!(money: 3107)
		  		init_src_money = account.money
		  		init_dst_money = account2.money

		  		account.transfer(1090, account2)
		  		expect(account.money).to eq(2000)
		  		expect(account2.money).to eq(init_dst_money + 1090)
		  	end
		end

		describe "transfer more than 1000 reais in the middle of week in commercial time" do
		  	before(:each) do
		  		# Wed, midday
		  		allow(Date).to receive(:today).and_return Date.new(2020,5,27)
		  		allow(Time).to receive(:now).and_return   Time.new(2020,5,27, 12, 0, 0)
		  	end

		  	it "transfer works with 15 of taxes" do
		  		account.update!(money: 3105)
		  		init_src_money = account.money
		  		init_dst_money = account2.money

		  		account.transfer(1090, account2)
		  		expect(account.money).to eq(2000)
		  		expect(account2.money).to eq(init_dst_money + 1090)
		  	end
		end
  	end

end
