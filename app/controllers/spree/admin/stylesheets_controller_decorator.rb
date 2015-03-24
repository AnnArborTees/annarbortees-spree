require 'digest/sha1'

Spree::Admin::StylesheetsController.class_eval do
  before_filter :expire_cache, only: [:update, :destroy]
  after_filter :sync_asset, only: [:create, :update]

  private

  def expire_cache
    expire_page controller: '/spree/stylesheets', action: 'show', id: params[:id], format: 'css'
  end

  def sync_asset
    if !Rails.application.config.action_controller.asset_host.blank? and defined? AssetSync
      connection = fog_connection
      bucket = connection.directories.get(AssetSync.config.fog_directory)
      key = Digest::SHA1.hexdigest @stylesheet.updated_at.to_s
      bucket.files.create(
          key: "spree/stylesheets/#{@stylesheet.id.to_s}-#{key}.css",
          body: render_to_string(template: 'spree/stylesheets/show.css.erb', format: :css),
          public: true
      )
      redirect_to action: :index
    end
  end

  def fog_connection
    Fog::Storage.new({
                 provider: AssetSync.config.fog_provider,
                 aws_access_key_id: AssetSync.config.aws_access_key_id,
                 aws_secret_access_key: AssetSync.config.aws_secret_access_key,
                 region: AssetSync.config.fog_region
     })
  end
end