class DowngradesController < ApplicationController
  def create
    current_user.update_attribute(:role, 'standard')
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    redirect_to wikis_path
  end
end
