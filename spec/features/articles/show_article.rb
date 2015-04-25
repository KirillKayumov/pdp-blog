require 'rails_helper'

feature 'Show article' do
  let!(:article) { create :article }
  let!(:comment) { create :comment, article: article }

  before { go_to_article(article.decorate) }

  scenario 'I see an article' do
    expect_to_see_article(article.decorate)
    within '.article footer' do
      expect(page).not_to have_link('Edit')
      expect(page).not_to have_link('Delete')
    end
  end

  scenario 'I see comments' do
    expect(page).to have_content('Comments: 1')
    expect_to_see_comment(comment.decorate)
    expect(page).not_to have_css('.comment-form')
  end

  context 'signed in user' do
    let!(:user) { create :user }
    let!(:article) { create :article, user: user }

    before do
      sign_in user.email, user.password
      go_to_article(article.decorate)
    end

    scenario 'I see control links on my article page' do
      expect_to_see_article(article.decorate)
      within '.article footer' do
        expect(page).to have_link('Edit')
        expect(page).to have_link('Delete')
      end
    end

    scenario 'I see comment form' do
      expect(page).to have_css('.comment-form')
    end
  end
end
