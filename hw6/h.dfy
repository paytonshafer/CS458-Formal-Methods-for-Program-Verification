// Payton Shafer CS458:HW6

// This method returns y0 + x0/2
method h(x0: int, y0: int) returns (r: int)
requires x0 >= 0 && x0 % 2 == 0
ensures r == y0 + x0/2
{
    var x := x0;
    var y := y0;
    while x > 0
    invariant (x0 - x) == 2*(y - y0) && x >= 0
    decreases x
    {
        x := x - 2;
        y := y + 1;
    }
    return y;
}