class SearchController < ApplicationController
  def search
    keywords = params[:keyword].split(/[[:blank:]]+/)
    @quizzes = []
    @users = []
    @tags = []

    keywords.each do |keyword|
      next if keyword == ""
      @quizzes += Quiz.where(['question LIKE ?', "%#{keyword}%"]).date
      @users += User.where(['nick_name LIKE ?', "%#{keyword}%"]).date
      @tags += Tag.where(['name LIKE ?', "%#{keyword}%"]).date
    end

    @quizzes.uniq!
    @users.uniq!
    @tags.uniq!
  end
end
