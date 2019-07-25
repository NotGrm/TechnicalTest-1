# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    private

    def render_bad_request(errors)
      render json: errors.as_json, status: :bad_request
    end
  end
end
