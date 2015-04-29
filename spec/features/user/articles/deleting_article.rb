require 'rails_helper'

feature 'Deleting article' do
  let!(:user) { create :user }
  let!(:article) { create :article, user: user }

  before do
    sign_in user.email, user.password
    visit article_path(article)
  end

  scenario 'User deletes the article' do
    click_link 'Delete'

    expect(page).to have_content('Article succesfully deleted.')
  end
end
