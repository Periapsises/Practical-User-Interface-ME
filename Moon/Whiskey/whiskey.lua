Whiskey = { }
Whiskey.callbacks = { }
Whiskey.on = function(name)
  local call
  call = function(self, func)
    Whiskey.callbacks[name] = func
  end
  return {
    call = call
  }
end
Whiskey.call = function(name, ...)
  return Whiskey.callbacks[name](...)
end
local hooks = {
  "tick",
  "render"
}
for _index_0 = 1, #hooks do
  local hookName = hooks[_index_0]
  hook.add(hookName, "whiskey_" .. hookName, function(...)
    return Whiskey.call(hookName, ...)
  end)
end
