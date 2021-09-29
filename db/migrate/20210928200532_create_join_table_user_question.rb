class CreateJoinTableUserQuestion < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :questions do |t|
      # t.index [:user_id, :question_id]
      # t.index [:question_id, :user_id]
    end
  end
end
