require 'rails_helper'

feature 'Creating comment', js: true do
  let!(:user) { create :user }
  let!(:article) { create :article }

  before do
    sign_in user.email, user.password
    visit article_path(article)
  end

  scenario 'I send a comment' do
    fill_form_and_submit(
      :comment,
      'comment_text' => 'Awesome comment'
    )

    wait_for_ajax
    expect_to_see_comment(CommentPresenter.wrap(Comment.last))
    expect(page).to have_css('#comments-number', text: '1')
  end

  scenario 'I send blank comment' do
    fill_form_and_submit(
      :comment,
      'comment_text' => ''
    )

    wait_for_ajax
    expect(page).to have_css('.error', text: "can't be blank")
  end
end
