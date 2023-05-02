class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.integer :role, default: 0
      t.belongs_to :user
      t.datetime :expires_at, null: false
      t.timestamps
      t.datetime :deleted_at

      t.index :uuid, unique: true
      t.index :deleted_at
    end
  end
end
