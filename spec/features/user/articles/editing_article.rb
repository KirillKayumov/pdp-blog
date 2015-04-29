require 'rails_helper'

feature 'Editing article' do
  let!(:user) { create :user }
  let!(:article) { create :article, user: user }
  let(:article_presenter) { ArticlePresenter.wrap(article) }

  before do
    sign_in user.email, user.password
    visit article_path(article)
    click_link 'Edit'
  end

  scenario 'User edits the article' do
    fill_form_and_submit(
      :article,
      title: 'New title'
    )

    expect(page).to have_content('Article succesfully updated.')
    expect_to_see_article(article_presenter)
  end
end
