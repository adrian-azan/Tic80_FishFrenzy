class Entity
{
    X = null
    Y = null
    Vector = null
    Spr = null
    Size = null

    constructor(x,y,size = [1,1],spr = null)
    {
        X = x
        Y = y
        Spr = spr
        Size = size
        Vector = [0,0,0]
    }

    function Draw()
    {
        spr(Spr,X,Y,0,1,0,0,Size[0],Size[1])
    }
}