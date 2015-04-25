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

  def go_to_article(decorated_article)
    visti root_path
    click_link decorated_article.title
  end
end
