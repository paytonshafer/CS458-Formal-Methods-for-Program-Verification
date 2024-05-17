// Payton Shafer; CS458; Assignement 5

// The correct_guess predicate takes four parameters:
// the two guesses, the correct price, and the value the function returns.
// Inside the curly braces should be a logical statetment that evaluates
// to true if the function returns the correct value, and false if it doesn't.
// The body of the predicate now says "true". Please modify it appropriately. 
predicate correct_guess(guess1: int, guess2: int, price: int, r: int)
// Three cases: r = g1, r = g2, r = -1
{
    (r == guess1 && guess1 <= price && (guess1 >= guess2 || guess2 > price)) ||
    (r == guess2 && guess2 <= price && (guess2 >= guess1 || guess1 > price)) ||
    (r == -1 && guess1 > price && guess2 > price)
}

// All the following functions take three parameters:
// the two guesses and the correct price.
// The intention is to return the value required by the assignment.
// They may or may not be correct.
// Do not change the first three functions.
// Modify the body of the fourth function to make it work properly.

// Number of paths through guess_price1:
// 3 paths 

// Values for which guess_price1 returns the wrong answer:
// guess1 = 3, guess2 = 1, price = 2, r = -1

// Result of bubbling up postcondition for path taken by above values:
// FALSE
// [(g1 > 0 && g2 > 0 && p > 0 && (g1 > p || g2 > p)) -> correct_guess(g1, g2, p, -1)] {simplification step}
// [(g1 > 0 && g2 > 0 && p > 0) -> (g1 > p || g2 > p) -> correct_guess(g1, g2, p, -1)]
// Assume g1 > 0 && g2 > 0 && p > 0
// [(g1 > p || g2 > p)  -> correct_guess(g1, g2, p, -1)]
// Assume (g1 > p || g2 > p)
// [correct_guess(g1, g2, p, -1)]
// best := -1 
// [correct_guess(g1, g2, p, best)]
// r:= best
// [correct_guess(g1, g2, p, r)]

method guess_price1(guess1: int, guess2: int, price: int) returns (r: int)

requires guess1 > 0 && guess2 > 0 && price > 0
ensures correct_guess(guess1, guess2, price, r)

{
    var best;

    if guess1 <= price && guess2 <= price
    {
        best := guess1;
        if guess2 > best
        {
            best := guess2;
        }
    }
    else 
    {
        best := -1;
    }

    return best;
}

// Number of paths through guess_price2:
// 4 paths 

// Values for which guess_price2 returns the wrong answer:
// guess1 = 3, guess2 = 1, price = 2, r = -1

// Result of bubbling up postcondition for path taken by above values:
// FALSE
// [(g1 > 0 && g2 > 0 && p > 0 && (g2 <= g1 && g1 > p)) -> correct_guess(g1, g2, p, -1)] {simplification step}
// [(g1 > 0 && g2 > 0 && p > 0) -> (g2 <= g1 && g1 > p) -> correct_guess(g1, g2, p, -1)]
// Assume g1 > 0 && g2 > 0 && p > 0
// [(g2 <= g1 && g1 > p) -> correct_guess(g1, g2, p, -1)]
// best := g1
// [(g2 <= best && best > p) -> correct_guess(g1, g2, p, -1)] {simplification step}
// [g2 <= best -> best > p -> correct_guess(g1, g2, p, -1)]
// Assume g2 <= best
// [best > p -> correct_guess(g1, g2, p, -1)]
// Assume best > p
// [correct_guess(g1, g2, p, -1)]
// r:= -1
// [correct_guess(g1, g2, p, r)]

method guess_price2(guess1: int, guess2: int, price: int) returns (r: int)

requires price > 0 && guess1 > 0 && guess2 > 0
ensures correct_guess(guess1, guess2, price, r)

{
    var best := guess1;

    if guess2 > best
    {
        best := guess2;
    }

    if best <= price
    {
        return best;
    }
    else
    { 
        return -1;
    }
}

// Number of paths through guess_price3:
// 3 paths

// Values for which guess_price3 returns the wrong answer:
// guess1 = 1, guess2 = 3, price = 2, r = 3

// Result of bubbling up postcondition for path taken by above values:
// FALSE
// [((g1 > 0 && g2 > 0 && p > 0) && (g1 <= p || g2 <= p) && g2 > g1) -> correct_guess(g1, g2, p, g2)] {simplification step}
// [(g1 > 0 && g2 > 0 && p > 0) -> ((g1 <= p || g2 <= p) && g2 > g1) -> correct_guess(g1, g2, p, g2)]
// Assume g1 > 0 && g2 > 0 && p > 0
// [((g1 <= p || g2 <= p) && g2 > g1) -> correct_guess(g1, g2, p, g2)] {simplification step}
// [(g1 <= p || g2 <= p) -> g2 > g1 -> correct_guess(g1, g2, p, g2)]
// Assume g1 <= p || g2 <= p
// [g2 > g1 -> correct_guess(g1, g2, p, g2)]
// best := g1
// [g2 > best -> correct_guess(g1, g2, p, g2)]
// Assume g2 > best
// [correct_guess(g1, g2, p, g2)]
// best := g2
// [correct_guess(g1, g2, p, best)]
// r := best
// [correct_guess(g1, g2, p, r)]

method guess_price3(guess1: int, guess2: int, price: int) returns (r: int)

requires price > 0 && guess1 > 0 && guess2 > 0
ensures correct_guess(guess1, guess2, price, r)

{
    var best;
 
    if guess1 <= price || guess2 <= price
    {
        best := guess1;
        if guess2 > best
        {
            best := guess2;
        }
    }
    else 
    {
        best := -1;
    }

    return best;
}

// Code for correct method of guess price
method guess_price4(guess1: int, guess2: int, price: int) returns (r: int)

requires price > 0 && guess1 > 0 && guess2 > 0
ensures correct_guess(guess1, guess2, price, r)

{
    var best;

    // Both guess over
    if guess1 > price && guess2 > price
    {
        best := -1;
    }
    // One or more guess under
    else
    {
        if guess1 <= price && (guess1 >= guess2 || guess2 > price)
        {
            best := guess1;
        }
        else
        {
            best := guess2;
        }
    }

    return best;
}