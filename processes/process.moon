class Process
    new: (name="process") =>
        @name = name
        @element = nil

    --------------------------------------------------
    -- Starting processes

    onAttachProcess: (element) =>

    --------------------------------------------------
    -- Updating

    onUpdate: (element) =>
        @endProcess!

    --------------------------------------------------
    -- Ending processes

    endProcess: =>
        @onProcessEnd @element
        @element.processes[@name] = nil

    onProcessEnd: (element) =>

    terminateProcess: =>
        @onTerminate @element
        @element.processes[@name] = nil

    onTerminateProcess: (element) =>

PUI.Process = Process