local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

while task.wait(0.2) do
  Reflex.Shared.CoolFunction("test!")
  -- Reflex.Server.NewFunction("hello!")
end