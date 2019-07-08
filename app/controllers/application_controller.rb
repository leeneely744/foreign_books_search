class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  
  private
    def my_debug(obj)
      if not obj.nil?
        logger.debug('クラス: ' + obj.class.to_s)
      end
      logger.debug(obj)
    end
end
