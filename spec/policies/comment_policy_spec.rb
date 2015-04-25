require 'rails_helper'

describe CommentPolicy do
  subject { described_class }

  let(:user) { create :user }

  permissions :new? do
    let(:comment) { create :comment }

    context 'signed in user' do
      it 'grants access' do
        expect(subject).to permit(user, comment)
      end
    end

    context 'not signed in user' do
      it 'denies access' do
        expect(subject).not_to permit(nil, comment)
      end
    end
  end

  permissions :create? do
    context 'user creates his comment' do
      let(:comment) { create :comment, user: user }

      it 'grants access' do
        expect(subject).to permit(user, comment)
      end
    end

    context 'user edits not his article' do
      let(:comment) { create :comment }

      it 'denies access' do
        expect(subject).not_to permit(user, comment)
      end
    end
  end
end
