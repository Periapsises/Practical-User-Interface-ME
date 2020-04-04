class Pressable extends PUI.Element
    new: =>
        super!

        @isPressed = false

        table.insert PUI.pressables, @

    onPressed: =>

    onReleased: =>