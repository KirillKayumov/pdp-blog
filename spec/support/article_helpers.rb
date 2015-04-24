module ArticleHelpers
  def new_article
    visit root_path
    click_link 'Write an article'
  end

  def expect_to_see_article(decorated_article)
    expect(page).to have_content(decorated_article.title)
    expect(page).to have_content(decorated_article.text)
    expect(page).to have_content(decorated_article.created_at)
    expect(page).to have_content(decorated_article.user_full_name)
  end
end
