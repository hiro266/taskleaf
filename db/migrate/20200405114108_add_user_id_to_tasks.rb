class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, foreign_key: true,null: false, index: true
  end
end
