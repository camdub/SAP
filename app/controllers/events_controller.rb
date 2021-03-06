class EventsController < ApplicationController
  
  respond_to :html, :only => :index # index.html.erb is used to initialize data for backbone
  respond_to :json
  
  # GET
  def index
    @events = Event.all
    respond_with @events
  end
  
  # GET
  def show
    @event = Event.find(params[:id])
    @event[:appointment_ids] = @event.appointment_ids
    render :json => @event, :status => :ok
  end
  
  # POST
  def create
    @event = Event.create(params[:event])
    @event.user = @current_user
    if @event.save
      broadcast("/events/new", @event.attributes)      
      respond_with @event, :status => :ok # backbone needs 200
    else
      render :json => @event.errors.full_messages, :status => :unprocessable_entity
    end
  end
  
  # PUT
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      broadcast("/events/update", @event.attributes)
      render :json => @event, :status => :ok # 200
    else
      render :json => @event.errors.full_messages, :status => :unprocessable_entity
    end
  end
  
  # DELETE
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    broadcast("/events/delete", params[:id])
    respond_with "", :status => :ok
  end
  
  # Returns a response when there is an ActiveRecord error
  rescue_from ActiveRecord::RecordNotFound do |exp|
    hash = {:message => exp.message}
    respond_with hash.to_json, :status => :not_found
  end
  
end
