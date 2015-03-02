require 'rails_helper'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe', id: 1) }

  describe 'the phone_numbers' do
    before(:each) do
      person.phone_numbers.create(number: "555-1234")
      person.phone_numbers.create(number: "555-5678")
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click 
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has a links to delete phone number' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
  end

    describe 'the email address' do
      before(:each) do
        person.email_addresses.create(address: "john@example.com")
        person.email_addresses.create(address: "john@awesome.com")
        visit person_path(person)
      end

      it 'shows the email addresses in li tags' do
        person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: "email address")
        end
      end

      it 'has an add email address link' do
        expect(page).to have_link('Add email', href: new_email_address_path(person_id: person.id))
      end

      it 'adds a new email address' do
        page.click_link('Add email')
        page.fill_in('Address', with: 'emily@howdy.com')
        page.click_button('Create Email address')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('emily@howdy.com')
      end

    end
end