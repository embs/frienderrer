describe 'POST /referrals' do
  context 'with a proper user id' do
    it 'returns 201 status code' do
      user = FactoryBot.create(:user)

      post '/referrals', params: { referral: { user_id: user.id } }

      expect(response).to have_http_status :created
    end

    it 'creates a referral for the given user' do
      user = FactoryBot.create(:user)

      post '/referrals', params: { referral: { user_id: user.id } }

      expect(Referral.for(user).count).to eq 1
    end

    it 'returns the created referral id' do
      user = FactoryBot.create(:user)

      post '/referrals', params: { referral: { user_id: user.id } }

      body = JSON[response.body].deep_symbolize_keys
      expect(body).to eq({ referral: { id: Referral.for(user).first.id } })
    end
  end

  context 'without any params' do
    it 'returns 422 status code' do
      post '/referrals'

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns an error message' do
      post '/referrals'

      error = JSON[response.body]['error']
      expect(error).to match 'Please provide a request body'
    end
  end

  context 'without the user id param' do
    it 'returns 422 status code' do
      post '/referrals', params: { referral: { user_id: nil } }

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns an error message' do
      post '/referrals', params: { referral: { user_id: nil } }

      error = JSON[response.body]['error']
      expect(error).to match 'Please provide a request body'
    end
  end

  context 'when there is no user with the given user id' do
    it 'returns 404 status code' do
      post '/referrals', params: { referral: { user_id: 0 } }

      expect(response).to have_http_status :not_found
    end

    it 'returns an error message' do
      post '/referrals', params: { referral: { user_id: 0 } }

      error = JSON[response.body]['error']
      expect(error).to eq 'There is no user for the given user id'
    end
  end
end
