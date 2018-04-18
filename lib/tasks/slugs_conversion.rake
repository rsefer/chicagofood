desc "Overhaul conversion"
namespace :slugs do
  task :convert => [:environment] do
    Tag.all.each do |tag|
      tag.update(slug: tag.name.parameterize)
      tag.save!
    end
    Neighborhood.all.each do |neighborhood|
      neighborhood.update(slug: neighborhood.name.parameterize)
      neighborhood.save!
    end
    Venue.all.each do |venue|
      venue.update(slug: venue.name.parameterize)
      venue.save!
    end
  end
end
