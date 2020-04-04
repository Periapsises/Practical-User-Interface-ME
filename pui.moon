export PUI = {}

requiredir "elements/", {"element.lua"}
requiredir "processes/", {"process.lua"}

PUI.elements = {}
PUI.pressables = {}

PUI.curFrame = 0

PUI.onRender = ->
    PUI.curFrame += 1

    for element in *PUI.elements
        shouldBeDrawn = element.visible and element.renderedAt < PUI.curFrame

        if shouldBeDrawn
            element\runProcesses!

            elementPos = element.position

            element\preRender PUI.curFrame
            element\onRender elementPos.x, elementPos.y

hook.add "Render", "PUI_OnRender", PUI.onRender

PUI.onInputPressed = (button) ->
    if button == 107
        mouseX, mouseY = render.cursorPos!
        mouseX, mouseY = mouseX or -1024, mouseY or -1024

        mousePos = Vector mouseX, mouseY

        for pressable in *PUI.pressables
            if mousePos\withinAABox pressable.pos, pressable.pos + pressable.size
                pressable.isPressed = true
                pressable\onPressed

PUI.onInputReleased = (button) ->
    if button == 107
        mouseX, mouseY = render.cursorPos!
        mouseX, mouseY = mouseX or -1024, mouseY or -1024

        mousePos = Vector mouseX, mouseY

        for pressable in *PUI.pressables
            pressable.isPressed = false

            if mousePos\withinAABox pressable.pos, pressable.pos + pressable.size
                pressable\onReleased

hook.add "InputPressed", "PUI_OnInputPressed", PUI.onInputPressed
hook.add "InputPressed", "PUI_OnInputReleased", PUI.onInputReleased