require 'rails_helper'

feature 'Pagination' do
  let!(:article) { create :article }
  let!(:comments) { create_list :comment, 6, article: article }

  before { visit article_path(article) }

  scenario 'I see pagination bar' do
    expect(page).to have_css('.pagination')
  end

  scenario 'I see part of comments on page' do
    find('.next_page').click
    expect_to_see_comment(CommentPresenter.wrap(comments.last))
  end
end
