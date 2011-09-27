class EventsController < ApplicationController
  
  respond_to :json
  
  # GET
  def index
    @events = Event.all
    respond_with @events
  end
  
  # GET
  def show
    @event = Event.find(params[:id])
    respond_with @event
  end
  
  # POST
  def create
    @event = Event.create(params[:event])
    if @event.save
      respond_with @event, :status => :ok # backbone needs 200
    else
      logger.debug "Event: #{@event.errors.messages}"
      render :json => @event.errors.full_messages, :status => :unprocessable_entity
    end
  end
  
  # PUT
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      render :json => @event, :status => :ok # 200
    else
      render :json => @event.errors.full_messages, :status => :unprocessable_entity
    end
  end
  
  # DELETE
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    respond_with "", :status => :ok
  end
  
  # Returns a response when there is an ActiveRecord error
  rescue_from ActiveRecord::RecordNotFound do |exp|
    hash = {:message => exp.message}
    respond_with hash.to_json, :status => :not_found
  end
  
end
