local function is_channel_disabled( receiver )
  if not _config.disabled_channels then
    return false
  end

  if _config.disabled_channels[receiver] == nil then
    return false
  end

  return _config.disabled_channels[receiver]
end

local function enable_channel(receiver)
  if not _config.disabled_channels then
    _config.disabled_channels = {}
  end

  if _config.disabled_channels[receiver] == nil then
    return "Haji Bot Off Nabood 😐"
  end
  
  _config.disabled_channels[receiver] = false

  save_config()
  return "Haji On Shod 😐"
end

local function disable_channel( receiver )
  if not _config.disabled_channels then
    _config.disabled_channels = {}
  end
  
  _config.disabled_channels[receiver] = true

  save_config()
  return "Haji Off Shod 😐"
end

local function pre_process(msg)
  local receiver = get_receiver(msg)
  
  if is_sudo(msg) then
    if msg.text == "/bot on" or msg.text == "/Bot on" or msg.text == "!bot on" or msg.text == "!Bot on" then
    
      enable_channel(receiver)
    end
  end

  if is_channel_disabled(receiver) then
    msg.text = ""
  end

  return msg
end

local function run(msg, matches)
  local receiver = get_receiver(msg)
  
  local hash = 'usecommands:'..msg.from.id..':'..msg.to.id
    redis:incr(hash)
  if not is_sudo(msg) then
  return nil
  end
  if matches[1] == 'on' then
    return enable_channel(receiver)
  end
  if matches[1] == 'off' then
    return disable_channel(receiver)
  end
end

return {
  description = "Plugin to manage channels. Enable or disable channel.", 
  usage = {
    "/channel enable: enable current channel",
    "/channel disable: disable current channel" },
  patterns = {
    "^[!/][Bb]ot (on)",
    "^[!/][Bb]ot (off)" }, 
  run = run,
  moderated = true,
  pre_process = pre_process
}