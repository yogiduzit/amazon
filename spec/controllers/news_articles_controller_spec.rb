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

  describe "#create" do
    context "valid data" do

      it "must redirect to the show page" do
        post(:create, params: {
          news_article: {
            title: "Yogiduzit",
            description: "nfjkdnfsmfnsdmfndsm,f sfsdf s  fnsfnds,fnsdf sfbsjkdfnsd fs fksdbf sdfsdhkfbmsd qekw w"
          }
        })

        expect(response).to redirect_to(news_articles_path(NewsArticle.last))
      end

      it "must create a new entry in the db" do
        before_create = NewsArticle.count

        post(:create, params: {
          news_article: {
            title: "Yogi",
            description: "nfjkdnfsmfnsdmfndsm,f sfsdf s  fnsfnds,fnsdf sfbsjkdfnsd fs fksdbf sdfsdhkfbmsd qekw w"
          }
        })
        after_create = NewsArticle.count

        expect(after_create).to eq(before_create + 1)
      end
    end

    context "invalid data" do
      it "must render the new page" do 
        post(:create, params: {
          news_article: {
            title: nil,
            description: "nfjkdnfsmfnsdmfndsm,f sfsdf s  fnsfnds,fnsdf sfbsjkdfnsd fs fksdbf sdfsdhkfbmsd qekw w"
          }
        })

        expect(response).to(render_template(:new))
      end

      it "must not add an entry to the db" do
        before_create = NewsArticle.count

        post(:create, params: {
          news_article: {
            title: nil,
            description: "nfjkdnfsmfnsdmfndsm,f sfsdf s  fnsfnds,fnsdf sfbsjkdfnsd fs fksdbf sdfsdhkfbmsd qekw w"
          }
        })
        after_create = NewsArticle.count

        expect(after_create).to eq(before_create)
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
end
