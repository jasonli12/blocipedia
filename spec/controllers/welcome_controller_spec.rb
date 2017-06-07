require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #index" do
    it "renders the index template" do
      user.confirm
      sign_in(user)
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #about" do
    it "renders the about template" do
      user.confirm
      sign_in(user)
      get :about
      expect(response).to render_template(:about)
    end
  end
end
