class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:working_hours, :availability, :book_slot]

  # GET /doctors
  def index
    @doctors = Doctor.all
    render_success_response(@doctors, I18n.t('doctor.list'))
  end

  def show
    doctor = Doctor.find(params[:id])
    render_success_response(doctor)
  end

  def create
    doctor = Doctor.create!(doctor_params)
    render_success_response(doctor, I18n.t('doctor.created'))
  rescue StandardError => exception
    render_failure_response(exception.message)
  end

  # GET /doctors/:id/working_hours
  def working_hours
    working_hours = @doctor.working_hours
    render_success_response({ doctor_name: @doctor.name, working_hours: working_hours })
  end

  # GET /doctors/:id/availability
  def availability
    doctor = Doctor.find(params[:id])
    appointments = doctor.appointments.pluck(:appointment_time)

    # Define the working hours for the doctor
    working_hours = doctor.working_hours
    available_slots = []

    working_hours.each do |day, hours|
      next if hours == 'Holiday'

      start_time, end_time = hours.split(' - ').map { |time| Time.parse(time) }

      current_time = start_time
      while current_time < end_time
        slot = { day: day, time: current_time.strftime('%I:%M %p') }

        unless appointments.include?(slot[:time]) && slot[:day].downcase == Date.today.strftime('%A').downcase
          available_slots << slot
        end

        current_time += 1.hour
      end
    end

    render_success_response({ availabilities: available_slots })
  end


  def book_slot
    appointment_time_input = params[:appointment_time]
    parsed_time = parse_readable_time(appointment_time_input)

    if parsed_time.nil?
      render_failure_response(I18n.t('doctor.invalid_time'))
      return
    end

    patient_name = params[:patient_name]

    appointment = @doctor.appointments.new(appointment_time: parsed_time, patient_name: patient_name)
    if appointment.save
      render_success_response(appointment, I18n.t('doctor.appointment_booked'))
    else
      render_failure_response(I18n.t('doctor.not_found')  )
    end
  end

  private

  def parse_readable_time(time_str)
    parsed_time = Chronic.parse(time_str)

    if parsed_time.present?
      return parsed_time
    else
      return nil
    end
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:name, :specialty, working_hours: {})
  end
end
