class Tank extends Grid
{
    Items = null
    Fish = null
    constructor()
    {
        Items = ItemGrid(this)
        focus = Items
        Fish = []
    }


    function Draw()
    {
        print(Fish.len(),50,50)
        rectb(25,5,210,125,0)
        rectb(25,5,210,20,0)
        Items.Draw()

        foreach (fish in Fish)
        {
            fish.Draw()
            fish.Update()
        }


    }

    function UPDATE()
    {
        if (btnp(0,30,15))
        {
            focus.Asc()
        }

        if (btnp(1,30,15))
        {
            focus.Des()
        }

        if (btnp(2,30,15))
        {
            focus.Prev()
        }

        if (btnp(3,30,15))
        {
            focus.Next()
        }

        if (btnp(4))
        {
            focus.A()
        }

        if (btnp(5))
        {
            focus.B()
        }
    }
}