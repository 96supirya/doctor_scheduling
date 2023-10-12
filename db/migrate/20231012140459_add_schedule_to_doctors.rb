class AddScheduleToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :schedule, :json
  end
end
