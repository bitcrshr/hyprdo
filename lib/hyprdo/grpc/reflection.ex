defmodule Hyprdo.Reflection.ServerV1 do
  use GrpcReflection.Server,
    version: :v1,
    services: [Hyprdo.Tasks.V1.TasksService.Service]
end

defmodule Hyprdo.Reflection.ServerV1Alpha do
  use GrpcReflection.Server,
    version: :v1alpha,
    services: [Hyprdo.Tasks.V1.TasksService.Service]
end
