class Fish extends Entity
{
    Target = null
    Tank = null

    constructor(tank, x,y,size = [1,1],sprite = null, speed = 0)
    {
        base.constructor(x,y,size,sprite,speed)
        Tank = tank
    }

    function Idle()
    {
        if (Target == null)
        {

        }
    }

    function Update()
    {
        Vector.Speed = 1
        Target = mouse()
        if (Target != null)
        {
            local adj = (Transform.X + Size[0]*4) - Target[0]
            local op = (Transform.Y + Size[1]*4) -Target[1]
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