class CreateSevenWonders < ActiveRecord::Migration[5.0]
  def change
    create_table :seven_wonders do |t|
      t.integer :gamenumber
      t.string :name
      t.string :boardname
      t.integer :score
      t.boolean :win
      t.datetime :date

      t.timestamps
    end
  end
end


