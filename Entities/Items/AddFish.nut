class AddFish extends Item
{
    function A(...)
    {
        local fishX = rand() % (210-Transform.X-5)
        vargv[0].Fish.push(Fish(vargv[0],Transform.X+fishX+5,35,[2,2],0,1))
    }
}
