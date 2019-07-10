require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  describe "#new" do
    it "must create a new instance variable" do


      get(:new)

      expect(assigns(:news_article)).to be_a_new(NewsArticle)
    end

    it "must render the new view" do 
      get(:new)

      expect(response).to render_template(:new)
    end
  end
end
