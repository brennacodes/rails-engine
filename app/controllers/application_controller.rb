class ApplicationController < ActionController::API
  rescue_from User::NotAuthorized, with: :deny_access
  rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors

  private
    def deny_access
      head :forbidden
    end

    def show_record_errors(exception)
      redirect_back_or_to root_url, alert: exception.record.errors.full_messages.to_sentence
    end
end
