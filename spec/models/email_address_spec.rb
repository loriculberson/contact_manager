require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
 
	let(:person) do
			Person.new(first_name: 'Alice', last_name: 'Smith')
	end

	let(:email_address) do
			EmailAddress.new(address: "alice@example.com", person_id: 1)
	end

	it 'is a valid email address' do
		expect(email_address).to be_valid
	end

	it 'is invalid without an address' do
		email_address.address = nil
		expect(email_address).not_to be_valid
	end

	it 'is invalid without a person_id' do
		email_address.person_id = nil
		expect(email_address).not_to be_valid
	end

end
