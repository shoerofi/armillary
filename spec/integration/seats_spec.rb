# spec/integration/seats_spec.rb
require 'swagger_helper'

describe 'Seats API' do

  path '/api/v1/create_and_fill_seats' do

    post 'Creates and fill seats' do
      tags 'Seats'
      consumes 'application/json'
      parameter name: :create_and_fill_seats, in: :body, schema: {
        type: :object,
        properties: {
          seats: { type: :array, items: [], description: "A 2D Array that represents the rows and columns [x,y]: [[3,4], [4,5], [2,3], [3,4]]" },
          passengers: { type: :integer, description: "The number of passengers waiting in the queue" }
        },
        required: [ 'seats', 'passengers' ]
      }

      response '201', 'seat created' do
        let(:seat) { { seats: 'Dodo' } }
        run_test!
      end

      response '422', 'failed request' do
        let(:seat) { { seats: 'foo' } }
        run_test!
      end
    end
  end
end
