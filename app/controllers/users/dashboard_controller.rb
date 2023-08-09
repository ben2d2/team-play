class Users::DashboardController < ApplicationController
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
          avatar: "",
          name: "Flip Cup",
          details: "40 pts",
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