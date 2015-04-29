module ArticleHelpers
  def new_article
    visit root_path
    click_link 'Write an article'
  end

  def expect_to_see_article(article_presenter)
    expect(page).to have_content(article_presenter.title)
    expect(page).to have_content(article_presenter.text)
    expect(page).to have_content(article_presenter.created_at)
    expect(page).to have_content(article_presenter.author)
  end
end
