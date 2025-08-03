defmodule PbTask do
  alias Hyprdo.Tasks.V1.Task, as: PbTask 
  alias Hyprdo.Model.Task, as: DbTask

  require Logger

  def pb_task(%DbTask{} = db_task) do
    %PbTask{
      id: db_task.id,
      title: db_task.title,
      description: db_task.description,
      created_at: db_task.created_at && Google.Protobuf.from_datetime(db_task.created_at),
      updated_at: db_task.updated_at && Google.Protobuf.from_datetime(db_task.updated_at),
      due_at: db_task.due_at && Google.Protobuf.from_datetime(db_task.due_at),
      status: db_task.status,
      estimated_time: db_task.estimated_time,
      actual_time: db_task.actual_time,
    }
  end

  def db_task(%PbTask{} = pb_task) do
    Logger.info("converting to db: #{inspect(pb_task)}")
    %DbTask{
      id: pb_task.id,
      title: pb_task.title,
      description: pb_task.description,
      created_at: pb_task.created_at && Google.Protobuf.to_datetime(pb_task.created_at),
      updated_at: pb_task.updated_at && Google.Protobuf.to_datetime(pb_task.updated_at),
      due_at: pb_task.due_at && Google.Protobuf.to_datetime(pb_task.due_at),
      status: pb_task.status,
      estimated_time: pb_task.estimated_time,
      actual_time: pb_task.actual_time,
    }
  end

end
