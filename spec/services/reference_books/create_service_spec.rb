# frozen_string_literal: true

RSpec.describe ReferenceBooks::CreateService, type: :service do
  subject { described_class }

  let(:reference_book) { create(:reference_book, :note_link) }
  let(:content_params) { reference_book.content.first }

  context 'valid parameters' do
    let(:volume_params) { 'References' }

    it 'creates the second reference_book' do
      expect { subject.call(content: content_params, volume: volume_params) }
        .to change { ReferenceBook.count }.from(0).to(2)
    end

    it 'assigns reference_book' do
      result = subject.call(content: content_params, volume: volume_params)

      expect(result.reference_book).to be_kind_of(ReferenceBook)
    end
  end

  context 'invalid parameters' do
    let(:volume_params) { nil }

    it 'does not create the second reference_book' do
      expect { subject.call(content: content_params, volume: volume_params) }
        .to change { ReferenceBook.count }.from(0).to(1)
    end

    it 'assigns reference_book' do
      result = subject.call(content: content_params, volume: volume_params)

      expect(result.reference_book).to be_kind_of(ReferenceBook)
    end
  end

  context 'the same parameter' do
    let(:volume_params) { reference_book.volume }

    it 'does not create the second reference_book' do
      expect { subject.call(content: content_params, volume: volume_params) }
        .to change { ReferenceBook.count }.from(0).to(1)
    end

    it 'adds the second item into reference_book.content' do
      result = subject.call(content: content_params, volume: volume_params)
      expect(result.reference_book.content.count).to eq(2)
    end

    it 'assigns reference_book' do
      result = subject.call(content: content_params, volume: volume_params)

      expect(result.reference_book).to be_kind_of(ReferenceBook)
    end
  end
end
