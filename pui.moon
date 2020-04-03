export PUI = {}

requiredir "elements/", {"element.lua"}
requiredir "processes/", {"process.lua"}

PUI.mainElements = {}

PUI.curFrame = 0

PUI.onRender = ->
    PUI.curFrame += 1

    for element in *PUI.mainElements
        if element\shouldBeDrawn frameTime
            element\runProcesses!

            elementPos = element.position

            element\preRender PUI.curFrame
            element\onRender elementPos.x, elementPos.y

hook.add "Render", "PUI_OnRender", PUI.onRender