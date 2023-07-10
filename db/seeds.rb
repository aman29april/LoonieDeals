# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end


categories = %w(
  Autos
  Babies & Kids
  Bags & Luggage
  Books & Magzines
  Clothing & Accessories
  Computers
  Education
  Entertainment
  Finance
  Flowers & Gifts
  Freebies
  Grocery
  Health & Beauty
  Home & Home Improvement
  Movies
  Occasions
  Office & School Supplies
  Other
  Pets
  Phones
  Restaurants
  Services
  Shoes
  Sporting Goods
  Tech & Electronics
  Travel & Vacations
  TV
  Video Games
)
categories.each do |name|
  Category.create!(name: name)
end
