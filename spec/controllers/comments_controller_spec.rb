require 'rails_helper'

describe CommentsController, type: :controller do
  let!(:article) { create :article }

  context 'not signed in user' do
    describe '#create' do
      it 'responds with 401' do
        post :create, article_id: article.id, format: :js

        expect(response.status).to eq(401)
      end
    end
  end

  context 'signed in user' do
    let!(:user) { create :user }

    before { sign_in user }

    describe '#create' do
      let(:comment) { build :comment }

      context 'valid params' do
        let(:params) do
          {
            article_id: article.id,
            comment: {
              text: comment.text,
              user_id: user.id
            },
            format: :js
          }
        end

        it 'saves the comment' do
          expect { post :create, params }.to change { Comment.count }.by(1)
        end
      end

      context 'invalid article params' do
        let(:params) do
          {
            article_id: article.id,
            comment: {
              text: '',
              user_id: user.id
            },
            format: :js
          }
        end

        it 'do not save the article' do
          expect { post :create, params }.not_to change { Comment.count }
        end
      end

      context 'incorrect user id parameter' do
        let(:params) do
          {
            article_id: article.id,
            comment: {
              text: article.text,
              user_id: user.id + 1
            },
            format: :js
          }
        end

        it 'does not create an article' do
          expect { post :create, params }.not_to change { Article.count }
        end
      end
    end
  end
end
