class PassengerFlightsController < ApplicationController
  def create
    passenger = Passenger.find(params[:id])
  end
end