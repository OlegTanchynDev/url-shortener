# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "admin"
    include Pagy::Backend
  end
end
