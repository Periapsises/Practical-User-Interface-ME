export PUI = {}

requiredir "elements/", {"element.lua"}
requiredir "processes/", {"process.lua"}

PUI.elements = {}

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