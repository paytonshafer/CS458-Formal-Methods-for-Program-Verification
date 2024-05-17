// Payton Shafer CS458:HW6

// This method returns 2x
method g(x: int) returns (r: int)
requires x >= 0
ensures r == 2*x
{
    var y := 0;
    var i := 0;
    while i < x
    invariant y == 2*i && i <= x

    // The result of bubbling up on the path from requires to invariant is:
    // [x >= 0 -> 0 == 2*0 && 0 <= x]
    // Assume x >= 0
    // [0 == 2*0 && 0 <= x]
    // y := 0
    // [y == 2*0 && 0 <= x]
    // i := 0
    // [y == 2*i && i <= x]

    // The result of bubbling up on the path from invariant to invariant is:
    // [(y == 2*i && i <= x && i < x) -> y + 2 == 2*i + 2 && i + 1 <= x] {Simplification}
    // [(y == 2*i && i <= x) -> i < x -> y + 2 == 2*i + 2 && i + 1 <= x]
    // Assume y == 2*i && i <= x
    // [i < x -> y + 2 == 2*i + 2 && i + 1 <= x]
    // Assume i < x
    // [y + 2 == 2*i + 2 && i + 1 <= x]
    // y := y + 2
    // [y == 2*i + 2 && i + 1 <= x]
    // i := i + 1
    // [y == 2*i && i <= x]

    // The result of bubbling up on the path from invariant to ensures is:
    // [(y == 2*i && i <= x && i >= x) -> y == 2*x] {Simplification}
    // [(y == 2*i && i <= x) -> i >= x -> y == 2*x]
    // Assume y == 2*i && i <= x
    // [i >= x -> y == 2*x]
    // Assume i >= x
    // [y == 2*x]
    // r := y
    // [r == 2*x]

    decreases x-i
    {
        y := y + 2;
        i := i + 1;
    }
    return y;
}