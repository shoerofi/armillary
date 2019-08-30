# spec/integration/seats_spec.rb
require 'swagger_helper'

describe 'Seats API' do

  path '/api/v1/seats' do

    post 'Creates and fill seats' do
      tags 'Seats'
      consumes 'application/json'
      parameter seats: :passengers, in: :body, schema: {
        type: :object,
        properties: {
          seats: { type: :string },
          passengers: { type: :integer }
        },
        required: [ 'seats', 'passengers' ]
      }

      response '201', 'seat created' do
        let(:seat) { { seat: 'Dodo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:seat) { { seat: 'foo' } }
        run_test!
      end
    end
  end
end
