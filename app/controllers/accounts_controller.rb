class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  
  def balance
  end

  def history
    # default filter, brings the last 7 days
    @begin_date = params[:begin_date] ? params[:begin_date].to_date : Date.today - 7.days
    @end_date = params[:end_date] ? params[:end_date].to_date : Date.today

    dest_account_sql = History.where(dest_account_id: @account.id)
    @history = History.where(source_account_id: @account.id).or(dest_account_sql)
                      .where(created_at: @begin_date.beginning_of_day..@end_date.end_of_day)
                      .order(created_at: :asc)
  end

  def deposit
    value = params[:deposit_value].to_f
    
    respond_to do |format|
      if @account.deposit(value)
        format.html { redirect_to root_path, notice: 'Depósito realizado com sucesso.' }
      else
        format.html { render :balance }
      end
    end
  end

  def withdraw
    value = params[:withdraw_value].to_f
    
    respond_to do |format|
      if @account.withdraw(value)
        format.html { redirect_to root_path, notice: 'Saque realizado com sucesso.' }
      else
        format.html { render :balance }
      end
    end
  end


  def transfer_page
  end

  def transfer
    agency        = params[:agency]
    bank_account  = params[:bank_account]
    value         = params[:value].to_f

    destination = Account.find_by(agency: agency, bank_account: bank_account)

    respond_to do |format|
      if @account.transfer(value, destination)
        format.html { redirect_to transfer_page_accounts_path, notice: 'Transferência realizada com sucesso.' }
      else
        format.html { render :transfer_page }
      end
    end
  end


  private

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

end
