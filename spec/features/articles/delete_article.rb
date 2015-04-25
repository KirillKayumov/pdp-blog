require 'rails_helper'

feature 'Delete article' do
  let(:user) { create :user }

  before(:each) do
    sign_in user.email, user.password
    go_to_article(article.decorate)
  end

  context 'Article of signed in user' do
    let(:article) { create :article, user: user }

    scenario 'User deletes the article' do
      click_link 'Delete'

      expect(page).to have_content('Article succesfully deleted.')
      expect(page).not_to have_content(article.title)
    end
  end

  context 'Article of another user' do
    let(:article) { create :article }

    scenario 'User does not see edit link' do
      expect(page).not_to have_css('a', text: 'Delete')
    end
  end
end
