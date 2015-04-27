require 'rails_helper'

describe ArticleQuery do
  let!(:article1) { create :article }
  let!(:article2) { create :article, created_at: article1.created_at + 1.day }
  let(:query) { described_class.new }

  subject { query.search }

  describe '#search' do
    it 'searches ordered articles' do
      expect(subject).to eq([article2, article1])
    end
  end
end
