-- This is a helper ModuleScript for communcating with MessagingService
-- It takes care of error handling and wrapping stuff in pcalls
local MessagingService = game:GetService("MessagingService")
local MsgService = {}

function MsgService:Publish(Name, ...)
  -- * This Args variable is only here because
  -- * for some reason that i'll look into later MessagingService:PublishAsync
  -- * doesnt like it when i give it ... right away so
  local Args = ...
  local function PublishAttempt()
    local Success, Result = pcall(function()
      MessagingService:PublishAsync(Name, Args)
    end)

    return Success, Result
  end

  local MaxAttempts = 5
  local Attempts = 0
  local Success = false
  local Result

  repeat task.wait()
    Success, Result = PublishAttempt()
    Attempts = Attempts + 1
  until Success or Attempts >= MaxAttempts

  if Success then
    return Result
  else
    return warn("[Reflex Server]: Tried " .. tostring(Attempts) .. " attempts to Publish to " .. Name .. " but all attempts failed. MessagingService Error: " .. tostring(Success))
  end
end

function MsgService:Subscribe(Name, OnEventFunction)
  local function SubscribeAttempt()
    local Success, Connection = pcall(function()
      return MessagingService:SubscribeAsync(Name, function(Message)
        OnEventFunction(Message.Data)
      end)
    end)
    return Success, Connection
  end

  local MaxAttempts = 5
  local Attempts = 0
  local Success = false
  local Connection

  repeat task.wait()
    Success, Connection = SubscribeAttempt()
    Attempts = Attempts + 1
  until Success or Attempts >= MaxAttempts

  if Success then
    return Connection
  else
    return warn("[Reflex Server]: Tried " .. tostring(Attempts) .. " attempts to Subscribe to " .. Name .. " but all attempts failed. MessagingService Error: " .. tostring(Connection))
  end
end

return MsgService