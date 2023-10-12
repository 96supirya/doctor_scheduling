class AddWorkingHoursToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :working_hours, :json
  end
end
