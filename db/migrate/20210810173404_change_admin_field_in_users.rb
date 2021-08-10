class ChangeAdminFieldInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :admin, :string, null: false, default: 'user'
    User.where(admin: '0').update_all(admin: 'user')
    User.where(admin: '1').update_all(admin: 'admin')
  end

end
