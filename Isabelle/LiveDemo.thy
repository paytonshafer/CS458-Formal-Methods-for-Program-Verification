theory LiveDemo
imports Main
begin

(*Add function*)
fun add :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "add 0 n = n" |
  "add (Suc m) n = Suc (add m n)"

(*Proof for add is commutative (x + y = y + x) *)

lemma add_zero [simp]: "y = add y 0"
  apply(induction y)
   apply(auto)
  done

lemma add_suc [simp]: "Suc (add y x) = add y (Suc x)"
  apply(induction y)
   apply(auto)
  done

(*Start with this*)
lemma add_comm [simp]: "add x y = add y x"
  apply(induction x)
  apply(auto)
  done







(*Define binary tree*)
datatype 'a tree = Leaf | Node " 'a tree" 'a " 'a tree"

(*Define sum nodes of nat bt function*)
fun sum :: "nat tree \<Rightarrow> nat" where
  "sum Leaf = 0" |
  "sum (Node l x r) = x + sum l + sum r"

(*Simple proof for sum always positive*)
lemma "0 \<le> sum t"
  apply(induction t)
   apply(auto)
  done


end