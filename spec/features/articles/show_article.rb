require 'rails_helper'

feature 'Show article' do
  let!(:article) { create :article }
  let(:decorated_article) { article.decorate }

  before do
    visit root_path
    click_link article.title
  end

  scenario 'I see an article' do
    expect_to_see_article(decorated_article)
  end
end
