export Whiskey = {}

--------------------------------------------------
-- Whiskey's own implementation of hooks system

Whiskey.callbacks = {}

Whiskey.on = ( name ) ->
    call = ( func ) =>
        Whiskey.callbacks[name] = func

    return {call: call}

Whiskey.call = ( name, ... ) ->
    Whiskey.callbacks[name] ...

--------------------------------------------------
-- Convert gmod hooks to Whiskey's callback system

hooks = {
    "tick"
    "render"
}

for hookName in *hooks
    hook.add hookName, "whiskey_" .. hookName, ( ... ) ->
        Whiskey.call hookName, ...