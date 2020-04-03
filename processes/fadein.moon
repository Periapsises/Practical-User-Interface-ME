class FadeIn extends PUI.Process
    new: =>
        super "fadein"

        @fadeRate = 0

    setFadeRate: (fadeRate=1) =>
        @fadeRate = fadeRate

    onAttachProcess: (element) =>
        element\setAlpha 0

    onUpdate: (element) =>
        newAlpha = element\getAlpha! + @fadeRate
        element\setAlpha newAlpha

        if newAlpha >= 255
            element\setAlpha 255
            @endProcess!