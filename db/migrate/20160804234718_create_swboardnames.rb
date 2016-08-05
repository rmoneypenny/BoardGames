class CreateSwboardnames < ActiveRecord::Migration[5.0]
  def change
    create_table :swboardnames do |t|
      t.string :name

      t.timestamps
    end
  end
end
