require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it 'must be created with password an password confirmation' do
      @user = User.new(
        :name => "Moe",
        :email => "somthing@test.com",
        :password => nil,
        :password_confirmation => nil
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end
    it 'the password and password confirmation should match' do
      @user = User.new(
        :name => "Moe",
        :email => "somthing@test.com",
        :password => "somthing",
        :password_confirmation => "somthingelse"
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'email must be unique' do
      @user = User.create!(
        :name => "Moe",
        :email => "somthing@test.com",
        :password => "password",
        :password_confirmation => "password"
      )
      @user2 = User.new(
        :name => "Joe",
        :email => "SOMTHING@TEST.COM",
        :password => "password",
        :password_confirmation => "password"
      )
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")

    end
    it 'email shoud be required' do
      @user = User.new(
        :name => "Moe",
        :email => nil,
        :password => "somthing",
        :password_confirmation => "somthing"
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'name sould be required' do
      @user = User.new(
        :name => nil,
        :email => "somthing@test.com",
        :password => "somthing",
        :password_confirmation => "somthing"
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it 'password have minimum length' do
      @user = User.new(
        :name => "moe",
        :email => "somthing@test.com",
        :password => "some",
        :password_confirmation => "some"
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    it "Few spaces before and/or after their email still be authenticated successfully" do
      @user = User.new(
        :name => "moe",
        :email => "somthing@test.com",
        :password => "something",
        :password_confirmation => "something"
      )
      @user.save!
      authenticate = User.authenticate_with_credentials("   somthing@test.com   ","something")
      expect(authenticate).to eq(@user)
    end
    it "Wrong case email still be authenticated successfully" do
      @user = User.new(
        :name => "moe",
        :email => "somThing@test.CoM",
        :password => "something",
        :password_confirmation => "something"
      )
      @user.save!
      authenticate = User.authenticate_with_credentials("somthing@TEST.com","something")
      expect(authenticate).to eq(@user)
    end
  end
end