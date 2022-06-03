class Entity
{
    Transform = null
    Vector = null
    Sprite = null
    Size = null

    constructor(x,y,size = [1,1],sprite = null, speed = 0)
    {
        Transform = {X=x Y=y}
        Vector = {X=0,Y=0,Speed = speed}
        Sprite = sprite
        Size = size
    }

    function Draw()
    {
        spr(Sprite,Transform.X,Transform.Y,0,1,0,0,Size[0],Size[1])
    }
}