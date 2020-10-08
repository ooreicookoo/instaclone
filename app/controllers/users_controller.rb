class UsersController < ApplicationController
  def new
    @use = User.new
  end
end
