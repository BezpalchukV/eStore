class Session < ActiveRecord::Base

  acts_as_voter

  def self.create_or_find_by_ip(ip)
    voter = Session.find_by_user_ip(ip)
    if (voter.present?)
      voter
    else
      Session.create(user_ip: ip)
    end
  end

end