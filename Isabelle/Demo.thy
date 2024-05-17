theory Demo
imports Main
begin

(*add function*)
fun add :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "add 0 n = n" |
  "add (Suc m) n = Suc (add m n)"

(*Proof for add is communitive (x + y = y + x) *)

(*2 come to this for base case*)
lemma add_zero [simp]: "y = add y 0"
  apply(induction y)
   apply(auto)
done

(*3 come to this for inductive*)
lemma add_suc [simp]: "Suc (add y x) = add y (Suc x)" 
  apply(induction y)
   apply(auto)
done

(*1 start with this*)
lemma add_comm [simp]: "add x y = add y x"
  apply(induction x)
   apply(auto)
done

(*Define binary tree*)
datatype 'a tree = Leaf | Node " 'a tree" 'a " 'a tree"

(*Define mirror function*)
fun mirror :: "'a tree \<Rightarrow> 'a tree" where
  "mirror Leaf = Leaf" |
  "mirror (Node l a r) = Node (mirror r) a (mirror l)"

(*Simple proof for double mirror reverts back*)
lemma mir2_bt [simp]: "mirror(mirror t) = t"
  apply(induction t)
   apply(auto)
  done

(*Define sum nodes of nat bt function*)
fun sum :: "nat tree \<Rightarrow> nat" where
  "sum Leaf = 0"|
  "sum (Node l x r) = x + sum l + sum r"

(*Simple proof for sum always positive*)
lemma "0 \<le> sum t"
  apply(induction t)
   apply(auto)
  done

end