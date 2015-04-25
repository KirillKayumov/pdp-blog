require 'rails_helper'

feature 'Creating comment', js: true do
  let!(:user) { create :user }
  let!(:article) { create :article }

  before(:each) do
    sign_in user.email, user.password
    go_to_article(article.decorate)
  end

  scenario 'User sends a comment' do
    fill_form_and_submit(
      :comment,
      'comment_text' => 'Awesome comment'
    )

    wait_for_ajax
    expect_to_see_comment(Comment.last.decorate)
    expect(page).to have_css('#comments-number', text: '1')
  end
end
