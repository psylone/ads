class CreateUserSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sessions do |t|
      t.uuid :uuid, null: false, index: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
