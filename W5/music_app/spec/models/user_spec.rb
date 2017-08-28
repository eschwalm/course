require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: 'test_dummy@email.com', password: 'secure_password')}
  # validations
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  #is_password?, #reset_session_token, and ::find_by_credentials.
  describe '#is_password?' do
    it 'checks if a password is correct' do
      expect(user.is_password?('secure_password')).to be true
    end
    it 'checks if a password is incorrect' do
      expect(user.is_password?('wrong_password')).to be false
    end
  end

  describe '#reset_session_token!' do

    it 'changes the user\'s session token' do
      old_token = user.session_token
      user.reset_session_token!

      expect(old_token).to_not eq(user.session_token)
    end
    it 'returns the new session token' do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    before { user.save! }
    
    it 'finds a user with valid credentials' do
      expect(User.find_by_credentials('test_dummy@email.com', 'secure_password')).to eq(user)
    end
    it 'returns nil with invalid credentials' do
      expect(User.find_by_credentials('test_dummy@email.com', 'wrong_password')).to eq(nil)
    end
  end
end
