theory MyList
imports Main
begin

(* The below lines makes it the value can say things like Nil instead of MyList.List.Nil*)
declare [[names_short]]

(* THIS IS A COMMENT *)
(* My defined datatype of a list*)
datatype 'a list = Nil | Cons 'a "'a list"

(* function for appending two lists*)
fun app :: "'a list \<Rightarrow> 'a list \<Rightarrow> 'a list" where
"app Nil ys = ys" |
"app (Cons x xs) ys = Cons x (app xs ys)"

(* function to reverse a list*)
fun rev :: " 'a list \<Rightarrow> 'a list" where
"rev Nil = Nil" |
"rev (Cons x xs) = app (rev xs) (Cons x Nil)"

(*Notes: xs, ys, zs are lists by default*)

value "rev(Cons True(Cons False Nil))"

value "rev(Cons a(Cons b(Cons c Nill)))"

(*we again couldnt not prove the lemma so we need another lemma*)
lemma app_Nil2 [simp]: "app xs Nil = xs"
  apply(induction xs)
   apply(auto)
  done

(*The above lemma helped to get the base case of lemma rev_app but not induction*)
(*What we need is associativity of app, with the lemma below*)
lemma app_assoc [simp]: "app (app xs ys) zs = app xs (app ys zs)"
  apply(induction xs)
   apply(auto)
  done

(*We couldnt prove the below thm so this lemma was suggested*)
lemma rev_app [simp]: "rev(app xs ys) = app (rev ys) (rev xs)"
  apply(induction xs)
   apply(auto)
  done

(*Theorem to prove rev a list twice is the orginal list*)
theorem rev_rev [simp]: "rev(rev xs) = xs"
  apply(induction xs)
   apply(auto)
  done

value "Cons a' Nil"
value "x # xs"
value "x # y # z"

end
