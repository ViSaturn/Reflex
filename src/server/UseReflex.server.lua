local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

--[[
Reflex.ForClient {
  NewFunction = function(Client, ...)
    print(Client, ...)
  end
}
]]
Reflex.Shared.CoolFunction = function(...)
  print("hi")
  print(...)
end

-- Reflex.Client.NewRemote("hello")