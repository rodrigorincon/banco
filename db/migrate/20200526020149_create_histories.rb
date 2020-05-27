class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.bigint :source_account_id
      t.bigint :dest_account_id
      t.string :action
      t.decimal :value, default: 0.0, precision: 14, scale: 2

	    t.datetime :destroyed_at
      t.timestamps
    end
  end
end
