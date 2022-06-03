class ItemGrid extends Grid
{
    Tank = null
    constructor(tank)
    {
        Tank = tank

        base.constructor(1,5,30,7)
        local current = nodes[0]
        local c = 0
        for (;current != null; current = current.r)
        {
            current.data = AddFish(c++*20+X,Y,[2,2],480,0)
        }


    }

    function A()
    {
        trace(Tank)
        focus.data.A(Tank)
    }
}