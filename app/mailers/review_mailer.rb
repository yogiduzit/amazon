class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review
    @product = @review.product

    @product_owner = @product.user

    mail(
      to: "itsyog35h@gmail.com",
      subject: "Somebody reviewed your project",
    )
  end
end
