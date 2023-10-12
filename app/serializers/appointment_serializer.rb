class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :doctor_name, :patient_name, :appointment_time

  def doctor_name
    object.doctor.name
  end
end
