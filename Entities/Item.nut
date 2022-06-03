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
        local centerX = Transform.X - Size[0]*4
        local centerY = Transform.Y - Size[1]*4

        base.Draw()
        spr(ContentSprite,centerX,centerY,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        local centerX = Transform.X - Size[0]*4
        local centerY = Transform.Y - Size[1]*4

        spr(Sprite+2,centerX,centerY,0,1,0,0,Size[0],Size[1])
        spr(ContentSprite,centerX,centerY,0,1,0,0,Size[0],Size[1])
    }
}