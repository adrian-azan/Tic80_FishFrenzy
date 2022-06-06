class Coin extends Entity
{

    function Update()
    {
        if (Transform.Y > 125 && Vector.Speed > 0)
        {
            Vector.Speed = 0
            CoolDown.Set(3)
        }

        Transform.Y += Vector.Speed

        //print(CoolDown.ToString(), Transform.X, Transform.Y+3)
    }
}