module FriendlyIdModelMonkeyPatch
  # Now all of your FriendlyId models will revert to using their ID in ActiveAdmin and their slug everywhere else.
  def to_param
    if caller.to_s.include? 'active_admin'
      id&.to_s
    else
      super
    end
  end
end

module FriendlyId::Model
  prepend FriendlyIdModelMonkeyPatch
end
