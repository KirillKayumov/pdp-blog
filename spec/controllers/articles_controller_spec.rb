require 'rails_helper'

describe ArticlesController, type: :controller do
  describe '#index' do
    let!(:article1) { create :article, created_at: Time.zone.yesterday }
    let!(:article2) { create :article, created_at: Time.zone.now }

    before(:each) { get :index }

    it 'responds with 200' do
      expect(response.status).to eq(200)
    end

    it 'exposes all articles' do
      expect(controller.decorated_articles).to eq([article2, article1])
    end
  end

  describe '#show' do
    let!(:article) { create :article }

    before(:each) { get :show, id: article.id }

    it 'responds with 200' do
      expect(response.status).to eq(200)
    end

    it 'exposes the article' do
      expect(controller.article).to eq(article)
      expect(controller.decorated_article).to eq(article)
    end
  end

  describe '#new' do
    context 'user is not signed in' do
      before(:each) { get :new }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create :user }

      before(:each) do
        sign_in user
        get :new
      end

      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#create' do
    let(:user) { create :user }
    let(:article) { build :article }
    let(:params) do
      {
        article: {
          title: article.title,
          text: article.text,
          user_id: user.id
        }
      }
    end

    context 'user is not signed in' do
      before(:each) { post :create, params }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      before(:each) { sign_in user }

      context 'valid params' do
        it 'saves the article' do
          expect { post :create, params }.to change { Article.count }.by(1)
          expect(response).to redirect_to(root_path)
        end
      end

      context 'invalid article params' do
        let(:invalid_params) do
          {
            article: {
              title: '',
              text: '',
              user_id: user.id
            }
          }
        end

        it 'do not save the article' do
          expect { post :create, invalid_params }.not_to change { Article.count }
          expect(response).to render_template(:new)
        end
      end

      context 'incorrect user id parameter' do
        let(:invalid_params) do
          {
            article: {
              title: article.title,
              text: article.text,
              user_id: user.id + 1
            }
          }
        end

        it 'does not create an article' do
          expect { post :create, invalid_params }.not_to change { Article.count }
        end
      end
    end
  end

  describe '#edit' do
    context 'user is not signed in' do
      let(:article) { create :article }

      before(:each) { get :edit, id: article.id }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create :user }

      before(:each) do
        sign_in user
        get :edit, id: article.id
      end

      context 'user edits his article' do
        let(:article) { create :article, user: user }

        it 'responds with 200' do
          expect(response.status).to eq(200)
        end
      end

      context 'user edits not his article' do
        let(:article) { create :article }

        it 'redirects to home page' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe '#update' do
    context 'user is not signed in' do
      let(:article) { create :article }

      before(:each) { put :update, id: article.id }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create :user }
      let(:params) do
        {
          id: article.id,
          article: {
            title: 'New title'
          }
        }
      end

      before(:each) { sign_in user }

      context 'user edits his article' do
        let(:article) { create :article, user: user }

        context 'with valid parameters' do
          before(:each) { put :update, params }

          it 'updates the article' do
            expect(article.reload.title).to eq('New title')
          end

          it 'redirects to article page' do
            expect(response).to redirect_to(article)
          end
        end

        context 'with invalid parameters' do
          let(:invalid_params) do
            {
              id: article.id,
              article: {
                title: ''
              }
            }
          end

          before(:each) { put :update, invalid_params }

          it 'does not update the article' do
            expect(article.reload.title).not_to eq('New title')
          end

          it 'renders form' do
            expect(response).to render_template(:edit)
          end
        end
      end

      context 'user edits not his article' do
        let(:article) { create :article }

        it 'does not change the article' do
          expect(article.reload).not_to eq('New title')
        end
      end
    end
  end

  describe '#destroy' do
    context 'user is not signed in' do
      let(:article) { create :article }

      before(:each) { delete :update, id: article.id }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      let(:user) { create :user }

      before(:each) { sign_in user }

      context 'user deletes his article' do
        let!(:article) { create :article, user: user }

        it 'deletes the article' do
          expect { delete :destroy, id: article.id }.to change { Article.count }.by(-1)
        end

        it 'redirects to home page' do
          delete :destroy, id: article.id

          expect(response).to redirect_to(root_path)
        end
      end

      context 'user deletes not his article' do
        let!(:article) { create :article }

        it 'does not delete the article' do
          expect { delete :destroy, id: article.id }.not_to change { Article.count }
        end
      end
    end
  end
end
