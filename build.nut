//
// Bundle file
// Code changes will be overwritten
//

// title:  game title
// author: game developer
// desc:   short description
// script: squirrel

// [included Timer]

class Timer
{
    StartTime = null
    EndTime = null
    constructor(duration = RAND_MAX)
    {
        EndTime = time() + duration * 1000
    }

    function Finished()
    {
        return time() > EndTime
    }

    function Set(duration)
    {
        EndTime = time() + duration * 1000
    }

    function ToString()
    {
        return EndTime - time()
    }
}
// [/included Timer]
// [included TimerLoop]

class TimerLoop extends Timer
{
    Duration = null
    constructor(duration = RAND_MAX)
    {
        base.constructor(duration)
        Duration = duration
    }

    function Peak()
    {
        local finished = Finished()

        if (finished == true)
        {
            base.Set(Duration)
        }

        return finished
    }
}
// [/included TimerLoop]

// [included Entities.Entity]

class Entity
{
    Transform = null
    Vector = null
    Sprite = null
    Size = null
    CoolDown = null

    constructor(x,y,size = [1,1],sprite = null, speed = 0)
    {
        Transform = {X=x Y=y}
        Vector = {X=0,Y=0,Speed = speed}
        Sprite = sprite
        Size = size
        CoolDown = Timer(RAND_MAX)
    }

    function Draw()
    {
        local centerX = Transform.X - Size[0]*4
        local centerY = Transform.Y - Size[1]*4

        spr(Sprite,centerX,centerY,0,1,0,0,Size[0],Size[1])
        //circ(Transform.X,Transform.Y,1,15)
    }

    function DistanceTo(target)
    {
        local x = fabs(Transform.X - target.X)
        local y = fabs(Transform.Y - target.Y)

        return sqrt(pow(x,2)+pow(y,2))
    }
}
// [/included Entities.Entity]
// [included Coin]

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
// [/included Coin]
// [included Entities.Fish]

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
// [/included Entities.Fish]

// [included UI.Clickable]

class Clickable
{
    Size = null
    X = null
    Y = null

    /*
        Size - array of width and height
    */
    constructor(xpos,ypos,s)
    {
        X=xpos
        Y=ypos
        Size = s
    }

    function A(...)
    {
        return null
    }

    function B(...)
    {
        return null
    }

    function X(...)
    {
        return null
    }

    function Y(...)
    {
        return null
    }


    /*
      Return: 0,1,2,3
      0: No mouse click
      1: Left mouse click
      2: Middle mouse click
      3: Right mouse click
    */
    function Clicked(id)
    {
        return CONTROLLER.Input(id)
    }
}
// [/included UI.Clickable]
// [included UI.Button]

class Button extends Clickable
{
    Sprite = null
    constructor(xpos,ypos,s,sp)
    {
        base.constructor(xpos,ypos,s)
        Sprite=sp
    }

    function Draw()
    {
        spr(Sprite,X,Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        spr(Sprite+32,X,Y,0,1,0,0,Size[0],Size[1])
    }
}
// [/included UI.Button]
// [included Entities.Item]

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
// [/included Entities.Item]
// [included Entities.Items.AddFish]

class AddFish extends Item
{
    function A(...)
    {
        local fishX = rand() % (210-Transform.X-5)
        vargv[0].Fish.push(Fish(vargv[0],Transform.X+fishX+5,35,[2,2],0,1))
    }
}

// [/included Entities.Items.AddFish]

// [included Grids.Grid]

class Node
{
    t = null
    b = null
    r = null
    l = null
    touched = null
    data = null

    constructor()
    {
        t = null
        b = null
        r = null
        l = null
        touched = false
        data = null
    }
}

class Grid
{
    nodes = null
    size = null
    focus = null
    X = null
    Y = null

    constructor()
    {
        nodes = []
        focus = null
        size = 0
    }

    constructor(rows,cols, x = 0, y = 0)
    {
        X = x
        Y = y
        size = 0
        nodes = array(rows)

        local current;
        for (local r = 0; r < rows; r++ )
        {
            nodes[r] = Node()
            size += 1
            current = nodes[r]
            for (local c = 0; c < cols-1; c++ )
            {
                current.r = Node()
                size += 1
                current.r.l = current
                current = current.r
            }
        }

        focus = nodes[0]
    }

