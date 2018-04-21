desc "Convert types to tags"
namespace :typestags do
  task :convert => [:environment] do
    Tag.all.each do |tag|
      tag.update(tagtype: 'genre')
      tag.save!
    end
  end
end
