class LettersController < ApplicationController
  def index
    @letters = Letter.limit(50);
  end
end