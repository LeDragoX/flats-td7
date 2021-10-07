require 'rails_helper'

describe 'Visitor log in' do
    context 'as property owner' do
        it 'successfully' do
            # ARRANGE
            property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')

            # ACT
            visit root_path
            click_on 'Entrar como Proprietário do Imóvel'
            fill_in 'E-mail', with: property_owner.email 
            fill_in 'Senha', with: property_owner.password
            within 'form' do
                click_on 'Entrar'
            end

            # ASSERT
            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content(property_owner.email)
            expect(page).to have_link('Logout')
            expect(page).to_not have_link('Entrar como Proprietário do Imóvel')
        end

        it "and Logs out" do
            # ARRANGE
            property_owner = PropertyOwner.create!(email: 'john@doe.com', password: '123456789')

            # ACT
            login_as(property_owner, scope: :property_owner)
            visit root_path
            click_on 'Logout'

            # ASSERT
            expect(page).to have_content('Saiu com sucesso')
            expect(page).to_not have_content(property_owner.email) 
            expect(page).to_not have_link('Logout')
            expect(page).to have_link('Entrar como Proprietário do Imóvel')
            expect(page).to_not have_link('Cadastrar Imóvel')
        end
        
        it "and create an account" do 
        end
    end
    
    context "as user" do
        it 'successfully' do
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

            # ASSERT
            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content(user.email)
            expect(page).to have_link('Logout')
            expect(page).to_not have_link('Entrar como Locador')
            expect(page).to_not have_link('Cadastrar Imóvel')
        end

        it "and Logs out" do
            # ARRANGE
            user = User.create!(email: 'user@test.com', password: '123456789')

            # ACT
            login_as(user, scope: :user)
            visit root_path
            click_on 'Logout'

            # ASSERT
            expect(page).to have_content('Saiu com sucesso')
            expect(page).to_not have_content(user.email)
            expect(page).to_not have_link('Logout')
            expect(page).to have_link('Entrar como Locador')
        end
    end
end
