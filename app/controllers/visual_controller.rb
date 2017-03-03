class VisualController < ApplicationController

  def index
    @thesis = Thesis.all
    @thesis.each do |t|
      t.year = 0 if t.year == "unknown"
    end

  end

  private

  def extract_year

  end
end
