# frozen_string_literal: true

module Admin
  class ShortLinksController < Admin::BaseController
    def create
      short_url = SecureRandom.uuid[0..5]

      short_url = SecureRandom.uuid[0..5] while ShortLink.exists?(short_url:)

      @short_link = ShortLink.new(link_params)
      @short_link.short_url = short_url
      @short_link.password = SecureRandom.hex(10)

      if @short_link.save
        respond_to do |format|
          format.js { render inline: 'location.reload();' }
        end
      else
        render json: @short_link.errors, status: :unprocessable_entity
      end
    end

    def index
      @pagy, @short_links = if params[:search].present?
                              pagy(ShortLink.where('original_url LIKE ?', "%#{params[:search]}%"), items: 5)
                            else
                              pagy(ShortLink.all, items: 5)
                            end
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
      @short_link = ShortLink.find(params[:id])

      if @short_link&.destroy
        respond_to do |format|
          format.js { render inline: 'location.reload();' }
        end
      else
        render json: { status: 'unprocessable_entity' }, status: :unprocessable_entity
      end
    end

    def cleanup
      ShortLink.where('link_opened_last_time_at <= ?', Time.now - 2.months).destroy_all
      redirect_to admin_short_links_url, notice: 'Old links deleted successfully.'
    end

    private

    def link_params
      params.require(:short_link).permit(:original_url)
    end
  end
end
