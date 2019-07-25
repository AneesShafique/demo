class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  after_create_commit {BroadcastCommentJob.perform_later self}
end
