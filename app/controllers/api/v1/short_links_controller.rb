# frozen_string_literal: true

module Api
  module V1
    class ShortLinksController < Api::V1::BaseController
      def create
        short_url = SecureRandom.uuid[0..5]

        short_url = SecureRandom.uuid[0..5] while ShortLink.exists?(short_url:)

        @short_link = ShortLink.new(link_params)
        @short_link.short_url = short_url
        @short_link.password = SecureRandom.hex(10)

        if @short_link.save
          render json: @short_link, status: :created
        else
          render json: { status: 'unprocessable_entity' }, status: :unprocessable_entity
        end
      end

      def index
        @short_links = ShortLink.all
        render json: @short_links, status: :ok
      end

      def show
        @short_link = ShortLink.find_by(short_url: params[:id])

        if @short_link
          @short_link.update_columns(link_opened: @short_link.link_opened + 1, link_opened_last_time_at: Time.current)

          redirect_to @short_link.original_url, allow_other_host: true
        else
          render json: { status: 'unprocessable_entity' }, status: :unprocessable_entity
        end
      end

      def destroy
        @short_link = ShortLink.find_by(id: params[:id], password: params[:password])

        if @short_link&.destroy
          render json: { message: 'Short link is deleted' }, status: :ok
        else
          render json: { status: 'unprocessable_entity' }, status: :unprocessable_entity
        end
      end

      private

      def link_params
        params.require(:short_link).permit(:original_url)
      end
    end
  end
end
