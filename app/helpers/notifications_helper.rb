module NotificationsHelper
  def notification_form(notification)
    # 通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    # コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.quiz_comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      # aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.nick_name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.nick_name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: quiz_path(notification.quiz_id)) + 'にいいねしました'
    when 'comment' then
      # コメントの内容と投稿のタイトルを取得
      @comment = QuizComment.find_by(id: @visitor_comment)
      @comment_content = @comment.comment
      tag.a(@visitor.nick_name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: quiz_path(notification.quiz_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
