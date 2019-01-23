class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table 'users', force: :cascade do |t|
      t.string 'firstname', default: '', null: false
      t.string 'lastname', default: '', null: false
      t.string 'email', default: '', null: false
      t.string 'password_digest', default: '', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
end
