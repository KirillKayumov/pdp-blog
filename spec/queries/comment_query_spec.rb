require 'rails_helper'

describe CommentQuery do
  let!(:article) { create :article }
  let!(:comment1) { create :comment, article: article }
  let!(:comment2) { create :comment, article: article, created_at: comment1.created_at - 1.day }
  let!(:comment3) { create :comment }
  let(:query) { described_class.new(article) }

  subject { query.search }

  describe '#search' do
    it 'searches ordered comments of the article' do
      expect(subject).to eq([comment2, comment1])
    end
  end
end
