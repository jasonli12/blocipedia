class DowngradesController < ApplicationController
  def create
    current_user.update_attribute(:role, 'standard')
    Wiki.where(user_id: current_user.id).each do |wiki|
      wiki.update_attribute(:private, false)
    end
    redirect_to wikis_path
  end
end
