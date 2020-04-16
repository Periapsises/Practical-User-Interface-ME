PUI.oldDrawText = render.drawText

render.drawText = (x, y, text) ->
    scale = PUI.currentScale

    textMatrix = Matrix!
    textMatrix\setScale 1 / scale

    render.pushMatrix textMatrix

    PUI.oldDrawText x * scale.x, y * scale.y, text

    render.popMatrix

PUI.oldDrawSimpleText = render.drawSimpleText

render.drawSimpleText = (x, y, text, alignx, aligny) ->
    scale = PUI.currentScale

    textMatrix = Matrix!
    textMatrix\setScale 1 / scale

    render.pushMatrix textMatrix

    PUI.oldDrawSimpleText x * scale.x, y * scale.y, text, alignx, aligny

    render.popMatrix
