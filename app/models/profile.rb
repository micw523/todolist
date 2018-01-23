class Profile < ActiveRecord::Base
  belongs_to :user

  def self.get_all_profiles(yr_min, yr_max)
    Profile.where("birth_year BETWEEN :min_yr AND :max_yr", min_yr: yr_min, max_yr: yr_max).order(:birth_year)
  end

  validate :both_names, :sue_clause
  validates :gender, inclusion: { in: %w[male female] }

  def both_names
    if last_name.nil? && first_name.nil?
      errors.add(:last_name, 'Either last name or first name must be present')
    end
  end

  def sue_clause
    if gender == 'male' && first_name == 'Sue'
      errors.add(:first_name, 'Sue cannot be given to male')
    end
  end

end
