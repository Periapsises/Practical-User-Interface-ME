class FadeIn extends PUI.Process
    new: =>
        super "fadeout"

        @fadeRate = 0

    setFadeRate: (fadeRate=1) =>
        @fadeRate = fadeRate

    onUpdate: (element) =>
        newAlpha = element\getAlpha! - @fadeRate
        element\setAlpha newAlpha

        if newAlpha >= 255
            element\setAlpha 255
            @endProcess!
