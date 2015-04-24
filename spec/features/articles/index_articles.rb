require 'rails_helper'

feature 'Articles index' do
  let!(:article1) { create :article }
  let!(:article2) { create :article }

  before do
    visit root_path
  end

  scenario 'I see articles' do
    expect_to_see_article(article1.decorate)
    expect_to_see_article(article2.decorate)
  end
end
