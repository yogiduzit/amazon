require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user) 
  end

  describe "#new" do

    context "without signed in user" do
      it "must redirect to the sign in page" do
        get(:new)
        expect(response).to redirect_to new_sessions_path 
      end

      it "sets a danger flash message" do
        get(:new)
        expect(flash[:danger]).to be
      end
    end

    context "with signed in user" do
      before do
        session[:user_id] = current_user.id
      end
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

  describe "#create" do

    def valid_request
      post(:create, params: {
        news_article: FactoryBot.attributes_for(:news_article)
      })
    end

    context "without user signed in" do
      it "redirects to sign in page" do
        valid_request
        expect(response).to redirect_to new_sessions_path
      end
    end

    context "with user signed in" do

      before do
        session[:user_id] = current_user.id 
      end

      context "valid data" do

        it "must redirect to the show page" do
          valid_request

          expect(response).to redirect_to(news_articles_path(NewsArticle.last))
        end

        it "must create a new entry in the db" do
          before_create = NewsArticle.count

          valid_request
          after_create = NewsArticle.count

          expect(after_create).to eq(before_create + 1)
        end
      end

      context "invalid data" do
        def invalid_request
          post(:create, params: {
            news_article: {
              title: nil,
              description: "nfjkdnfsmfnsdmfndsm,f sfsdf s  fnsfnds,fnsdf sfbsjkdfnsd fs fksdbf sdfsdhkfbmsd qekw w"
            }
          })
        end
        it "must render the new page" do 
          invalid_request

          expect(response).to(render_template(:new))
        end

        it "must not add an entry to the db" do
          before_create = NewsArticle.count

          invalid_request
          after_create = NewsArticle.count

          expect(after_create).to eq(before_create)
        end
      end
    end
  end

  describe "#show" do
    it "sets the @news_article variable" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: {
        id: news_article.id
      })

      expect(assigns(:news_article)).to eq(news_article)
    end

    it "must render the show page" do
      news_article = FactoryBot.create(:news_article)

      get(:show, params: {
        id: news_article.id
      })

      expect(response).to render_template(:show)
    end
  end

  describe "#destroy" do
    def delete_request(news_article)
      delete(:destroy, params: {
        id: news_article.id
      })
    end

    context "if user not signed in" do 
      it "redirects to sign in page" do
        news_article = FactoryBot.create(:news_article)
        delete_request(news_article)
        expect(response).to redirect_to new_sessions_path  
      end
    end

    context "if user signed in" do 
      before do
        session[:user_id] = current_user.id
      end
      
      context "as owner" do

        it "must remove the particular entry from database" do
          news_article = FactoryBot.create(:news_article)
          news_article.user = current_user
    
          delete_request(news_article)
    
          # find_by is used instead of find because find gives a runtime
          # error and could halt the execution.
          expect(NewsArticle.find_by(id: news_article.id)).to be(nil)
        end

        it "must redirect to index page" do
          news_article = FactoryBot.create(:news_article)
          delete_request(news_article)
          expect(response).to redirect_to news_articles_path
        end
      end
      context "user not an owner" do
      end
    end




    it "must flash a warning" do
      news_article = FactoryBot.create(:news_article)

      delete_request(news_article)

      expect(flash[:notice]).to be
    end
  end

  describe "#index" do
    it "must sort the articles in ascending order" do
      news_article_a = FactoryBot.create(:news_article)
      news_article_b = FactoryBot.create(:news_article)

      get(:index)

      expect(assigns(:news_articles)).to eq([news_article_a, news_article_b])
    end

    it "must render the index view file" do
      get(:index)

      expect(response).to render_template(:index)
    end
  end

  describe "#edit" do
    def valid_request(news_article) 
      get(:edit, params: {
        id: news_article.id
      })
    end
    context "without signed in" do
      it "redirects to sign in page" do
        news_article = FactoryBot.create(:news_article)
        valid_request(news_article)
        expect(response).to redirect_to new_sessions_path  
      end
    end

    context "with signed in" do 

      before do
        session[:user_id] = current_user.id
      end

      it "must load a news article from database" do
        news_article = FactoryBot.create(:news_article)
        valid_request(news_article)
        expect(assigns(:news_article)).to eq(news_article) 
      end
  
      it "must render the edit view" do
        news_article = FactoryBot.create(:news_article)
  
        valid_request(news_article)
  
        expect(response).to render_template(:edit)
      end
    end

  end

  describe "#update" do
    def valid_request(news_article)
      patch(:update, params: {
        news_article: FactoryBot.attributes_for(:news_article),
        id: news_article.id
      })
    end

    context "without signed in" do
      it "redirects to sign in page" do
        news_article = FactoryBot.create(:news_article)
        valid_request(news_article)
        expect(response).to redirect_to new_sessions_path  
      end
    end

    context "with signed in" do
      before do
        session[:user_id] = current_user.id
      end

      it "redirects to show page" do
        news_article = FactoryBot.create(:news_article)
        valid_request(news_article)
        expect(response).to redirect_to news_article_path(news_article)
      end
    end
  end
end
