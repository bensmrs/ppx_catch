(** This module implements the PPX *)

open Ppxlib
open Ast_builder.Default

(** Create the catch-all blocks *)
let catch ~loc ~ok ~error ?data expr =
  pexp_try ~loc (pexp_construct ~loc (Loc.make ~loc (Lident ok)) (Some expr))
           [case ~lhs:(ppat_any ~loc) ~guard:None
                 ~rhs:(pexp_construct ~loc (Loc.make ~loc (Lident error)) data)]

(** Declare the `catch.o' extension *)
let option_mapper =
  Extension.declare "catch.o" Extension.Context.expression
    Ast_pattern.(single_expr_payload __)
    (fun ~loc ~path:_ expr -> catch ~loc ~ok:"Some" ~error:"None" expr)

(** Declare the `catch.r' extension *)
let result_mapper =
  Extension.declare "catch.r" Extension.Context.expression
    Ast_pattern.(single_expr_payload (pexp_sequence __ __ ))
    (fun ~loc ~path:_ data -> catch ~loc ~ok:"Ok" ~error:"Error" ~data)

(** Register the transformation *)
let () = Driver.register_transformation "catch" ~extensions:[option_mapper; result_mapper]
