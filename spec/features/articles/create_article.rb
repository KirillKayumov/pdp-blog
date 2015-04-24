require 'rails_helper'

feature 'Creating article' do
  let!(:user) { create :user }

  context 'Not signed in user' do
    before(:each) do
      new_article
    end

    scenario 'User tries to create article' do
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'Signed in user' do
    before(:each) do
      sign_in user.email, user.password
      new_article
    end

    scenario 'User saves an articles' do
      fill_form_and_submit(
        :article,
        title: 'My title',
        text: 'Awesome text'
      )

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Article succesfully created.')
      expect_to_see_article
    end

    scenario 'User saves blank article' do
      fill_form_and_submit(
        :article,
        title: '',
        text: ''
      )

      expect(page).to have_css('.error', text: "can't be blank")
    end
  end
end
