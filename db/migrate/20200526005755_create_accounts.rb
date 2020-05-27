class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.decimal :money, default: 0.0, precision: 14, scale: 2
      t.integer :agency
      t.integer :bank_account

      t.datetime :destroyed_at
      t.timestamps
    end
  end
end
