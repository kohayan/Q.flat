class DeleteQuizCategory < ActiveRecord::Migration[5.2]
  def change
  	drop_table :quiz_categories
  end
end
