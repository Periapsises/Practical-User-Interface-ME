export PUI = {}

requiredir "elements/", {"element.lua"}
requiredir "processes/", {"process.lua"}

PUI.mainElements = {}

PUI.curFrame = 0

PUI.onRender = ->
    PUI.curFrame += 1

    resolution = Vector render.getResolution!

    screenMatrix = Matrix!
    screenMatrix\setScale resolution / 100
    render.pushMatrix screenMatrix

    for element in *PUI.mainElements
        if element\shouldBeDrawn frameTime
            element\runProcesses!
            element\render PUI.curFrame

    render.popMatrix!

hook.add "Render", "PUI_OnRender", PUI.onRender