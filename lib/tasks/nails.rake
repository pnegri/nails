namespace :nails do

  desc "Populate Nails with sample reservation data"
  task :fake_reservations => :environment do
    require 'populator'
    Reservation.destroy_all
    (Date.today-3.days..Date.today+3.days).each do |day|
      Reservation.populate(10) do |r|
        r.description = Populator.words(3..6)
        r.kind = Reservation.kinds_of_reservation
        r.status = "Reserved"
        r.start_time = day.beginning_of_day+8.hour..day.beginning_of_day+16.hour
        r.end_time = r.start_time+([*1..4].sample).hour
      end
    end
  end

end
