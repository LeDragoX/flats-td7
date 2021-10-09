require 'rails_helper'

describe "User view own profile" do
    it "from menu" do
        # ARRANGE
        user = User.create!(email: 'user@test.com', password: '123456789')

        # ACT
        visit root_path
        click_on 'Entrar como Locador'
        fill_in 'E-mail', with: user.email 
        fill_in 'Senha', with: user.password
        within 'form' do
            click_on 'Entrar'
        end

        click_on user.email

        # ASSERT
        expect(page).to have_content('Meu Perfil')
        expect(page).to have_link(user.email)
        expect(current_path).to eq my_profile_path
    end
end
