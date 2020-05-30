class CreateReferrals < ActiveRecord::Migration[6.0]
  def change
    create_table :referrals do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
