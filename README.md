<h1 align="center">
  Reflex

  [![GitHub issues](https://img.shields.io/github/issues/ViSaturn/Reflex?style=flat-square)](https://github.com/ViSaturn/Reflex/issues)
  [![GitHub license](https://img.shields.io/github/license/ViSaturn/Reflex?style=flat-square)](https://github.com/ViSaturn/Reflex)

  `Reflex is a Library that makes Communication across your Roblox games easier`
</h1>

## Examples of Usage
### Server - Client Communication
```lua
-- Script
local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

Reflex.SharedEvents.ExampleFunction = function(Client, ...)
  print(Client, ...)
end
```
```lua
-- LocalScript
local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

Reflex.SharedEvents.ExampleFunction("Hello!")
```
### Server - Server Communication
```lua
-- 1st Script
local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

Reflex.Server.ExampleFunction = function(...)
  print(...)
end
```
```lua
-- 2nd Script
local Reflex = require(game:GetService("ReplicatedStorage").Reflex)

Reflex.Server.ExampleFunction("Hello!")
```

## Fast Install
### Non-Rojo
Pase this into your command bar:
```lua
game:GetService("InsertService"):LoadAsset(7589816540):GetChildren()[1].Parent = game:GetService("ReplicatedStorage")
```
### Rojo
Under Construction, check back later