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

    context 'invalid parameters' do
      let(:volume_params) { nil }

      it 'returns an error' do
        post '/api/v1/reference_books', volume: volume_params, content: content_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Add a topic title',
            'source' => {
              'pointer' => '/data/attributes/volume'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:content_params) { {name: "n1", link: "l1"} }
      let(:volume_params) { 'Note' }

      let(:last_reference_book) { reference_book }

      it 'creates a new reference_book' do
        expect { post '/api/v1/reference_books', content: content_params, volume: volume_params }
          .to change { ReferenceBook.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an reference_book' do
        post '/api/v1/reference_books', content: content_params, volume: volume_params

        expect(response_body['data']).to a_hash_including(
          'volume' => last_reference_book.volume.to_s,
        )
      end
    end
  end
end
