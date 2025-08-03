defmodule Hyprdo.GrpcEndpoint do
  use GRPC.Endpoint

  intercept GRPC.Server.Interceptors.Logger

  run(HyprdoStreams.Server)
  run(Hyprdo.Reflection.ServerV1)
  run(Hyprdo.Reflection.ServerV1Alpha)
end
