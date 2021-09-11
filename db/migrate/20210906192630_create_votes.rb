class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :value
      t.references :votable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
