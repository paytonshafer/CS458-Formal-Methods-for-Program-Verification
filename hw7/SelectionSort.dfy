// Payton Shafer CS458: HW7

predicate sorted(A: array<int>, i: int, j: int)
reads A
{forall k :: 0 <= i <= k < j < A.Length ==> A[k] <= A[k+1] }

predicate all_smaller(A: array<int>, a: int, b: int, c: int)
reads A
{forall i :: 0 <= a <= i <= b < A.Length && 0 <= c < A.Length ==> A[i] <= A[c]}

method MaxIndex(A: array<int>, size: nat) returns(r: nat)
requires 0 < size <= A.Length
ensures all_smaller(A, 0, size-1, r) // ensure every elem in range is smaller than r
ensures 0 <= r < size // ensure r is in bounds
{
    r := 0;
    var i := 1;
    while i < size
    invariant 0 <= r < i <= size <= A.Length
    invariant all_smaller(A, 0, i-1, r) // ensure every elem we have checked 
    decreases size - i
    {
        if A[r] < A[i]
        {
            r := i;
        }
        i := i + 1;
    }
}

method SelectionSort(A: array<int>)
modifies A
requires A.Length > 0
ensures sorted(A, 0, A.Length-1) // whole array is sorted
ensures multiset(A[..]) == multiset(old(A[..])) // all elems still there
{
    var i := A.Length;
    var m ;
    while i >= 2
    invariant 0 < i <= A.Length
    invariant all_smaller(A, 0, i-1, i) // everything in front of the last elem moved is smaller than it
    invariant sorted(A, i, A.Length-1) // the end of the array is sorted (from i to end)
    invariant multiset(A[..]) == multiset(old(A[..])) // all elems still there
    {
        m := MaxIndex(A,i);
        A[i-1],A[m] := A[m],A[i-1];
        i := i - 1;
    }
}

method Testing()
{
    var a := new int[10];
    var size := 5;
    a[0],a[1],a[2],a[3],a[4] := 2,4,6,4,4;
    SelectionSort(a);
    assert a[2] <= a[3];
}