# frozen_string_literal: true

module FollowsHelper
  def count_followings(user)
    t('profiles.show.followings') + ' ' + user.followings.count.to_s
  end

  def count_followers(user)
    t('profiles.show.followers') + ' ' + user.followers.count.to_s
  end
end
