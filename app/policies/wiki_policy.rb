class WikiPolicy < ApplicationPolicy
  def update?
    if !user
      return false
    else
      true
    end

    if record.private?
      record.user == user || user.role == 'admin' || Collaborator.where(wiki_id: record.id).pluck(:user_id).include?(user.id)
    else
      true
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || Collaborator.where(wiki_id: wiki.id).pluck(:user_id).include?(user.id)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || Collaborator.where(wiki_id: wiki.id).pluck(:user_id).include?(user.id)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
