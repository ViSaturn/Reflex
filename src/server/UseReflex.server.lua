local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

--[[
Reflex.ForClient {
  NewFunction = function(Client, ...)
    print(Client, ...)
  end
}
]]
Reflex.SharedEvents.CoolFunction = function(...)
  print("The Server Got:", ...)
  return "the server's response"
end

-- Reflex.Client.NewRemote("hello")