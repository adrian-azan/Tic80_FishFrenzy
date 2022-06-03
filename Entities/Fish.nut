class Fish extends Entity
{
    Speed = null
    Target = null



    function Update()
    {
        Speed = 1
        Target = mouse()
        if (Target != null)
        {
            local adj = (X + Size[0]*4) - Target[0]
            local op = (Y + Size[1]*4) -Target[1]
            local hypo = sqrt(adj*adj + op*op)

            local angle = asin(op/hypo)
         //   local degree = angle*(180/PI)


            if ((adj >= 0 && op >= 0) || (adj >= 0 && op <= 0))
            {
              //  degree = 90 + abs(90-degree)
                angle = (PI/2) + fabs((PI/2)-angle)

            }

            Vector[0] = Speed*cos(angle)
            Vector[1] = -(Speed*sin(angle))
        }

        X += Vector[0]
        Y += Vector[1]



    }
}