class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :user_ip

      t.timestamps null: false
    end
  end
end