    function Draw(focused = true)
    {
        local original = size
        DrawHelp(nodes[0],focused)
        size = original
    }



    function DrawHelp(current,focused)
    {
        if (size == 0 || current == null || current.data == null || current.touched == true)
            return null

        if (current == focus && focused)
            current.data.DrawH()
        else
            current.data.Draw()

        current.touched = true
        size -= 1
        DrawHelp(current.t,focused)
        DrawHelp(current.r,focused)
        DrawHelp(current.b,focused)
        DrawHelp(current.l,focused)
        current.touched = false
    }

    function A(...)
    {
        return null
    }

    function B(...)
    {
        return null
    }

    function X(...)
    {
        return null
    }

    function Y(...)
    {
        return null
    }

    function Des()
    {
        if (focus.b != null)
            focus = focus.b
    }

    function Asc()
    {
        if (focus.t != null)
            focus = focus.t
    }

     function Next()
    {
        if (focus.r != null)
            focus = focus.r
    }

    function Prev()
    {
        if (focus.l != null)
           focus = focus.l
    }
}
// [/included Grids.Grid]
// [included Grids.ItemGrid]

class ItemGrid extends Grid
{
    Tank = null
    constructor(tank)
    {
        Tank = tank

        base.constructor(1,5,38,14)
        local current = nodes[0]
        local c = 0
        for (;current != null; current = current.r)
        {
            current.data = AddFish(c++*20+X,Y,[2,2],480,0)
        }


    }

    function A()
    {
        focus.data.A(Tank)
    }
}
// [/included Grids.ItemGrid]

// [included Grids.Tank]

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
// [/included Grids.Tank]


local tank = Tank()
function TIC()
{
	cls(13)


	tank.Draw()
	tank.UPDATE()
}




// <TILES>
// 000:0000000000000000000000000000000000000000000000000000020000000024
// 001:0000000000000000000000000000000000000000000000004444000066640000
// 004:0000000000000000000000000022000000222000000220440002224400002244
// 005:0000000000000000022000000022000004444000443444004344bb404434bb40
// 016:0000002400000024000002000000000000000000000000000000000000000000
// 017:66b4000066640000444000000000000000000000000000000000000000000000
// 020:0000224400002243000222440022200400220000000000000000000000000000
// 021:3444444044443440344344004444300002200000222000002200000000000000
// 224:0000000600000006000000060000000600000006000000060000000600000006
// 225:6600000066000000660000006600000066000000660000006600000066000000
// 240:0000000600000006000666660000666600000666000000660000000600000000
// 241:6600000066000000666666006666600066660000666000006600000060000000
// </TILES>

// <SPRITES>
// 000:0000000000000000000000000000006600000677000067740000674700006747
// 001:0000000000000000000000006660000047760000447760004777600047776000
// 016:0000674700006774000006770000006600000000000000000000000000000000
// 017:4777600044776000477600006660000000000000000000000000000000000000
// 032:0000000000000000000000000000066600006777000677770067776600677677
// 033:0000000000000000000000006660000077760000677760006667760067777600
// 048:0067767700677766006777770067777700067666000067770000066600000000
// 049:6777760066777600676776006767760066776000677600006660000000000000
// 224:0000000000000666000660000060000006000000060000006000000060000000
// 225:0000000066000000006600000000600000000600000006000000006000000060
// 226:0000000000000666000663330063333306333333063333336333333363333333
// 227:0000000066000000336600003333600033333600333336003333336033333360
// 240:6000000060000000600000000600000006000000006000000006600000000666
// 241:0000006000000060000000600000060000000600000060000066000066000000
// 242:6333333363333333633333330633333306333333006333330006633300000666
// 243:3333336033333360333333603333360033333600333360003366000066000000
// </SPRITES>

// <WAVES>
// 000:00000000ffffffff00000000ffffffff
// 001:0123456789abcdeffedcba9876543210
// 002:0123456789abcdef0123456789abcdef
// </WAVES>

// <SFX>
// 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
// </SFX>

// <PALETTE>
// 000:0d01032e021370032df2421bff861c874107ffbd4affff7327ad1d14784308484d1504380a2a940e97c410cee3fffde3
// </PALETTE>

