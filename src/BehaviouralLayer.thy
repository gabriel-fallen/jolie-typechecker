section {* Behavioural layer *}

theory BehaviouralLayer
imports Main
begin

subsection {* Term definitions  *}

type_synonym channel   = string (* FIXME: do we need more advanced type for channel names? *)
type_synonym operation = string (* FIXME: do we need more advanced type for operation names? *)
type_synonym location  = string (* FIXME: do we need more advanced type for locations? *)

type_synonym variable  = string (* TODO: just stub for now. We'll define a type for actual tree-shaped variables later. *)

datatype expr = Expr (* TODO: define expression terms *)

datatype output_ex = Notify     operation location expr (* o@l(e) *)
                   | SolicitRes operation location expr variable (* o@l(e)(x) *)
datatype
    input_ex  = OneWay operation variable (* o(x) *)
              | ReqRes operation variable variable statement (* o(x)(x'){B} *)
and statement = Input input_ex
              | Output output_ex
              | If expr statement
              | IfElse expr statement statement
              | While expr statement
              | Seq statement statement (* B1; B2 *)
              | Par statement statement (* B1 | B2 *)
              | Assign variable expr    (* x = e *)
              | Nil
              | InputChoice "(input_ex \<times> statement) list" (* [n1]{B1} ... [nn]{Bn} *)
              | Wait channel operation location variable  (* Wait(r, o@l, x) *)
              | Exec channel operation variable statement (* Exec(r, o, x, B) *)


datatype basic_type = Bool | Int | Long | Double | String | Raw | Void

datatype cardinality = OO (* [0,0] *)
                     | OI (* [0,1] *)
                     | II (* [1,1] *)

datatype child_type = Child string cardinality tree_type
and       tree_type = TLeaf basic_type | TNode basic_type "child_type list" (* FIXME: should be non-empty list of children. *)


subsection {* Typing rules  *}

subsubsection {* Typing environment *}

datatype type_declaration = OutNotify  operation location tree_type
                          | OutSolRes  operation location tree_type tree_type
                          | InOneWay   operation tree_type
                          | InReqRes   operation tree_type tree_type
                          | Var        variable tree_type

type_synonym typing_env = "type_declaration set"



end




