require 'rails_helper'

describe BaseDecorator do
  subject { BaseDecorator.new(object) }

  describe '#created_at' do
    let(:object) { create :article, created_at: created_at }

    context 'later than 1 day ago' do
      let(:created_at) { Time.zone.now - 10.minutes }

      it 'returns datetime in words' do
        expect(subject.created_at).to eq('10 minutes ago')
      end
    end

    context 'earlier than 1 day ago' do
      let(:created_at) { Time.zone.parse('2015-01-01') }

      it 'returns day, month, year' do
        expect(subject.created_at).to eq('1 January 2015')
      end
    end
  end

  describe '#split_by_paragraphs' do
    let(:object) { create :article }
    let(:text) { "text\r\ntext" }

    it 'splits by paragraphs' do
      expect(subject.split_by_paragraphs(text)).to eq(%w(text text))
    end
  end
end
