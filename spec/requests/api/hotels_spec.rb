  require 'swagger_helper'

RSpec.describe 'Hotels', type: :request do


  path '/api/v1/hotels' do
    get 'Retrieves all hotels' do
      tags 'Hotels'
      description 'Retrieves all hotels (only logged in users can retrieve hotels) by recieving token with the request that is sent as response body after login'
      produces 'application/json'

      response '200', 'hotels retrieved' do
        run_test!

        before do
          @admin = User.create( name:'admin', role: 'admin', email: 'admin@example.com', password: 'password', username: 'admin')
          @hotels = Hotel.create( [{name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.'}])
        end
        schema type: :array,
         items: {
           type: :object,
           properties: {
             id: { type: :integer },
             name: { type: :string },
             city: { type: :string },
             country: { type: :string },
             phone: { type: :string },
             image: { type: :string },
             details:{ type: :string }
           },
           required: %w[id name image city country phone details]
         }
        
      end
     
      response '401', 'Unauthorized' do
        let(:headers) { invalid_parameters }
        run_test!
      end
    end
  end
end