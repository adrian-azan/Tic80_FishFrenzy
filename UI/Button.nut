class Button extends Clickable
{
    Sprite = null
    constructor(xpos,ypos,s,sp)
    {
        base.constructor(xpos,ypos,s)
        Sprite=sp
    }

    function Draw()
    {
        spr(Sprite,X,Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        spr(Sprite+32,X,Y,0,1,0,0,Size[0],Size[1])
    }
}