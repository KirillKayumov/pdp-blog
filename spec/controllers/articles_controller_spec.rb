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

      before do
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

      context 'invalid params' do
        let(:invalid_params) do
          {
            article: {
              title: '',
              text: ''
            }
          }
        end

        it 'do not save the article' do
          expect { post :create, invalid_params }.not_to change { Article.count }
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
