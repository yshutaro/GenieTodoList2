module TasksController

using Genie.Renderer
using SearchLight
using Tasks

struct Task
  id::Int
  content::String
  done::Bool
end

function index()
  html(:tasks, :tasks, tasks = SearchLight.all(Tasks.Task))
end

end
