local constants = require("__virtm__.scripts.constants")
local gui_utils = require("__virtm__.scripts.gui.utils")
local util = require("__core__.lualib.util")

local inv_states = constants.inv_platform_states

-- -@class PlatformData
-- -@field index uint platform unique index
-- -@field name string Platform name
-- -@field platform LuaSpacePlatform
-- -@field status uint? defines.space_platform_state
-- -@field has_schedule boolean?
-- -@field location LocalisedString?
-- -@field next string?
-- -@field weight uint
-- -@field contents? { [string]: ItemWithQualityCounts } Contents of the platform


local backend_space = {}

local function new_platform(platform)
  local platform_data
  platform_data = {
    index = platform.index,
    force_index = platform.force.index,
    platform = platform,
    name = platform.name,
    has_schedule = platform.schedule and true or false,
    state = platform.state,
    location = platform.space_location,
    -- weight = platform.weight,
  }
  storage.platforms[platform.index] = platform_data
  return platform_data
end

local function add_log()

end

local function finish_current_log()

end

---Get platform data or create it
---@param platform LuaSpacePlatform
---@return PlatformData?
local function get_or_create_platform_data(platform)
  local platform_data
  if not storage.platforms then
    storage.platforms = {}
  end
  if  storage.platforms[platform.index] then
    platform_data = storage.platforms[platform.index]
  else
    platform_data = new_platform(platform)
  end
  return platform_data
end

function backend_space.init_platforms()
  for _, surface in pairs(game.surfaces) do
    if surface.platform and surface.platform.valid and surface.platform.scheduled_for_deletion == 0 then
      get_or_create_platform_data(surface.platform)
    end
  end
end

---@param event EventData.on_space_platform_changed_state
function backend_space.on_space_platform_changed_state(event)

end

---@param event EventData.on_cargo_pod_finished_ascending
function backend_space.on_cargo_pod_finished_ascending(event)

end

backend_space.events = {
  [defines.events.on_space_platform_changed_state] = backend_space.on_space_platform_changed_state,
  [defines.events.on_cargo_pod_finished_ascending] = backend_space.on_cargo_pod_finished_ascending,
  -- [defines.events.] = ,
  -- [defines.events.] = ,
}
return backend_space
