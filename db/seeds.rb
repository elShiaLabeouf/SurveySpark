require "faker"

10.times do
  User.create(name: Faker::Name.name)
end

# [
#   "Are you satisfied with the healthcare system in your country?",
#   "Do you think more actions should be taken to combat climate change?",
#   "Are you satisfied with the quality of education in your country?",
#   "Are you satisfied with the public transportation services in your city?",
#   "Do you believe your government is effectively addressing major issues?",
#   "Do you think there are enough job opportunities in your field?",
#   "Are you satisfied with the speed and reliability of your internet connection?",
#   "Do you feel safe in your neighborhood?",
#   "Do you find the cost of living in your area affordable?",
#   "Do you believe there is social equality in your country?"
# ].each do |question|
#   Survey.create(content: question)
# end
