require 'test_helper'
require 'pry'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    [:title, :description, :image_url, :price].each do |key|
      assert product.errors[key].any?
    end
  end

  test "product price must be positive" do
    product = Product.new(title: "My little book",
                          description: "yyy",
                          image_url: "zzz.gif")

    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0

    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    assert product.invalid?

    product.price = 250

    assert product.valid?
  end

  def new_product_image(image_url)
    Product.new(title: "My little book",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{ fred.doc fred.gif/more fred.gif.more}

    ok.each do |item|
      assert new_product_image(item).valid?, "#{item} should be a valid image_url"
    end

    bad.each do |item|
      assert new_product_image(item).invalid?, "#{item} shouldn't be a valid image_url"
    end
  end

  test "product is not valid unless it has unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: 'abc',
                          price: 1,
                          image_url: 'lorem.jpg')
    assert product.invalid?
    assert_equal I18n.translate('errors.messages.taken'), product.errors.messages[:title].first
  end

  test "product title have correct length" do
    product = Product.new(
                         title: 'a',
                         price: 1,
                         description: 'abcedf',
                         image_url: 'lorem.jpg'
    )

    assert product.invalid?
    assert_equal "title is too short", product.errors[:title].first
    product.title = 'ttttttttttiiiiiiiiiittttttttttllllllllleeeeeeeeee toooooooooo long'
    assert product.invalid?
    assert_equal "title is too long", product.errors[:title].first

    product.title = 'abcedf'
    assert product.valid?

  end
end
