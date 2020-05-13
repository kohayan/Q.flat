class AddCategoryToQuiz < ActiveRecord::Migration[5.2]
	def change
		add_column :quizzes, :category, :integer
	end
end
