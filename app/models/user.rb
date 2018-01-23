class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items

  has_secure_password

  validates(:username, presence: true)

  def get_completed_count
    all_items = todo_items.where("todo_items.completed = :completed", completed: true)
    all_items.count
  end
end
