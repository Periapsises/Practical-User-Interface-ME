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
            element\render PUI.curFrame

hook.add "Render", "PUI_OnRender", PUI.onRender