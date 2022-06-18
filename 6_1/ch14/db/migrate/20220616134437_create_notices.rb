class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.belongs_to :user, comment: "通知を受けたユーザー"
      t.integer :notice_id, comment: "通知を纏める元の通知"
      t.integer :message_type, comment: "メッセージの種類"
      t.json :optional, null: true, comment: "メッセージの種類によって変わるオプション"

      t.timestamps
    end
  end
end
