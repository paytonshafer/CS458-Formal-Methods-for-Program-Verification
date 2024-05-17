theory "TypesExc"
imports Main
begin
(*2.1 use value on the following*)
value "1+(2::nat)"
value "1+(2::int)"
value "1-(2::nat)"
value "1-(2::int)"

(*2.2 prove add assoc and communitive*)
fun add :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "add 0 n = n" |
  "add (Suc m) n = Suc (add m n)"

lemma add_assoc [simp]: "add x (add y z) = add (add x y) z"
  apply(induction x)
   apply(auto)
  done

lemma add_zero_rev [simp]: "y = add y 0"
  apply(induction y)
   apply(auto)
  done

lemma add_suc [simp]: "Suc (add y x) = add y (Suc x)" 
  apply(induction y)
   apply(auto)
  done

lemma add_comm [simp]: "add x y = add y x"
  apply(induction x)
   apply(auto)
  done

(*2.2 define function double and prove double m = add m m*)
fun double :: "nat \<Rightarrow> nat" where
  "double m = 2*m"

lemma doub_add_rel [simp]: "double m = add m m"
  apply(induction m)
   apply(auto)
  done

(*2.3 define count to count occ of x in xs and prove count x xs \<le> len xs*)
fun count :: "'a \<Rightarrow> 'a list \<Rightarrow> nat" where
  "count _ Nil = 0" |
  "count x (y # xs) = (if x = y then 1 else 0) + count x xs"

lemma count_lte_len [simp]: "count x xs \<le> length xs"
  apply(induction xs)
   apply(auto)
  done

(*2.5 define rec func sum_upto and prove sum_upto n = n(n+1)/2*)
fun sum_upto :: "nat \<Rightarrow> nat" where
  "sum_upto 0 = 0" |
  "sum_upto n = n + sum_upto (n-1)"

lemma sut_eq [simp]: "sum_upto n = n * (n + 1) div 2"
  apply(induction n)
   apply(auto)
  done

end