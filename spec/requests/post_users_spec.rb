describe 'POST /users' do
  context 'without any params' do
    it 'returns 422 status code' do
      post '/users'

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns an error message' do
      post '/users'

      error = JSON[response.body]['error']
      expect(error).to match 'Please provide a request body'
    end
  end

  context 'without a referral' do
    it 'returns 204 status code' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name } }

      expect(response).to have_http_status :no_content
    end

    it 'returns an empty body' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name } }

      expect(response.body).to be_empty
    end

    it 'creates a new user' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name } }

      expect(User.find_by!(name: name)).to be_valid
    end

    it 'does not give the new user any credits' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name } }

      expect(User.find_by!(name: name).credits).to be_zero
    end
  end

  context 'with a referral' do
    it 'gives the new user a $10 credits' do
      referral = FactoryBot.create(:referral)
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name }, referral_id: referral.id }

      new_user = User.find_by!(name: name)
      expect(new_user.credits).to eq 10
    end

    it 'updates the referral referred times count' do
      referral = FactoryBot.create(:referral)
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name }, referral_id: referral.id }

      expect(referral.reload.referred_times).to eq 1
    end
  end

  context 'with the fifth referral' do
    it 'gives the referral user a $10 credits' do
      referral = FactoryBot.create(:referral, referred_times: 4)
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name }, referral_id: referral.id }

      expect(User.find(referral.user_id).credits).to eq 10
    end
  end

  context 'with a referral id which is not in the database' do
    it 'creates a new user' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name }, referral_id: 123 }

      expect(User.find_by!(name: name)).to be_valid
    end

    it 'does not give the new user any credits' do
      name = Faker::Name.unique.name

      post '/users', params: { user: { name: name }, referral_id: 123 }

      expect(User.find_by!(name: name).credits).to be_zero
    end
  end
end
