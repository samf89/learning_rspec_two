class StaticPagesController < ApplicationController

  def about
    logger.debug "-----------------------"
    logger.debug "-----------------------"
    logger.debug "in the about controller action"
    logger.debug "for static pages"
    logger.debug "-----------------------"
    logger.debug "-----------------------"
    @test_variable = Time.now
  end

end
