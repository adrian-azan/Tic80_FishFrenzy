class Clickable
{
    Size = null
    X = null
    Y = null

    /*
        Size - array of width and height
    */
    constructor(xpos,ypos,s)
    {
        X=xpos
        Y=ypos
        Size = s
    }

    function A(...)
    {
        return null
    }

    function B(...)
    {
        return null
    }

    function X(...)
    {
        return null
    }

    function Y(...)
    {
        return null
    }


    /*
      Return: 0,1,2,3
      0: No mouse click
      1: Left mouse click
      2: Middle mouse click
      3: Right mouse click
    */
    function Clicked(id)
    {
        return CONTROLLER.Input(id)
    }
}