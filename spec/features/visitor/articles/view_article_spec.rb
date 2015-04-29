require 'rails_helper'

feature 'View article' do
  let!(:article) { create :article }
  let(:article_presenter) { ArticlePresenter.wrap(article) }
  let!(:comment) { create :comment, article: article }
  let(:comment_presenter) { CommentPresenter.wrap(comment) }

  before { visit article_path(article) }

  scenario 'I see the article' do
    expect_to_see_article(article_presenter)

    within '.article footer' do
      expect(page).not_to have_link('Edit')
      expect(page).not_to have_link('Delete')
    end
  end

  scenario 'I see comments of the article' do
    expect(page).to have_content('Comments: 1')
    expect_to_see_comment(comment_presenter)
    expect(page).not_to have_css('.comment-form')
  end
end
