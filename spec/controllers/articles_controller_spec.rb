require 'rails_helper'

describe ArticlesController, type: :controller do
  context 'not signed in user' do
    describe '#index' do
      it 'responds with 200' do
        get :index

        expect(response.status).to eq(200)
      end
    end

    describe '#show' do
      let!(:article) { create :article }

      it 'responds with 200' do
        get :show, id: article.id

        expect(response.status).to eq(200)
      end
    end

    describe '#new' do
      it 'redirects to sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#create' do
      it 'redirects to sign in page' do
        post :create, {}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#edit' do
      let!(:article) { create :article }

      it 'redirects to sign in page' do
        get :edit, id: article.id

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#update' do
      let!(:article) { create :article }

      it 'redirects to sign in page' do
        put :update, id: article.id

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#destroy' do
      let!(:article) { create :article }

      it 'redirects to sign in page' do
        delete :destroy, id: article.id

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'signed in user' do
    let!(:user) { create :user }

    before(:each) { sign_in user }

    describe '#index' do
      it 'responds with 200' do
        get :index

        expect(response.status).to eq(200)
      end

      context 'pagination for articles presents' do
        let!(:articles) { create_list :article, 6 }

        it 'exposes part of articles' do
          get :index, page: 2

          expect(controller.all_articles).to eq([articles.first])
        end
      end
    end

    describe '#show' do
      let!(:article) { create :article }

      it 'responds with 200' do
        get :show, id: article.id

        expect(response.status).to eq(200)
      end

      context 'pagination for comments presents' do
        let!(:comments) { create_list :comment, 6, article: article }

        it 'exposes part of comments' do
          get :show, id: article.id, page: 2

          expect(controller.comments).to eq([comments.last])
        end
      end
    end

    describe '#new' do
      it 'responds with 200' do
        get :new

        expect(response.status).to eq(200)
      end
    end

    describe '#create' do
      let(:article) { build :article }

      context 'valid params' do
        let(:params) do
          {
            article: {
              title: article.title,
              text: article.text
            }
          }
        end

        it 'saves the article' do
          expect { post :create, params }.to change { Article.count }.by(1)
        end

        it 'redirects to article page' do
          post :create, params

          expect(response).to redirect_to(root_path)
        end
      end

      context 'invalid article params' do
        let(:params) do
          {
            article: {
              title: '',
              text: ''
            }
          }
        end

        it 'do not save the article' do
          expect { post :create, params }.not_to change { Article.count }
        end

        it 'renders #new' do
          post :create, params

          expect(response).to render_template(:new)
        end
      end
    end

    describe '#edit' do
      before { get :edit, id: article.id }

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

    describe '#update' do
      context 'user edits his article' do
        let(:article) { create :article, user: user }

        before(:each) { put :update, params }

        context 'with valid parameters' do
          let(:params) do
            {
              id: article.id,
              article: {
                title: 'New title'
              }
            }
          end

          it 'updates the article' do
            expect(article.reload.title).to eq('New title')
          end

          it 'redirects to article page' do
            expect(response).to redirect_to(article)
          end
        end

        context 'with invalid parameters' do
          let(:params) do
            {
              id: article.id,
              article: {
                title: ''
              }
            }
          end

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
        let(:params) do
          {
            id: article.id,
            article: {
              title: 'New title'
            }
          }
        end

        before(:each) { put :update, params }

        it 'redirects to root' do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe '#destroy' do
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
