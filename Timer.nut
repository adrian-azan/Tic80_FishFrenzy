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