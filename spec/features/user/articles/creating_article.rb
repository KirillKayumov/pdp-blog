require 'rails_helper'

feature 'Creating article' do
  let!(:user) { create :user }

  before do
    sign_in user.email, user.password
    click_link 'Write an article'
  end

  scenario 'User saves an articles' do
    fill_form_and_submit(
      :article,
      title: 'My title',
      text: 'Awesome text'
    )

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Article succesfully created.')
    expect_to_see_article(ArticlePresenter.wrap(Article.last))
  end

  scenario 'User saves blank article' do
    fill_form_and_submit(
      :article,
      title: '',
      text: ''
    )

    expect(page).to have_css('.error', text: "can't be blank")
  end
end
