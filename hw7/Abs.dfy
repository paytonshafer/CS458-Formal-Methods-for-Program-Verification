// Payton Shafer CS458: HW7

method abs(A: array<int>, size: nat)
modifies A
requires size <= A.Length
ensures forall x :: 0 <= x < size && old(A[x]) < 0 ==> A[x] == -old(A[x]) // all x in array that are <0 are now = to -old
ensures forall x :: 0 <= x < size && old(A[x]) >= 0 ==> A[x] == old(A[x]) // all x in array there are >=0 are the same
{
  	var i := 0;
		while i < size
		invariant 0 <= i <= size
		invariant forall x :: 0 <= x < i && old(A[x]) < 0 ==> A[x] == -old(A[x]) // all x that have changed that are <0 are now = to -old
		invariant forall x :: 0 <= x < i && old(A[x]) >= 0 ==> A[x] == old(A[x]) // all x that have changed that are >= 0 are same 
		invariant forall x :: i <= x < size ==> A[x] == old(A[x]) // all x we havent changed are still the same
		decreases size - i
		{
			if (A[i] < 0) 
			{
				A[i] := -A[i];
			}
			i := i + 1;
		}
}

method Testing()
{
	var a := new int[10];
	var size := 5;
	a[0],a[1],a[2],a[3],a[4] := 2,-4,6,-3,-2;
	abs(a,5);
	assert a[1] == 4;
}