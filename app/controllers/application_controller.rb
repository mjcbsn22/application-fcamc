class ApplicationController < ActionController::Base
  add_flash_types :error, :warning, :info, :success, :profile

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


   def object_errors_flash( object )
     object.errors.full_messages.join('<br>').html_safe
   end
end
