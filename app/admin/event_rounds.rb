ActiveAdmin.register EventRound do
  permit_params :order, :event_id, :round_type

  index do
    selectable_column
    column :event
    column :order
    column :round_type
    actions
  end

  filter :event_id

  form do |f|
    f.inputs do
      f.input :event_id, as: :select, collection: Event.all
      f.input :order
      f.input :round_type, as: :select, collection: ["Group", "Team"]
    end
    f.actions
  end


  show title: :order do |event_round|
    attributes_table do
      row :order
      row :round_type

      contests = event_round.event_round_contests.map(&:contest)
      contests.each do |contest|
        groups = contest.contest_groups.where(event_round_id: event_round.id)
        attributes_table title: contest.name  do
          row :name do |er|
            link_to contest.name, admin_contest_path(contest)
          end
          row :image do |er|
            image_tag contest.image_url, width: "16px"
          end
          row :groups do |er|
            columns do
              groups.each do |group|
                column do
                  contest_teams = group.contest_group_teams.map {|cgt| cgt.team }
                  div class: 'panel' do
                    h3 group.name
                    div class: 'attributes_table' do
                      table do
                        tr do
                          th 'Name'
                          th 'Image'
                        end
                        contest_teams.each do |team|
                          tr do
                            td team.name
                            td image_tag team.image_url, width: "16px"
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
