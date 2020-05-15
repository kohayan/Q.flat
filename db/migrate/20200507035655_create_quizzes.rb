class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
    	t.references :user, null: false, foreign_key: true
    	t.text :question, null: false
    	t.string :answer, null: false
    	t.text :explanation
    	t.string :quiz_image_id

      t.timestamps
    end
  end
end
