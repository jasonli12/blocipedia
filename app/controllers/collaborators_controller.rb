class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.wiki_id = params[:wiki_id]
    email = params[:collaborator][:user_id]

    if User.where({email: email}).size > 0
      user = User.where({email: email}).first
      @collaborator.user_id = user.id

      if user == @wiki.user
        flash[:alert] = "#{user.email} is the creator of the wiki. They already have the force."
        redirect_to @wiki
      elsif Collaborator.where({wiki_id: params[:wiki_id]}).pluck(:user_id).include?(@collaborator.user_id)
        flash[:alert] = "#{user.email} is already a collaborator."
        redirect_to @wiki
      elsif @collaborator.save
        flash[:notice] = "#{user.email} added successfully as a collaborator."
        redirect_to @wiki
      else
        flash[:alert] = "Failed to add #{user.email} as a collaborator."
        redirect_to @wiki
      end
      
    else
      flash[:alert] = "#{email} is the registered user."
      redirect_to @wiki
    end
  end
  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find(params[:id])
    user = User.find(collaborator.user_id)
    if collaborator.destroy
      flash[:notice] = "#{user.email} was removed as a collaborator."
      redirect_to @wiki
    else
      flash[:alert] = "Failed to remove #{user.email} as a collaborator."
      redirect_to @wiki
    end
  end
end
