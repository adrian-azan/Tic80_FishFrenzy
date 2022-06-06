class Fish extends Entity
{
    Target = null
    Tank = null
    Hunger = null
    DropAmount = null
    CoolDown = null

    constructor(tank, x,y,size = [1,1],sprite = null, speed = 0)
    {
        base.constructor(x,y,size,sprite,speed)
        Target = null
        Tank = tank
        Hunger = 0
        DropAmount = 10
        CoolDown = TimerLoop(5)
    }

    function Idle()
    {
        if (Target == null)
        {
            Target = Tank.InTank()
        }

        else
        {
            circ(Target.X,Target.Y,2,2)
        }


        if (CoolDown.Peak())
        {
            Tank.AddCoin(Transform)
        }

        //print(CoolDown.ToString(), Transform.X, Transform.Y+3)
        if (DistanceTo(Target) < 1)
        {
            Target = null
        }
    }

    function Update()
    {
        Vector.Speed = 0.1
        Idle()
        if (Target != null)
        {
            local adj = (Transform.X) - Target.X
            local op = (Transform.Y) -Target.Y
            local hypo = sqrt(pow(adj,2) + pow(op,2))

            local radian = asin(op/hypo)

            // //Check for 2nd/3rd quandrant
            if ((adj >= 0 && op >= 0) || (adj >= 0 && op <= 0))
            {
                radian = (PI/2) + fabs((PI/2)-radian)
            }

            Vector.X = Vector.Speed*cos(radian)
            Vector.Y = -(Vector.Speed*sin(radian))
        }

        Transform.X += Vector.X
        Transform.Y += Vector.Y
    }
}