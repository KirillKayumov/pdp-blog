require 'rails_helper'

feature 'Articles list' do
  let!(:articles) { create_list :article, 2 }
  let!(:articles_presenter) { ArticlePresenter.wrap(articles) }

  before { visit root_path }

  scenario 'I see articles' do
    articles_presenter.each do |article|
      expect_to_see_article(article)
      expect(page).to have_content("comments: #{article.comments_count}")
    end
  end
end
