module Tasks

using SearchLight

export Task

mutable struct Task <: AbstractModel
  ### INTERNALS
  _table_name::String
  _id::String

  ### FIELDS
  id::DbId
  content::String # 追加
  done::Bool      # 追加

  ### constructor
  Task(;
    ### FIELDS
    id = DbId(),
    content = "", # 追加
    done = false  # 追加
  ) = new("tasks", "id",                                                 ### INTERNALS
          id, content, done                                              ### FIELDS
          )
end

function seed()
  SampleTasks = [
    ("塩を買う", true),
    ("簡易書留を出す", false),
    ("本を5冊読む", false)
  ]
  for task in SampleTasks
    Task(content = task[1], done = task[2]) |> SearchLight.save!
  end
end

end
