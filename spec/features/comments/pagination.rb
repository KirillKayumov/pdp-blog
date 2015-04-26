require 'rails_helper'

feature 'Pagination' do
  let!(:article) { create :article }
  let!(:comments) { create_list :comment, 6, article: article }

  scenario 'I see pagination bar' do
    go_to_article(article.decorate)
    expect(page).to have_css('.pagination')
  end
end
