class Users::EventController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @scorecard = {
      place: "1st",
      avatar: "https://media.istockphoto.com/id/944272094/photo/close-up-of-lion-panthera-leo-8-years-old-in-front-of-white-background.jpg?s=612x612&w=0&k=20&c=wXU4T0sAn27IHJlDAB4VwHXBf_yGJ8SQ5hlCLw4yqrg=",
      avatar_size: 100,
      title: "Lions",
      subtitle: "Bridges/Gonzalez",
      points: 180
    }

    @rounds = [
      {
        place: nil,
        avatar: "https://images.8tracks.com/cover/i/000/032/151/beerlympics_flip-7138.jpg?rect=0,4,410,410&q=98&fm=jpg&fit=max",
        name: "Flip Cup",
        details: "40 pts",
        size: 60
      },{
        place: nil,
        avatar: "https://mykiddocare.com/cdn/shop/files/reusablewaterballlons_1800x1800.jpg?v=1688981316",
        name: "Water Balloon",
        details: "23 pts",
        size: 60
      },{
        place: nil,
        avatar: "data:image/jpeg;base64,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",
        name: "Spear Throw",
        details: "12 pts",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "Tug-o-War",
        details: "Next Round",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      },{
        place: nil,
        avatar: "",
        name: "",
        details: "",
        size: 60
      }
    ]

    render
  end
end