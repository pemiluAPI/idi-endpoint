class CreateIndicatorVariables < ActiveRecord::Migration
  def change
    create_table :indicator_variables do |t|
      t.references :time_serie
      t.references :indicator
      t.string	:value
      t.timestamps
    end
    add_index :indicator_variables, :time_serie_id
    add_index :indicator_variables, :indicator_id
  end
end
