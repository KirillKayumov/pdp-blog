module CommentHelpers
  def expect_to_see_comment(comment_presenter)
    expect(page).to have_content(comment_presenter.text)
    expect(page).to have_content(comment_presenter.author)
    expect(page).to have_content(comment_presenter.created_at)
  end
end
