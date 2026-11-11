(* Use ppxlib's AST: from OCaml 5.4, ppxlib (>= 0.37) has its own
   Longident, distinct from compiler-libs'. *)
module Longident = Ppxlib.Longident
module Asttypes = Ppxlib.Asttypes
module Ast_helper = Ppxlib.Ast_helper

module OrderedLongident = struct
  type t = Longident.t

  let compare = compare
end

module LongidentSet = Set.Make (OrderedLongident)

module StringSet = Set.Make (String)

module StringMap = Map.Make (String)

module StringHashtbl = Hashtbl.Make (struct
  type t = string

  let equal = String.equal

  let hash = Hashtbl.hash
end)

module IntSet = Set.Make (Int)

module IntMap = Map.Make (Int)

let subst_ident f (type_ident : Longident.t) : Longident.t =
  match type_ident with
  | Lident type_name -> Lident (f type_name)
  | Ldot (path, type_name) -> Ldot (path, f type_name)
  | Lapply _ -> invalid_arg "subst_ident"
