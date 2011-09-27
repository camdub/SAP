class AppointmentsController < ApplicationController
  
  respond_to :json
  
  def create
    @appointment = Appointment.create(params[:appointment])
    
    if @appointment.save
      respond_with @appointment, :status => :ok
    else
      render :json => @appointment.errors.full_messages, :status => :unprocessable_entity
    end
  end
  
end
