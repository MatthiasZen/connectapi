class CreateNdds < ActiveRecord::Migration[5.0]
  def change
    create_table :ndds do |t|
      t.string :name

      t.timestamps
    end
  end
end
