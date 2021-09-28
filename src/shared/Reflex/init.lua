local MsgService = require(script.MsgService)

local RunService = game:GetService("RunService")
local IsClient = RunService:IsClient()
local IsServer = RunService:IsServer()

-- Used for Communcation between your scripts (Alternative to BindableEvents)
local Self = setmetatable({}, {
  __index = function(_, Index)
    return warn("[Reflex]: Tried to fire " .. Index .. " on Self")
  end
})

return {
  -- Client - Server Communication
  Shared = setmetatable({}, {
    __index = function(_, Index)
      Index = tostring(Index)

      if IsClient then
        -- * Client using server-side functions
        local Event = script:FindFirstChild(Index)
        return function(...)
          Event:FireServer(...)
        end
      elseif IsServer then
        -- * Server using client-side functions
        local Event = script:FindFirstChild(Index)
        return function(Client, ...)
          -- Automatic detection of which to fire
          if typeof(Client) == "Instance" and Client:IsA("Player") then
            Event:FireClient(Client, ...)
          else
            Event:FireAllClients(Client, ...)
          end
        end
      end
    end,

    -- TODO: Add RemoteFunction support
    __newindex = function(_, Index, Value)
      Index = tostring(Index)

      if IsClient then
        -- * Client making functions for the server
        if script:FindFirstChild(Index) then
          local Event = script:FindFirstChild(Index)
          return Event.OnClientEvent:Connect(Value)
        end
      elseif IsServer then
        -- * Server making functions for the client
        if script:FindFirstChild(Index) then
          -- If it already exists, just listen to it
          return script:FindFirstChild(Index).OnServerEvent:Connect(Value)
        else
          -- Make the event if it does not already exist
          local Event = Instance.new("RemoteEvent")
          Event.Name = Index
          Event.Parent = script
          return Event.OnServerEvent:Connect(Value)
        end
      end
    end
  }),

  -- Server - Server Communication
  Server = setmetatable({}, {
    __index = function(_, Index)
      Index = tostring(Index)

      if IsServer then
        return function(...)
          return MsgService:Publish(Index, ...)
        end
      elseif IsClient then
        return warn("[Reflex]: Client - Another Server Communication is not possible, this is the equivalent of trying to use MessagingService from the client")
      end
    end,

    __newindex = function(_, Index, Value)
      Index = tostring(Index)

      if IsServer then
        return MsgService:Subscribe(Index, Value)
      elseif IsClient then
        return warn("[Reflex]: Client - Another Server Communication is not possible, this is the equivalent of trying to use MessagingService from the client")
      end
    end
  }),

  -- Self Communication (Alternative to BindableEvents)
  Self = setmetatable({}, {
    __index = function(_, Index)
      Index = tostring(Index)

      return Self[Index]
    end,

    __newindex = function(_, Index, Value)
      Index = tostring(Index)

      Self[Index] = Value
      return {
        Disconnect = function()
          table.remove(Self, Index)
        end
      }
    end
  }),

  -- TODO: Add client to client communication
  Client = setmetatable({}, {
    __index = function(_, Index)
      Index = tostring(Index)

      if IsClient then
        return warn("[Reflex]: Client - Client Communication is not possible YET")
      elseif IsServer then
        return warn("[Reflex]: Client is reserved for Client - Client Communication, use Shared instead")
      end
    end,
  }),
}