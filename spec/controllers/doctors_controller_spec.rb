# spec/controllers/doctors_controller_spec.rb
require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  describe 'GET /doctors' do
    it 'returns a list of doctors' do
      create(:doctor, name: 'Dr. John Doe', specialty: 'Cardiology')
      create(:doctor, name: 'Dr. Jane Smith', specialty: 'Pediatrics')

      get :index

      expect(response).to have_http_status(:success)
    end
  end
end
