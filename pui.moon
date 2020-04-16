import insert, remove from table

export PUI = {}

requiredir "elements/", {"element.lua"}
requiredir "processes/", {"process.lua"}
requiredir "render/"

PUI.mainElements = {}

PUI.curFrame = 0

PUI.currentScale = Vector 1, 1
PUI.matrixStack = {}

PUI.pushMatrix = (matrix) ->
    insert PUI.matrixStack, matrix
    render.pushMatrix matrix

PUI.popMatrix = ->
    remove PUI.matrixStack
    render.popMatrix

PUI.onRender = ->
    PUI.curFrame += 1

    resolution = Vector render.getResolution!

    scale = resolution / 100

    screenMatrix = Matrix!
    screenMatrix\setScale scale

    PUI.pushMatrix screenMatrix
    PUI.currentScale *= scale

    for element in *PUI.mainElements
        if element\shouldBeDrawn PUI.curFrame
            element\runProcesses!
            element\render PUI.curFrame

    PUI.popMatrix!
    PUI.currentScale /= scale

hook.add "Render", "PUI_OnRender", PUI.onRender
