require 'rails_helper'

describe ArticlesController, type: :controller do
  describe '#index' do
    let!(:article1) { create :article, created_at: Time.zone.yesterday }
    let!(:article2) { create :article, created_at: Time.zone.now }

    before(:each) { get :index }

    it 'respond with 200' do
      expect(response.status).to eq(200)
    end

    it 'exposes all articles' do
      expect(controller.decorated_articles).to eq([article2, article1])
    end
  end
end
