class Tank extends Grid
{
    Items = null
    Fish = null
    Coins = null
    constructor()
    {
        Items = ItemGrid(this)
        focus = Items
        Fish = []
        Coins = []
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

        for (local c = 0; c < Coins.len();c++)
        {
            Coins[c].Draw()
            Coins[c].Update()
            if (Coins[c].CoolDown.Finished())
                Coins.remove(c)
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

    function InTank()
    {
        local transform = {}

        transform.X <- rand() % (200-25) + 30
        transform.Y <- rand() % (125-30) + 30
        return transform
    }

    function AddCoin(transform)
    {
        Coins.push(Coin(transform.X,transform.Y,
        [2,2],256,0.2))
    }
}