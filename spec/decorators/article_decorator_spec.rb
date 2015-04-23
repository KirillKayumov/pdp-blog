require 'rails_helper'

describe ArticleDecorator do
  describe '#created_at' do
    let(:article) do
      create(:article, created_at: created_at).decorate
    end

    context 'later than 1 day ago' do
      let(:created_at) { Time.zone.now - 10.minutes }

      it 'returns datetime in words' do
        expect(article.created_at).to eq('10 minutes ago')
      end
    end

    context 'earlier than 1 day ago' do
      let(:created_at) { Time.new('2015-01-01') }

      it 'returns day, month, year' do
        expect(article.created_at).to eq('1 January 2015')
      end
    end
  end
end
