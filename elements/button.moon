class Button extends PUI.Pressable
    new: =>
        super!

        @text = ""
        @textColor = Color 255, 255, 255, 255

    setText: (text="") =>
        @text = text

    onRender: (x, y) =>
        render.setColor @color
        render.drawRect x, y, @size.x, @size.h
        render.setColor @textColor
        render.drawSimpleText x + @size.x / 2, y + @size.y / 2, 1, 1