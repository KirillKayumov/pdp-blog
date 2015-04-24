require 'rails_helper'

feature 'Edit article' do
  let(:user) { create :user }

  before(:each) do
    sign_in user.email, user.password
    visit article_path(article)
  end

  context 'Article of signed in user' do
    let(:article) { create :article, user: user }

    scenario 'User edits the article' do
      click_link 'Edit'
      fill_form_and_submit(
        :article,
        title: 'New title'
      )

      expect(page).to have_content('Article succesfully updated.')
      expect_to_see_article(article.reload.decorate)
    end
  end

  context 'Article of another user' do
    let(:article) { create :article }

    scenario 'User does not see edit link' do
      expect(page).not_to have_css('a', text: 'Edit')
    end
  end
end
