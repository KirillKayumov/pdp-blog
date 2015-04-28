require 'rails_helper'

describe ArticlePolicy do
  subject { described_class }

  let(:user) { create :user }

  permissions :manage? do
    context 'user edits his article' do
      let(:article) { create :article, user: user }

      it 'grants access' do
        expect(subject).to permit(user, article)
      end
    end

    context 'user edits not his article' do
      let(:article) { create :article }

      it 'denies access' do
        expect(subject).not_to permit(user, article)
      end
    end

    context 'user is not signed in' do
      let(:article) { create :article }

      it 'denies access' do
        expect(subject).not_to permit(nil, article)
      end
    end
  end
end
