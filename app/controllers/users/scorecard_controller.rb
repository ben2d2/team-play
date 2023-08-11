class Users::ScorecardController < ApplicationController
  before_action :authenticate_user!
  def index
    @round = 1

    @scorecard = {
      place: "1st",
      avatar: "https://media.istockphoto.com/id/944272094/photo/close-up-of-lion-panthera-leo-8-years-old-in-front-of-white-background.jpg?s=612x612&w=0&k=20&c=wXU4T0sAn27IHJlDAB4VwHXBf_yGJ8SQ5hlCLw4yqrg=",
      avatar_size: 100,
      title: "Lions",
      subtitle: "Bridges/Gonzalez",
      points: 180
    }

    @competition = [
      {
        place: nil,
        avatar: "https://www.acsh.org/sites/default/files/images/shutterstock_134513474.jpg",
        name: "Pandas",
        details: "120 pts"
      },
      {
        place: nil,
        avatar: "https://pyxis.nymag.com/v1/imgs/905/806/9c941ab254519877732edde7a485369567-01-elephants.rsquare.w700.jpg",
        name: "Elephants",
        details: "119 pts"
      },
      {
        place: nil,
        avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzbQf0LrEzu_hHMJ1eJVIn7mrglk07WbKYmA&usqp=CAU",
        name: "Seahorses",
        details: "112 pts"
      },
      {
        place: nil,
        avatar: "https://cdn.outsideonline.com/wp-content/uploads/migrated-images_parent/migrated-images_64/skunk-summer-problem-white-stripes_s.jpg?crop=1:1&width=600&enable=upscale&quality=100",
        name: "Skunks",
        details: "100 pts"
      }
    ]
    render
  end
end