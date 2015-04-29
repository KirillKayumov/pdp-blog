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

    describe '#destroy' do
      let(:comment) { create :comment }
      let(:params) do
        {
          article_id: article.id,
          id: comment.id,
          format: :js
        }
      end

      it 'responds with 401' do
        delete :destroy, params

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
              text: comment.text
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
              text: ''
            },
            format: :js
          }
        end

        it 'do not save the article' do
          expect { post :create, params }.not_to change { Comment.count }
        end
      end
    end

    describe '#destroy' do
      context 'user deletes his comment' do
        let!(:comment) { create :comment, user: user, article: article }
        let(:params) do
          {
            article_id: article.id,
            id: comment.id,
            format: :js
          }
        end

        it 'deletes the comment' do
          expect { delete :destroy, params }.to change { Comment.count }.by(-1)
        end
      end

      context 'user deletes not his comment' do
        let!(:comment) { create :comment, user: user, article: article }
        let!(:comment2) { create :comment, article: article }
        let(:params) do
          {
            article_id: article.id,
            id: comment2.id,
            format: :js
          }
        end

        it 'does not delete the comment' do
          expect { delete :destroy, params }.not_to change { Comment.count }
        end
      end
    end
  end
end
