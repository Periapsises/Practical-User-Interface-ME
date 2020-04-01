unless joystick
    print "jlib error: Joystick library not loaded (Are you missing the dll?)"
    return

export jlib = {}

jlib.getJoysticks = ->
    joystickList = {}
        for i = 0, 10
            joystickName = joystick.getName i

            if joystickName ~= ""
                joystickList[i] = joystickName

    return joystickList