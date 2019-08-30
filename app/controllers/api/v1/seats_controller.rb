class Api::V1::SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :update, :destroy]

  # GET /api/v1/seats
  def index
    # @seats = Seat.all
    @seats = {}

    render json: @seats
  end

  # GET /api/v1/seats/1
  def show
    render json: @seat
  end

  # POST /api/v1/seats
  def create
    @seat = Seat.new(seat_params)

    if @seat.save
      render json: @seat, status: :created, location: @seat
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/seats/1
  def update
    if @seat.update(seat_params)
      render json: @seat
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/seats/1
  def destroy
    @seat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat
      @seat = Seat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def seat_params
      params.fetch(:seat).permit!
    end
end
