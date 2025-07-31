defmodule Hyprdo.Tasks.V1.TasksService.Service do
  use GRPC.Service, name: "hyprdo.tasks.v1.TasksService", protoc_gen_elixir_version: "0.14.1"

  def descriptor do
    # credo:disable-for-next-line
    %Google.Protobuf.ServiceDescriptorProto{
      name: "TasksService",
      method: [
        %Google.Protobuf.MethodDescriptorProto{
          name: "GetOneTask",
          input_type: ".hyprdo.tasks.v1.GetOneTaskRequest",
          output_type: ".hyprdo.tasks.v1.GetOneTaskResponse",
          options: %Google.Protobuf.MethodOptions{
            deprecated: false,
            idempotency_level: :IDEMPOTENCY_UNKNOWN,
            features: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          client_streaming: false,
          server_streaming: false,
          __unknown_fields__: []
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "ListTasks",
          input_type: ".hyprdo.tasks.v1.ListTasksRequest",
          output_type: ".hyprdo.tasks.v1.ListTasksResponse",
          options: %Google.Protobuf.MethodOptions{
            deprecated: false,
            idempotency_level: :IDEMPOTENCY_UNKNOWN,
            features: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          client_streaming: false,
          server_streaming: false,
          __unknown_fields__: []
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "CreateTask",
          input_type: ".hyprdo.tasks.v1.CreateTaskRequest",
          output_type: ".hyprdo.tasks.v1.CreateTaskResponse",
          options: %Google.Protobuf.MethodOptions{
            deprecated: false,
            idempotency_level: :IDEMPOTENCY_UNKNOWN,
            features: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          client_streaming: false,
          server_streaming: false,
          __unknown_fields__: []
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "UpdateTask",
          input_type: ".hyprdo.tasks.v1.UpdateTaskRequest",
          output_type: ".hyprdo.tasks.v1.UpdateTaskResponse",
          options: %Google.Protobuf.MethodOptions{
            deprecated: false,
            idempotency_level: :IDEMPOTENCY_UNKNOWN,
            features: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          client_streaming: false,
          server_streaming: false,
          __unknown_fields__: []
        },
        %Google.Protobuf.MethodDescriptorProto{
          name: "DeleteTask",
          input_type: ".hyprdo.tasks.v1.DeleteTaskRequest",
          output_type: ".google.protobuf.Empty",
          options: %Google.Protobuf.MethodOptions{
            deprecated: false,
            idempotency_level: :IDEMPOTENCY_UNKNOWN,
            features: nil,
            uninterpreted_option: [],
            __pb_extensions__: %{},
            __unknown_fields__: []
          },
          client_streaming: false,
          server_streaming: false,
          __unknown_fields__: []
        }
      ],
      options: nil,
      __unknown_fields__: []
    }
  end

  rpc :GetOneTask, Hyprdo.Tasks.V1.GetOneTaskRequest, Hyprdo.Tasks.V1.GetOneTaskResponse

  rpc :ListTasks, Hyprdo.Tasks.V1.ListTasksRequest, Hyprdo.Tasks.V1.ListTasksResponse

  rpc :CreateTask, Hyprdo.Tasks.V1.CreateTaskRequest, Hyprdo.Tasks.V1.CreateTaskResponse

  rpc :UpdateTask, Hyprdo.Tasks.V1.UpdateTaskRequest, Hyprdo.Tasks.V1.UpdateTaskResponse

  rpc :DeleteTask, Hyprdo.Tasks.V1.DeleteTaskRequest, Google.Protobuf.Empty
end

defmodule Hyprdo.Tasks.V1.TasksService.Stub do
  use GRPC.Stub, service: Hyprdo.Tasks.V1.TasksService.Service
end
