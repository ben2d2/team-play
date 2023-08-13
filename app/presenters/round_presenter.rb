class RoundPresenter
    def self.presenter(contest, order)
        {
            pre_row: order,
            link: nil,
            avatar: contest.image_url,
            name: contest.name,
            details: "#{contest.max_points_per_attempt * contest.no_of_contest_attempts} pts.",
            size: 60
        }
    end
end