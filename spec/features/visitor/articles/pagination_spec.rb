require 'rails_helper'

feature 'Pagination', js: true do
  let!(:articles) do
    (1..10).each { |index| create :article, title: "Article ##{index}" }
  end

  before { visit root_path }

  scenario 'I see first part of articles' do
    (6..10).each do |index|
      expect(page).to have_content("Article ##{index}")
    end
    expect(page).not_to have_content('Article #5')
  end

  scenario 'Loading the next part of articles' do
    page.execute_script 'window.scrollBy(0,10000)'
    wait_for_ajax

    (1..5).each do |index|
      expect(page).to have_content("Article ##{index}")
    end
  end
end
