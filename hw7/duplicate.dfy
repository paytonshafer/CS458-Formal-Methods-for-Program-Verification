// Payton Shafer CS458: HW7

method Duplicate(A: array<int>) returns(r: bool)
requires  A.Length > 0
ensures r == exists x, y :: 0 <= x < y < A.Length && A[x] == A[y] // r == whether there exists a duplicate in A
{
    var i := 0;
    var j;
    while i < A.Length
    invariant 0 <= i <= A.Length
    invariant forall x, y :: 0 <= x < i && x < y < A.Length ==> A[x] != A[y] // for x in 0 to i and y in x to len all A[x] != A[y]
    decreases A.Length - i
    {
        j := i + 1;
        while j < A.Length
        invariant 0 <= j <= A.Length
        invariant forall x :: i < x < j ==> A[i] != A[x] // for all places we checked there hasnt been a duplicate 
        decreases A.Length - j
        {
            if A[i] == A[j]
            {
                return true;
            }
            j := j + 1;
        }
        i := i + 1;
    }
    return false;
}

method Testing()
{
    var a := new int[5];
    a[0],a[1],a[2],a[3],a[4] := 2,4,6,4,4;
    var r := Duplicate(a);
    assert 0 <= 1 < 3 < a.Length;
    assert a[1] == a[3];
    assert r == true;
}