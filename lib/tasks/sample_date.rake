#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Populate database with a sample data"
  task populate: :environment do
    make_admin_user
    make_categories
  end
end

def make_admin_user
  email = "admin@example.com"
  password = "123456"
  User.create(email: email, password: password, role: 'admin')
end

def make_categories
  categories = %w[electronics sports clothing travel]
  categories.each { |category| Category.create(title: category) }
end