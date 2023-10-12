class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :patient_name
      t.datetime :appointment_time
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
