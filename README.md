# `ppx_catch`

`ppx_catch` is a PPX rewriter to catch exceptions. It acts as a catch-all and transforms expressions into `option`s or `result`s.

## Usage

### `catch.o`

The `catch.o` extension wraps an expression into an `option`.

```ocaml
[%catch.o
  let i = Option.get None in
  i + 1
]
```

gives `None`, while

```ocaml
[%catch.o
  let i = Option.get (Some 2)
  in i + 1
]
```

gives `Some 3`. `[%catch.o expression]` behaves exactly like:

```ocaml
try Some expression with _ -> None
```


### `catch.r`

The `catch.r` extension wraps an expression into a `result`.

```ocaml
[%catch.r Some 10;
  let i = Option.get None in
  i + 1
]
```

gives `Error (Some 10)`, while

```ocaml
[%catch.r Some 10;
  let i = Option.get (Some 2)
  in i + 1
]
```

gives `Ok 3`. `[%catch.r err; expression]` behaves exactly like:

```ocaml
try Ok expression with _ -> err
```
