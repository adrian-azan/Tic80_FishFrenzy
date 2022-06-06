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