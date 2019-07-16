class ProductMailer < ApplicationMailer

  # This will open the hello world view
  def hello_world
    mail(
      to: "itsyog35h@gmail.com",
      from: "info@codecore.ca",
      subject: "Hello World!"
    )
  end

  def new_product(product)

    @product = product
    @product_owner = @product.user

    mail(
      to: @product_owner.email,
      subject: "You created a product named #{@product.title}"
    )

  end
end
