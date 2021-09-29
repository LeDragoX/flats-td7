require 'rails_helper'

describe 'Visitor Log In' do
    it 'successfully' do
        # ARRANGE
        user = User.create!(email: 'john@doe.com', password: '123456789')

        # ACT
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: user.email 
        fill_in 'Senha', with: user.password 
        click_on 'Entrar'

        # ASSERT
        expect(page).to have_content('Logou com sucesso!')
        expect(page).to have_content(user.email)
        expect(page).to have_link('Logout')
        expect(page).not_to have_link('Entrar')
    end
    
end
