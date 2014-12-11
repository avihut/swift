// RUN: %swift -emit-silgen %s | FileCheck %s

protocol Fooable {
  typealias Bar

  func foo<T: Fooable where T.Bar == Self.Bar>(#x: T) -> Self.Bar
}

struct X {}

// Ensure that the protocol witness for requirements with same-type constraints
// is set correctly. <rdar://problem/16369105>
// CHECK-LABEL: sil hidden @_TTWV17witness_same_type3FooS_7FooableS_FS1_3fooUS1__U__fQPS1_US1___FT1xQ__QS2_3Bar : $@cc(witness_method) @thin <T where T : Fooable, T.Bar == X> (@out X, @in T, @in_guaranteed Foo) -> ()
struct Foo: Fooable {
  typealias Bar = X

  func foo<T: Fooable where T.Bar == X>(#x: T) -> X { return X() }
}
