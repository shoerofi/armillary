class Api::V1::SeatsController < ApplicationController
  # POST /api/v1/create_and_fill_seats
  def create_and_fill_seats
  	seats = params[:seats]
  	passengers = params[:passengers]
  	max_seats = seats.inject(0) { |sum, x| sum += x[0] * x[1] }
  	validate = validation(seats, passengers, max_seats)

    if !validate.present?
    	Seat.destroy_all

    	seats.size.times.each_with_index { |o, i| Seat.create(idx: i) }

    	#Set and define seats by index order position from left to right
    	Seat.all.each do |seat|
    		if seat.idx == 0 #Left position
    			row = seats[seat.idx][0].to_i
    			column = seats[seat.idx][1].to_i
    			column.times.each_with_index do |item, index|
    				if index == 0 #Left side window
    					row.times.each_with_index { |o,i| seat.positions.create(position: "window", row: i, col: index ) }
    				elsif index != column - 1 #Middle side
    					row.times.each_with_index { |o,i| seat.positions.create(position: "middle", row: i, col: index ) }
    				else #Right side aisle
    					row.times.each_with_index { |o,i| seat.positions.create(position: "aisle", row: i, col: index ) }
    				end
    			end
  			elsif seat.idx != seats.size - 1 #Middle position
    			row = seats[seat.idx][0].to_i
    			column = seats[seat.idx][1].to_i
    			column.times.each_with_index do |item, index|
    				if index == 0 #Left side aisle
    					row.times.each_with_index { |o,i| seat.positions.create(position: "aisle", row: i, col: index ) }
    				elsif index != column - 1 #Middle side
    					row.times.each_with_index { |o,i| seat.positions.create(position: "middle", row: i, col: index ) }
    				else #Right side aisle
    					row.times.each_with_index { |o,i| seat.positions.create(position: "aisle", row: i, col: index ) }
    				end
    			end
    		else #Right position
    			row = seats[seat.idx][0].to_i
    			column = seats[seat.idx][1].to_i
    			column.times.each_with_index do |item, index|
    				if index == 0 && index == column - 1 #window
    					row.times.each_with_index { |o,i| seat.positions.create(position: "window", row: i, col: index ) }
    				elsif index == 0 #Left side aisle
    					row.times.each_with_index { |o,i| seat.positions.create(position: "aisle", row: i, col: index ) }
    				elsif index != column - 1 #Middle side
    					row.times.each_with_index { |o,i| seat.positions.create(position: "middle", row: i, col: index ) }
    				else #Right side window
    					row.times.each_with_index { |o,i| seat.positions.create(position: "window", row: i, col: index ) }
    				end
    			end
  			end
  		end

			#Fill seats with passengers
  		fill_seats(passengers)

      render json: Seat.all, include: [:positions] , status: :created
	  else
	    render json: { error: validate }, status: :unprocessable_entity
	  end
  end

  def fill_seats(passengers)
  	filled_seat = 0
  	#Fill passangers by position order
  	["aisle", "window", "middle"].each do |item|
  		position = Position.where(position: item).order(:row)
			position.each_with_index do |record, index|
				if index <= position.count - 1 && filled_seat < passengers
  				filled_seat += 1
  				record.update(no: filled_seat)
  			end
  		end
  	end
  end

  def validation(seats, passengers, max_seats)
  	return 'Seats parameter is not an Array.' unless seats.class == Array
  	return 'All sub arrays should be array too.' unless seats.all? { |o| o.class == Array}
  	return 'All sub arrays should be in this size and format: [x,y]. x == row, y == column.' unless seats.all? { |o| o.size == 2}
  	return "All sub arrays should not contain 'zero' values." if seats.any? { |x| x.any?(0) }
  	return 'Passengers parameter is not an Integer.' unless passengers.class == Integer
  	return "We don't have enough seat for all passengers. Maximum seats are #{max_seats.to_s}." if passengers.to_i > max_seats
  end
end
