class AddFollowersTable < ActiveRecord::Migration
  def change
    create_table "followers", :force => true do |t|
      t.integer  "user_id"
      t.string   "followee_id"
    end
  end
end
