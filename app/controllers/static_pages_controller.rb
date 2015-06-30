class StaticPagesController < ApplicationController

  def about
    @test_variable = Time.now
  end

end
