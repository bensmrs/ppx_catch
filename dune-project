(lang dune 2.7)
(name ppx_catch)
(version 0.1.0)
(generate_opam_files true)
(license MIT)
(authors "Benjamin Somers <benjamin.somers@imt-atlantique.fr>")
(maintainers "Benjamin Somers <benjamin.somers@imt-atlantique.fr>")
(homepage "https://github.com/bensmrs/ppx_catch")
(source (github "bensmrs/ppx_catch"))
(bug_reports "https://github.com/bensmrs/ppx_catch/issues")

(package
 (name ppx_catch)
 (synopsis "A PPX rewriter to catch exceptions and wrap into options or results")
 (description "This package catches all exceptions in a block and returns an option or a result of the resulting value")
 (depends
  (alcotest (and :with-test (>= 1.6.0)))
  (ppxlib (>= 0.27.0))))
