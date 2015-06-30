require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test 'product price must be positive' do
    product = Product.new(title:        'Book Title',
                          description:  'Book description',
                          image_url:     'image.png')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  # нет валидации на уникальность
  test 'product is not valid without a unique title' do
    product = Product.new(title:        products( :apple ).title,
                          description:  'yyy',
                          price:        1,
                          image_url:    'fred.gif' )
    assert product.valid?
  end

end
