theory BinTree
imports Main
begin

(*New datatype for bin tree, only build in are real, int and list*)
(* Of course a tree is either a tip or a Node l val r*)
datatype 'a tree = Tip | Node " 'a tree" 'a " 'a tree"

(* function to mirror a bintree*)
fun mirror :: "'a tree \<Rightarrow> 'a tree" where
  "mirror Tip = Tip" |
  "mirror (Node l a r) = Node (mirror r) a (mirror l)"

(*lemma for two mirrors gives the original*)
lemma "mirror(mirror t) = t"
  apply(induction t)
   apply(auto)
  done

(*2.7 define func preorder and post order to turn btree to list*)
fun preorder :: "'a tree \<Rightarrow> 'a list" where
  "preorder Tip = []" |
  "preorder (Node l a r) = [a] @ (preorder l) @ (preorder r)"

fun postorder :: "'a tree \<Rightarrow> 'a list" where
  "postorder Tip = []" |
  "postorder (Node l a r) = (postorder r) @ (postorder l) @ [a]"

(*2.7 prove pre_order (mirror t) = rev (post_order t)*)

lemma nam0 [simp]:  "x2 # rev (postorder t1) = rev (postorder t1) @ [x2]"
  apply(induction t1)
  apply(auto)

lemma name [simp]: "rev (postorder t2) @ rev (postorder t1) = rev (postorder t1) @ rev (postorder t2)"
  apply(induction t2)
  apply(auto)

lemma "preorder (mirror t) = rev (postorder t)"
  apply(induction t)
   apply(auto)

theorem pre_order_mirror_equals_rev_post_order [simp]:
  "pre_order (mirror t) = rev (post_order t)"
proof (induction t)
  case Tip
  then show ?case by simp
next
  case (Node x left right)
  then show ?case by (simp add: rev_append)
qed

end