require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    it("requires a title") do
      news_article = NewsArticle.new

      news_article.valid?

      expect(news_article.errors.messages).to(have_key(:title))
    end 

    it("title must be unique ") do
      a = NewsArticle.create(title: "Crazy idiot pushes directly to master", description: "Has been caught")
      b = NewsArticle.new(title: "Crazy idiot pushes directly to master", description: "by the bot police")

      b.valid?

      expect(b.errors.messages).to(have_key(:title))

    end

    it("must contain description") do
      a = NewsArticle.new(title: "Everyone's a gangsta until I covfefe")

      a.valid?

      expect(a.errors.messages).to(have_key(:description))
    end

    it("must be published after creation") do
      a = NewsArticle.new(title: "Now is the time", description: "Oh! yes, it is")

      a.valid?
      expect(a.errors.messages).to(have_key(:published_at))
    end

  end
end
