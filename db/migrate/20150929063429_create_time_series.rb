class CreateTimeSeries < ActiveRecord::Migration
  def change
    create_table :time_series do |t|
      t.references :province
      t.string :year
      t.timestamps
    end
    add_index :time_series, :province_id
  end
end
