require 'rails_helper'

feature 'Deleting comment', js: true do
  let!(:user) { create :user }
  let!(:article) { create :article }
  let!(:comment) { create :comment, user: user, article: article }

  before do
    sign_in user.email, user.password
    visit article_path(article)
  end

  scenario 'I delete comment' do
    within "#comment-#{comment.id}" do
      click_link 'Delete'
    end

    wait_for_ajax
    expect(page).not_to have_css("#comment-#{comment.id}")
  end
end
