class Item extends Entity
{
    ContentSprite = null

    constructor(x,y,s,spr,content)
    {
        base.constructor(x,y,s,spr)
        ContentSprite = content
    }

    function Draw()
    {
        base.Draw()
        spr(ContentSprite,Transform.X,Transform.Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        trace(Sprite)
        spr(Sprite+2,Transform.X,Transform.Y,0,1,0,0,Size[0],Size[1])
        spr(ContentSprite,Transform.X,Transform.Y,0,1,0,0,Size[0],Size[1])
    }
}