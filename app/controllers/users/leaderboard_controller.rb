class Users::LeaderboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @leaders = [
      {
        pre_row: "2nd",
        link: nil,
        avatar: "https://upload.wikimedia.org/wikipedia/commons/8/8a/Bear_Square.JPG",
        avatar_size: 72,
        title: "Bears",
        subtitle: "Hanna/Suffos",
        points: 174
      },
      {
        pre_row: "1st",
        link: nil,
        avatar: "https://media.istockphoto.com/id/944272094/photo/close-up-of-lion-panthera-leo-8-years-old-in-front-of-white-background.jpg?s=612x612&w=0&k=20&c=wXU4T0sAn27IHJlDAB4VwHXBf_yGJ8SQ5hlCLw4yqrg=",
        avatar_size: 100,
        title: "Lions",
        subtitle: "Bridges/Gonzalez",
        points: 180
      },
      {
        pre_row: "3rd",
        link: nil,
        avatar: "https://previews.123rf.com/images/koufax73/koufax731704/koufax73170400015/76840355-penguin-in-close-up-left-side-square-image.jpg",
        avatar_size: 72,
        title: "Penguins",
        subtitle: "Bell/Brackett",
        points: 154
      }
    ]
    @the_rest_of_the_field = [
      {
        pre_row: 4,
        link: nil,
        avatar: "https://www.acsh.org/sites/default/files/images/shutterstock_134513474.jpg",
        name: "Pandas",
        details: "120 pts"
      },
      {
        pre_row: 5,
        link: nil,
        avatar: "https://pyxis.nymag.com/v1/imgs/905/806/9c941ab254519877732edde7a485369567-01-elephants.rsquare.w700.jpg",
        name: "Elephants",
        details: "119 pts"
      },
      {
        pre_row: 6,
        link: nil,
        avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzbQf0LrEzu_hHMJ1eJVIn7mrglk07WbKYmA&usqp=CAU",
        name: "Seahorses",
        details: "112 pts"
      },
      {
        pre_row: 7,
        link: nil,
        avatar: "https://cdn.outsideonline.com/wp-content/uploads/migrated-images_parent/migrated-images_64/skunk-summer-problem-white-stripes_s.jpg?crop=1:1&width=600&enable=upscale&quality=100",
        name: "Skunks",
        details: "100 pts"
      }
    ]
    render
  end
end