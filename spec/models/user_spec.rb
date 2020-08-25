require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    context "fields" do
      it "should save each field successfully" do
        @test_user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'hi@hi', password: 'password', password_confirmation: 'password')
        expect(@test_user).to be_valid
        expect(@test_user.first_name).to be_present
        expect(@test_user.last_name).to be_present
        expect(@test_user.email).to be_present
        expect(@test_user.password).to be_present
      end
    end

    context "first_name" do
      it 'should produce error without first name' do
        @user = User.new(first_name: nil, last_name: 'hi', email: 'hi@hi', password: 'password', password_confirmation: 'password')
        expect(@user).to_not be_valid
        @user.save
        # puts @user.errors.messages.inspect 
        # ^this prints error message so we know what to include for the expect test
        expect(@user.errors.messages[:first_name]).to include("can't be blank")
      end
    end

    context "last_name" do
      it 'should produce error without last name' do
        @user = User.new(first_name: 'hi', last_name: nil, email: 'hi@hi', password: 'password', password_confirmation: 'password')
        expect(@user).to_not be_valid
        @user.save
        expect(@user.errors.messages[:last_name]).to include("can't be blank")
      end
    end

    context "email" do
      it 'should produce error without email' do
        @user = User.new(first_name: 'hi', last_name: 'hi', email: nil, password: 'password', password_confirmation: 'password')
        expect(@user).to_not be_valid
        @user.save
        expect(@user.errors.messages[:email]).to include("can't be blank")
      end
    end

    context "password" do
      it 'should produce error without password' do
        @user = User.new(first_name: 'hi', last_name: 'hi', email: 'hi@hi', password: nil, password_confirmation: 'password')
        expect(@user).to_not be_valid
        @user.save
        expect(@user.errors.messages[:password]).to include("can't be blank")
      end
    end

    context "password_confirmation" do
      it 'should produce error without password confirm' do
        @user = User.new(first_name: 'hi', last_name: 'hi', email: 'hi@hi', password: 'password', password_confirmation: nil)
        expect(@user).to_not be_valid
        @user.save
        expect(@user.errors.messages[:password_confirmation]).to include("can't be blank")
      end
    end

    context "password matches confirm" do
      it 'should produce error when password does not match confirm' do
        @user = User.new(first_name: 'hi', last_name: 'hi', email: 'hi@hi', password: 'password', password_confirmation: 'notpassword')
        expect(@user).to_not be_valid
        @user.save
        # puts @user.errors.messages.inspect 
        expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
      end
    end

    context "no duplicate emails" do
      it 'should produce error when email already exists' do
        @test_user = User.new(first_name: 'hi', last_name: 'hi', email: 'hi@hi', password: 'password', password_confirmation: 'password')
        @test_user.save
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'HI@hi', password: 'password', password_confirmation: 'password')
        expect(@user).to_not be_valid
        @user.save
        # puts @user.errors.messages.inspect 
        expect(@user.errors.messages[:email]).to include("has already been taken")
      end
    end

    context "password length" do
      it 'should produce error when password length < 8' do
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'HI@hi', password: 'simon', password_confirmation: 'simon')
        expect(@user).to_not be_valid
        @user.save
        # puts @user.errors.messages.inspect 
        expect(@user.errors.messages[:password]).to include("is too short (minimum is 8 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials'  do

    context "user auth success" do
      it 'should let user log in' do
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'hi@hi', password: 'simon123', password_confirmation: 'simon123')
        @user.save
        auth_user = User.authenticate_with_credentials('hi@hi', 'simon123')
        # puts "#{auth_user.inspect}"
        expect(auth_user).to be_truthy
      end
    end

    context "user auth fail" do
      it 'should let stop user from log in with wrong password' do
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'hi@hi', password: 'simon123', password_confirmation: 'simon123')
        @user.save
        auth_user = User.authenticate_with_credentials('hi@hi', 'password')
        # puts "#{auth_user}"
        expect(auth_user).to be false
      end
    end

    context "whitespace" do
      it 'should let user log in with white spaces in email' do
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'hi@hi', password: 'simon123', password_confirmation: 'simon123')
        @user.save
        auth_user = User.authenticate_with_credentials(' hi@hi ', 'simon123')
        # puts "#{auth_user.inspect}"
        expect(auth_user).to be_truthy
      end
    end

    context "caps in email" do
      it 'should let user log in with wrong case in email' do
        @user = User.new(first_name: 'Simon', last_name: 'Jung', email: 'hi@hi', password: 'simon123', password_confirmation: 'simon123')
        @user.save
        auth_user = User.authenticate_with_credentials('HI@hi', 'simon123')
        # puts "#{auth_user.inspect}"
        expect(auth_user).to be_truthy
      end
    end
  end
end
