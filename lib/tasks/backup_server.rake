desc "PG Backup"
namespace :pg do
  task :backup => [:environment] do

    require 'aws-sdk'

    # Database Dump
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    backup_file_name = "chicagofood_#{datestamp}_dump.sql.gz"
    backup_file_location = "~/backups/chicagofood/#{backup_file_name}"
    sh "pg_dump chicagofood_production | gzip -c > #{backup_file_location}"
    puts 'File backed up locally.'

    # Save to S3
    backup_file_location_tmp_dir = 'tmp/'
    sh "cp #{backup_file_location} #{backup_file_location_tmp_dir}"
    backup_file_location_tmp = "#{backup_file_location_tmp_dir}#{backup_file_name}"

    credentials = YAML.load(File.read('config/aws.yml'))
    s3 = Aws::S3::Client.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )
    bucket_name = 'ChicagoFood'

    resp = s3.put_object(
      :bucket => bucket_name,
      :key => "backups/#{backup_file_name}",
      :body => IO.read(backup_file_location_tmp)
    )
    puts 'File added to S3.'

  end
end
