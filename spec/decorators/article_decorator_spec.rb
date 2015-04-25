require 'rails_helper'

describe ArticleDecorator do
  subject { ArticleDecorator.new(article) }

  describe '#text_by_paragraphs' do
    let(:article) { create :article, text: "text\r\ntext" }

    it 'splits text by paragraphs' do
      expect(subject.text_by_paragraphs).to eq(%w(text text))
    end
  end
end
