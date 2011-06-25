authorization do
  role :guest do
    has_permission_on :articles, :to => :read
    has_permission_on :tags, :to => :read
  end

  role :regular do
    includes :guest
    has_permission_on :articles, :to => [ :new, :create, :autocomplete_tag_name ]
    has_permission_on :articles, :to => [ :edit, :update ] do
      if_attribute :user => is { user }
    end
  end

  role :admin do
    includes :regular
    has_permission_on :articles, :to => :manage
  end
end

privileges do
  privilege :read do
    includes :index, :show
  end 
  privilege :manage do
    includes :read, :new, :create, :edit, :update, :destroy
  end
end
