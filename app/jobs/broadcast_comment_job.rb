class BroadcastCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast 'comment_channel', {comment: comment.comment, name: comment.user.name, pid: comment.product_id, cid: comment.id}
  end
end
