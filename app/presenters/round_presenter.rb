class RoundPresenter
    def self.presenter(contest, order)
        {
            pre_row: order,
            link: nil,
            avatar: contest.image_url,
            name: contest.name,
            details: contest.location,
            size: 60
        }
    end
end