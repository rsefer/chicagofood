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

    s3 = Aws::S3::Client.new(
      region: Figaro.env.aws_region,
      credentials: Aws::Credentials.new(Figaro.env.aws_access_key_id, Figaro.env.aws_secret_access_key)
    )
    bucket_name = 'ChicagoFood'

    resp = s3.put_object(
      :bucket => bucket_name,
      :key => "backups/#{backup_file_name}",
      :body => IO.read(backup_file_location_tmp),
			:tagging => 'backupdb=backupdb'
    )
    puts 'File added to S3.'
    sh "rm #{backup_file_location_tmp}"

  end
end
