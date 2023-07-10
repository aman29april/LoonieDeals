class CreateSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_accounts do |t|

      t.bigint 'user_id', null: false
      t.integer 'account_type', null: false
      t.string 'url', null: false
      t.index ['user_id'], name: 'index_social_accounts_on_user_id'

      t.timestamps
    end
  end
end
