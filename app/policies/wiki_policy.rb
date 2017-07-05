class WikiPolicy < ApplicationPolicy
  def update?
    if !user
      return false
    else
      true
    end

    if record.private?
      record.user == user || user.role == 'admin'
    else
      true
    end
  end
end
