class Users::ScorecardController < ApplicationController
    def index
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