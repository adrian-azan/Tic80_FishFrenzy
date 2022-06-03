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
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        spr(Spr+2,X,Y,0,1,0,0,Size[0],Size[1])
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }
}