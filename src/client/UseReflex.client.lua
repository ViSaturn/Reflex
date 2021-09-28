local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

while task.wait(0.2) do
  local Thing = Reflex.SharedEvents.CoolFunction("test!")
  print("Client Got:", Thing)
  -- Reflex.Server.NewFunction("hello!")
end