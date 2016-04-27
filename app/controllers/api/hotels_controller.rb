class Api::HotelsController < InheritedResources::Base
  respond_to :json

  # GET /api/hotels
  def index
    @hotels = Hotel.all.order(:name)
    respond_with(@hotels)
  end

  # GET /api/hotels/:id
  def find
    @hotel = Hotel.find(params[:id])
    respond_with(@hotel)
  end

  # PUT /api/hotels/:id
  def update
    @hotel = Hotel.find(params[:hotel][:id])
    if @hotel.update_attributes(params[:hotel])
       head :no_content and return
    else
      head :no_content, status: :unprocessable_entity
    end
  end

  # GET /api/search
  def search
    render nothing: true, status: :unprocessable_entity and return unless params[:q].present?
    @hotels = Hotel.search(params[:q])
    respond_with(@hotels)
  end

  # DELETE /api/search
  def destroy
    @hotel = Hotel.find(params[:id])

    if @hotel.destroy
      head :no_content and return
    else
      render nothing: true, status: :bad_request
    end
  end
end