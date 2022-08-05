(** This module tests the PPX with Alcotest *)

open Alcotest

(** A check for catch.o *)
let test_o () =
  check (option int) "handles exceptions" None [%catch.o let i = Option.get None in i + 1];
  check (option int) "returns results" (Some 3) [%catch.o let i = Option.get (Some 2) in i + 1]

(** A check for catch.r *)
let test_r () =
  check (result int (option int)) "handles exceptions" (Error (Some 10))
                [%catch.r Some 10; let i = Option.get None in i + 1];
  check (result int (option int)) "returns results" (Ok 3)
                [%catch.r Some 10; let i = Option.get (Some 2) in i + 1]

let tests = [
  ("catch.o", `Quick, test_o);
  ("catch.r", `Quick, test_r)
]

let test_suites: unit test list = [
  "Catch", tests;
]

(** Run the test suites *)
let () = run "ppx_catch" test_suites
