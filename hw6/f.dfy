// Payton Shafer CS458:HW6

// This method returns y - x0
method f(x0: int,y: int) returns (r: int)
requires x0 <= y
ensures r == y - x0
{
    var x := x0;
    var d := 0;
    while x < y
    invariant x == x0 + d && x <= y

    // The result of bubbling up on the path from requires to invariant is:
    // [(x0 <= y) -> x0 == x0 + 0 && x0 <= y]
    // Assume x0 <= y
    // [x0 == x0 + 0 && x0 <= y]
    // x := x0
    // [x == x0 + 0 && x <= y]
    // d := 0
    // [x == x0 + d && x <= y]

    // The result of bubbling up on the path from invariant to invariant is:
    // [(x == x0 + d && x <= y && x < y) -> x + 1 == x0 + d + 1 && x <= y] {Simplification}
    // [(x == x0 + d && x <= y) -> x < y -> x + 1 == x0 + d + 1 && x <= y]
    // Assume x == x0 + d && x <= y
    // [x < y -> x + 1 == x0 + d + 1 && x <= y]
    // Assume x < y
    // [x + 1 == x0 + d + 1 && x <= y]
    // x := x + 1
    // [x == x0 + d + 1 && x <= y]
    // d := d + 1
    // [x == x0 + d && x <= y]

    // The result of bubbling up on the path from invariant to ensures is:
    // [(x == x0 + d && x <= y && x >= y) -> d == y - x0] {Simplification}
    // [(x == x0 + d && x <= y) -> x >= y -> d == y - x0]   
    // Assume x == x0 + d && x <= y
    // [x >= y -> d == y - x0]   
    // Assume x >= y
    // [d == y - x0]
    // r := d
    // [r == y - x0]
    
    decreases y - x
    {
        x := x + 1;
        d := d + 1;
    }
    return d;
}