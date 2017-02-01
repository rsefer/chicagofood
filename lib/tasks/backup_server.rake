desc "PG Backup"
namespace :pg do
  task :backup => [:environment] do
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    backup_file = "~/backups/chicagofood/chicagofood_#{datestamp}_dump.sql.gz"
    sh "pg_dump chicagofood_production | gzip -c > #{backup_file}"
    sh "aws s3 cp #{backup_file} s3://ChicagoFood/backups/#{backup_file}"
  end
end
