class AddReferredTimesToReferrals < ActiveRecord::Migration[6.0]
  def change
    add_column :referrals, :referred_times, :integer, null: false, default: 0
  end
end
