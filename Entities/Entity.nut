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
        local centerX = Transform.X - Size[0]*4
        local centerY = Transform.Y - Size[1]*4

        spr(Sprite,centerX,centerY,0,1,0,0,Size[0],Size[1])
        //circ(Transform.X,Transform.Y,1,15)
    }



    function DistanceTo(target)
    {
        local x = fabs(Transform.X - target.X)
        local y = fabs(Transform.Y - target.Y)

        return sqrt(pow(x,2)+pow(y,2))
    }
}