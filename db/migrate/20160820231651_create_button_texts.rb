class CreateButtonTexts < ActiveRecord::Migration
  def change
    create_table :button_texts do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
