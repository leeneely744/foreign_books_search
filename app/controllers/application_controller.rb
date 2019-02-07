class ApplicationController < ActionController::Base

  private
    def my_debug(obj)
      logger.debug(obj)
    end
end
