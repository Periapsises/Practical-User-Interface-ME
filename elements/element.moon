import insert, remove from table

class Element
    new: =>
        @visible = false
        @renderedAt = 0

        @position = Vector 0, 0
        @size = Vector 1, 1

        @color = Color 255, 255, 255, 255

        @processes = {}

        @parent = nil
        @children = {}

    --------------------------------------------------
    -- Inheritance

    @__inherited: (child) =>
        PUI[child.__name] = child

    --------------------------------------------------
    -- Visibility

    shouldBeDraw: (frameTime) =>
        element.visible and element.renderedAt < frameTime

    setMain: (isMain) =>
        mainElements = PUI.mainElements

        if isMain
            insert mainElements, @
            @id = #mainElements
        elseif @id
            remove mainElements, @id
            @id = nil

    setVisible: (visible=false) =>
        @visible = visible

    render: (frameTime) =>
        @renderedAt = frameTime

        @onRender @position.x, @position.y, @size.x, @size.y

    onRender: (x, y, w, h) =>

    --------------------------------------------------
    -- Parenting

    addChildren: (element) =>
        insert @children, element
        element.parent = @

    parentTo: (element) =>
        element\addChildren @

    renderChildren: =>
        for element in *@children
            if element\shouldBeDrawn frameTime
                element\runProcesses!
                
                elementPos = element.position

                element\preRender frameTime
                element\onRender elementPos.x, elementPos.y

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