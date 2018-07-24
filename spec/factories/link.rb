FactoryBot.define do
  factory :link do
    link FFaker::Internet.http_url
  end
end
