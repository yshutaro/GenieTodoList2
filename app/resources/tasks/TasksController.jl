module TasksController

using Genie.Renderer
using SearchLight
using Tasks
using Genie.Router
using Genie.Requests

struct Task
  id::Int
  content::String
  done::Bool
end

function index()
  html(:tasks, :tasks, tasks = SearchLight.all(Tasks.Task))
end

function new()
  html(:tasks, :new)
end

function create()
  Tasks.Task(content = @params(:task_content), done = false) |> save && redirect(:get_tasks)
end

end
