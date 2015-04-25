module CommentHelpers
  def expect_to_see_comment(decorated_comment)
    expect(page).to have_content(decorated_comment.text)
    expect(page).to have_content(decorated_comment.user_full_name)
    expect(page).to have_content(decorated_comment.created_at)
  end
end
