Rails.application.config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :not_found
