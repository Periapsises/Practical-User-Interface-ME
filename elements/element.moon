import insert from table

class Element
    new: =>
        @visible = false
        @renderedAt = 0

        @position = Vector 0, 0
        @size = Vector 1, 1

        @color = Color 255, 255, 255, 255

        @processes = {}

        -- Elements that MUST be rendered before
        @frontElements = {}

        insert PUI.elements, @

    --------------------------------------------------
    -- Visibility

    setVisible: (visible=false) =>
        @visible = visible

    preRender: (frameTime) =>
        @renderedAt = frameTime

        for element in *@frontElements
            shouldBeDrawn = element.visible and element.renderedAt < frameTime

            if shouldBeDrawn
                elementPos = element.position

                element\preRender frameTime
                element\onRender elementPos.x, elementPos.y

    onRender: (x, y) =>

    renderBefore: (element) =>
        insert element.frontElements, @

    renderAfter: (element) =>
        insert @frontElements, element

    --------------------------------------------------
    -- Processes

    attachProcess: (process) =>
        if @processes[process.name]
            @processes[process.name].onTerminate!

        process.element = @
        process\onAttachProcess @

        @processes[process.name] = process

    runProcesses: =>
        for processName, process in pairs @processes
            process\onUpdate @

    --------------------------------------------------
    -- Basic element settings

    setPos: (x=0, y=0) =>
        if type(x) == "table"
            size = x
            x = size.x
            y = size.y

        @position = Vector x, y

    getPos: =>
        return @position

    setSize: (w=0, h=0) =>
        if type(w) == "table"
            size = w
            w = size.x
            h = size.y

        @size = Vector w, h

    getSize: =>
        return @size

    setColor: (color=Color(255, 255, 255, 255)) =>
        @color = color

    getColor: =>
        @color

    setAlpha: (alpha=255) =>
        @color.a = alpha

    getAlpha: =>
        @color.a

PUI.Element = Element