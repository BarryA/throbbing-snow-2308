require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @american = Airline.create(name: "Southwest")

    @american_1 = @american.flights.create(number: "AA1", date: "01/17/24", time: "1200", departure_city: "Dallas", arrival_city: "Denver")
    @american_2 = @american.flights.create(number: "AA2", date: "01/18/24", time: "2200", departure_city: "Seattle", arrival_city: "Portland")

    @passenger_1 = Passenger.create(name: 'Barry Allahyar', age: '36')
    @passenger_2 = Passenger.create(name: 'Bobby Allahyar', age: '40')
    @passenger_3 = Passenger.create(name: 'Peter Parker', age: '45')
    @passenger_4 = Passenger.create(name: 'Larry David', age: '73')
    @passenger_5 = Passenger.create(name: 'Hulk Hogan', age: '78')
    @passenger_6 = Passenger.create(name: 'Bat Man', age: '55')

    @american_1.passengers << [@passenger_1, @passenger_2, @passenger_3]
    @american_2.passengers << [@passenger_4, @passenger_5, @passenger_6]
  end

  describe "When I visit a flights index page ('/flights/:id')" do
    it "I see the flight's number, date, time, departure city, and arrival city" do
      visit "/flights/#{@american_1.id}"

      expect(page).to have_content("Flight Details")
      expect(page).to have_content("Flight Number: #{@american_1.number}")
      expect(page).to have_content("Date: #{@american_1.date}")
      expect(page).to have_content("Time: #{@american_1.time}")
      expect(page).to have_content("Departure City: #{@american_1.departure_city}")
      expect(page).to have_content("Arrival City: #{@american_1.arrival_city}")

      visit "/flights/#{@american_2.id}"

      expect(page).to have_content("Flight Details")
      expect(page).to have_content("Flight Number: #{@american_2.number}")
      expect(page).to have_content("Date: #{@american_2.date}")
      expect(page).to have_content("Time: #{@american_2.time}")
      expect(page).to have_content("Departure City: #{@american_2.departure_city}")
      expect(page).to have_content("Arrival City: #{@american_2.arrival_city}")
    end

    it 'I see the name of the airline the flight belongs to' do
      visit "/flights/#{@american_1.id}"

      expect(page).to have_content(@american_1.airline)

      visit "/flights/#{@american_2.id}"

      expect(page).to have_content(@american_2.airline)
    end

    it 'I see the names of all of the passengers on the flight' do
      visit "/flights/#{@american_1.id}"

      expect(page).to have_content("Passengers On This Flight")
      expect(page).to have_content("#{@passenger_1}")
      expect(page).to have_content("#{@passenger_2}")
      expect(page).to have_content("#{@passenger_3}")

      visit "/flights/#{@american_2.id}"

      expect(page).to have_content("Passengers On This Flight")
      expect(page).to have_content("#{@passenger_4}")
      expect(page).to have_content("#{@passenger_5}")
      expect(page).to have_content("#{@passenger_6}")
    end
  end
end