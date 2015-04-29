require 'rails_helper'

describe CommentPresenter do
  let(:presenter) { described_class.wrap(comment) }

  describe '#text_by_paragraphs' do
    let(:comment) { create :comment, text: "text\r\ntext" }

    subject { presenter.text_by_paragraphs }

    it 'splits text by paragraphs' do
      expect(subject).to eq(%w(text text))
    end
  end

  describe '#author' do
    let(:user) { create :user, full_name: 'Name Surname' }
    let(:comment) { create :comment, user: user }

    subject { presenter.author }

    it 'returns author full name of the article' do
      expect(subject).to eq('Name Surname')
    end
  end

  describe '#created_at' do
    let(:comment) { create :comment, created_at: created_at }

    subject { presenter.created_at }

    context 'later than 1 day ago' do
      let(:created_at) { Time.zone.now - 10.minutes }

      it 'returns datetime in words' do
        expect(subject).to eq('10 minutes ago')
      end
    end

    context 'earlier than 1 day ago' do
      let(:created_at) { Time.zone.parse('2015-01-01') }

      it 'returns formatted date' do
        expect(subject).to eq('1 January 2015')
      end
    end
  end
end
