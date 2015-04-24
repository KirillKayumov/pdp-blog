require 'rails_helper'

feature 'Articles index' do
  let!(:article1) { create :article }
  let!(:article2) { create :article }

  before do
    visit root_path
  end

  scenario 'I see articles' do
    expect(page).to have_content(article1.title)
    expect(page).to have_content(article2.title)
  end
end
