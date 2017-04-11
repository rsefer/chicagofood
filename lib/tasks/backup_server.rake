desc "PG Backup"
namespace :pg do
  task :backup => [:environment] do

    # Database Dump
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    backup_file_name = "chicagofood_#{datestamp}_dump.sql.gz"
    backup_file_location = "~/backups/chicagofood/#{backup_file_name}"
    sh "pg_dump chicagofood_production | gzip -c > #{backup_file_location}"

    # Save to S3
    AWS.config(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )
    s3 = AWS::S3.new
    bucket_name = 'ChicagoFood'
    bucket = s3.buckets[bucket_name]

    object = bucket.objects[File.basename(backup_file_name)]
    object.write(:file => backup_file_location)
    
  end
end
