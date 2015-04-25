require 'rails_helper'

describe CommentDecorator do
  subject { CommentDecorator.new(comment) }

  describe '#text_by_paragraphs' do
    let(:comment) { create :comment, text: "text\r\ntext" }

    it 'splits text by paragraphs' do
      expect(subject.text_by_paragraphs).to eq(%w(text text))
    end
  end
end
