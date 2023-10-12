class Appointment < ApplicationRecord
  belongs_to :doctor
  validate :check_overlapping_appointments

  private

  def check_overlapping_appointments
    overlapping_appointment = Appointment.where(doctor_id: doctor_id)
                                         .where('appointment_time >= ? AND appointment_time <= ?', appointment_time.beginning_of_hour, appointment_time.end_of_hour)
                                         .where.not(id: id)
                                         .exists?

    if overlapping_appointment
      errors.add(:Doctor, 'already has an appointment at this time')
    end
  end
end
