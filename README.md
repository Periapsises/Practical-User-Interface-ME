# Practical User Interface [Moonscript Edition]

The **Practical User Interface** library is made to work with the Garry's Mod **Starfall addon**. It lets you create a UI fast and easely. This is a work in progress and a lot is subject to change.

## Usage

### Elements

Elements are at the heart of the Practical User Interface. They are what makes the library render stuff on your screen.

##### Creating an element

There are many ways of creating a new element object. The first one is by creating an object directly from the default element class.
```
MyElement = PUI.Element!
```
The default element doesn't render anything on the screen as it's just a template. There are some functions you need to define in order to start displaying things on the screen.\
The `onRender` function is called when the element is rendered on the screen. This is where you want to use the `render` library do determine what to draw. This function receives two arguments: `x` and `y`. They are the position of the element. If the element has a parent it will be it's x and y coordinates and if not then they will be `0` and `0`.\
For example if you wanted to draw a rectangle that covers the screen:
```
MyElement.onRender = (x, y) =>
    render.drawRect x, y, 512, 512
```
In order to see the element you must make it visible using `setVisible` like so:
```
MyElement\setVisible true
```
You can pass `false` as an argument to stop displaying the element.

### Processes

Processes are an easy way to automate elements. They can be attached to an element in order to repeat a function each tick until the process ends.

##### Creating a process

Like elements, processes can be created in many ways. Creating a process from the basic process class is very similar as the one of the element. The only exception is that it requires a name when created. if not provided, the name will default to `process`.
```
MyProcess = PUI.Process "SomeProcessName"
```
The default process is also a template and therefore does nothing if you don't define it's `onUpdate` function. This function receives the element to which the process is attached as an argument. See [Attaching processes](#attaching-processes) for further info. One of the many ways a process could be used is by making an element fade in/out of the screen. In this example we make an element fade out and then get removed using the process' `onProcessEnd` function.
```
MyProcess.onUpdate = (element) =>
    newAlpha = element\getAlpha! + 1
    element\setAlpha newAlpha

    if newAlpha == 0
        @endProcess!

MyProcess.onProcessEnd = (element) =>
    element\remove!
```

##### Removing processes

Creating processes is nice, but sometimes you just need to remove them, even from the process itself!\
There are two ways of removing a process. The first one is the most important as it is needed to end a process through the `onUpdate` function.\
Calling `endProcess` will run `onProcessEnd` and detach the process from the element it is attached to. This is the "normal" way of ending a process as it's supposed to be the last thing that happens when a process runs.
```
MyProcess\endProcess!
```
Having a "normal" way to remove processes implies there is an "unusual" way to remove them. This is when you need to terminate a process that has not finished yet. In the example of the alpha fade process above this would be used if the process needs to be forcefully terminated before the alpha has reached 0. Calling `terminateProcess` will run `onTerminateProcess` and detach the process from the element it is attached to. This is useful if you need to change something about the element in case the process has already started but not done yet.
```
MyProcess\terminateProcess!
```

##### Attaching processes

Attaching processes is important as a process only starts running once attached to an element. This is done by calling an element's `attachProcess` function and passing the process as an argument.
```
MyElement\attachProcess MyProcess
```
Once attached, the process will start running and the element it was attached to will be passed as an argument in these functions:
- `onUpdate`
- `onProcessEnd`
- `onTerminate`
