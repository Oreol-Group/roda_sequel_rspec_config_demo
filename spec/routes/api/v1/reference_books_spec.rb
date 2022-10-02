# frozen_string_literal: true

RSpec.describe App, type: :routes do
  describe 'GET /api/v1/reference_books' do
    let!(:reference_book_1) { create(:reference_book, :note_link) }
    let!(:reference_book_2) { create(:reference_book, :note_author) }
    let!(:reference_book_3) { create(:reference_book, :book) }

    it 'returns a collection of reference_books' do
      get '/api/v1/reference_books'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /api/v1/reference_books' do
    let(:reference_book) { create(:reference_book, :note_link) }
    let(:content_params) { reference_book.content.first }

    context 'missing parameters' do
      it 'returns an error' do
        post '/api/v1/reference_books'

        expect(last_response.status).to eq(422)
      end
    end
  end
end
