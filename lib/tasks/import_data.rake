require_relative "../services/import_data_service"

namespace "import_data" do
  task faker_data: :environment do
    100.times do |i|
      Survey.insert_all((0..100_000).map { { content: ImportDataService.sample } })
      puts "Inserted #{(i + 1) * 100_000} records"
    end
  end
end
