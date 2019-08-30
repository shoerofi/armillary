class Api::V1::SeatsController < ApplicationController
  # POST /api/v1/create_and_fill_seats
  def create_and_fill_seats
    # @seat = Seat.new()
byebug
    # if @seat.save
      render json: { seats: '' }, status: :created, location: @seat
    # else
    #   render json: @seat.errors, status: :unprocessable_entity
    # end
  end
end
