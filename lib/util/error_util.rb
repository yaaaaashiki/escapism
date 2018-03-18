class ErrorUtil
  def self.print_error_info(e)
    Rails.logger.error(e.class)
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace.join("\n"))
  end
end