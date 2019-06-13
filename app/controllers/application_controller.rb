class ApplicationController < ActionController::API

  private
    def my_debug(obj)
      if not obj.nil?
        logger.debug('クラス: ' + obj.class.to_s)
      end
      logger.debug(obj)
    end
end
