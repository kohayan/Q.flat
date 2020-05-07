class CreateQuizComments < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_comments do |t|

    	t.references :user, null: false, foreign_key: true
    	t.references :quiz, null: false, foreign_key: true
    	t.text :comment, null: false

    	t.timestamps
    end
  end
end
