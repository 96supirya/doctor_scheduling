class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]

  # PUT /appointments/:id
  def update
    if @appointment.update(appointment_params)
      render_success_response({
                                appoitment: single_serializer.new(@appointment, serializer: AppointmentSerializer)
                              })
    else
      render_failure_response(errors: @appointment.errors.full_messages)
    end
  end

  # DELETE /appointments/:id
  def destroy
    if @appointment.destroy
      render_success_response(I18n.t('appointment.deleted'))
    end
      rescue StandardError => exception
      render_failure_response(exception.message)
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:patient_name, :appointment_time)
  end
end
