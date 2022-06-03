//
// Bundle file
// Code changes will be overwritten
//

// title:  game title
// author: game developer
// desc:   short description
// script: squirrel


// [included Entities.Entity]

class Entity
{
    X = null
    Y = null
    Vector = null
    Spr = null
    Size = null

    constructor(x,y,size = [1,1],spr = null)
    {
        X = x
        Y = y
        Spr = spr
        Size = size
        Vector = [0,0,0]
    }

    function Draw()
    {
        spr(Spr,X,Y,0,1,0,0,Size[0],Size[1])
    }
}
// [/included Entities.Entity]
// [included Entities.Fish]

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
        base.Draw()
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        spr(Spr+2,X,Y,0,1,0,0,Size[0],Size[1])
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }
}
// [/included Entities.Item]
// [included Entities.Items.AddFish]

class AddFish extends Item
{



    function A(...)
    {
        local fishX = 50//rand() % (210-X-5)
        vargv[0].Fish.push(Fish(X+fishX+5,35,[2,2],0))
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
// [/included Grids.ItemGrid]

// [included Grids.Tank]

//
// Bundle file
// Code changes will be overwritten
//

// title:  game title
// author: game developer
// desc:   short description
// script: squirrel


// [included Entities.Entity]

class Entity
{
    X = null
    Y = null
    Spr = null
    Size = null

    constructor(x,y,size = [1,1],spr = null)
    {
        X = x
        Y = y
        Spr = spr
        Size = size
    }

    function Draw()
    {
        spr(Spr,X,Y,0,1,0,0,Size[0],Size[1])
    }
}
// [/included Entities.Entity]
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
        base.Draw()
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }

    function DrawH()
    {
        spr(Spr+2,X,Y,0,1,0,0,Size[0],Size[1])
        spr(ContentSprite,X,Y,0,1,0,0,Size[0],Size[1])
    }
}
// [/included Entities.Item]

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

        base.constructor(1,5,30,7)
        local current = nodes[0]
        local c = 0
        for (;current != null; current = current.r)
        {
            current.data = AddFish(c++*20+X,Y,[2,2],480,0)
        }


    }
}
// [/included Grids.ItemGrid]

// [included Grids.Tank]

class Tank extends Grid
{
    Items = null
    Fish = null
    constructor()
    {
        Items = ItemGrid()
        focus = Items
        Fish = []
    }


    function Draw()
    {
        rectb(25,5,210,125,0)
        rectb(25,5,210,20,0)
        Items.Draw()
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

