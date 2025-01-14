class ImportDataService
  SOURCE_CLASSES = [
    Faker::Quote,
    Faker::Books::Dune,
    Faker::Movies::Avatar,
    Faker::Movies::BackToTheFuture,
    Faker::Movies::Departed,
    Faker::Movies::Ghostbusters,
    Faker::Movies::HarryPotter,
    Faker::Movies::HitchhikersGuideToTheGalaxy,
    Faker::Movies::Hobbit,
    Faker::Movies::Lebowski,
    Faker::Movies::LordOfTheRings,
    Faker::Movies::PrincessBride,
    Faker::Movies::StarWars,
    Faker::Movies::Tron,
    Faker::Movies::VForVendetta,
    Faker::TvShows::AquaTeenHungerForce,
    Faker::TvShows::Archer,
    Faker::TvShows::BigBangTheory,
    Faker::TvShows::BojackHorseman,
    Faker::TvShows::BrooklynNineNine,
    Faker::TvShows::Buffy,
    Faker::TvShows::DrWho,
    Faker::TvShows::DumbAndDumber,
    Faker::TvShows::FamilyGuy,
    Faker::TvShows::FinalSpace,
    Faker::TvShows::Friends,
    Faker::TvShows::GameOfThrones,
    Faker::TvShows::HeyArnold,
    Faker::TvShows::HowIMetYourMother,
    Faker::TvShows::MichaelScott,
    Faker::TvShows::NewGirl,
    Faker::TvShows::RickAndMorty,
    Faker::TvShows::RuPaul,
    Faker::TvShows::Seinfeld,
    Faker::TvShows::SiliconValley,
    Faker::TvShows::Simpsons,
    Faker::TvShows::SouthPark,
    Faker::TvShows::Spongebob,
    Faker::TvShows::Stargate,
    Faker::TvShows::StrangerThings,
    Faker::TvShows::Suits,
    Faker::TvShows::TheExpanse,
    Faker::TvShows::TheFreshPrinceOfBelAir,
    Faker::TvShows::TheITCrowd,
    Faker::TvShows::TwinPeaks,
    Faker::TvShows::VentureBros
  ].freeze

  def self.sample
    SOURCE_CLASSES.sample.quote
  end
end

class Faker::Quote
  SOURCE = %i[jack_handey matz most_interesting_man_in_the_world yoda mitch_hedberg fortune_cookie].freeze

  def self.quote
    Faker::Quote.send(SOURCE.sample)
  end
end
