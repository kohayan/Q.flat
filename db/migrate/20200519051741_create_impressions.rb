class CreateImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :impressions do |t|
		t.references :user, null: false, foreign_key: true
		t.references :quiz, null: false, foreign_key: true

		t.timestamps
    end
  end
end
