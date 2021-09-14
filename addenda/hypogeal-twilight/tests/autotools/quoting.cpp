// -*- c++ -*- which is C++2a but in hand-coded ersatz styling of a SCOLD module
#pragma once
// ceremony ratio = 63/28 = 2.25000000
#if 0
function ceremony_ratio() {
  local file=$1; shift;
  local total=$(wc -l < $file);
  local payload=$(grep -c ';' < $file);
  local floating=$( { echo scale=8; echo "$total/$payload"; } | bc)
  echo "ceremony ratio = $total/$payload = $floating";
};
ceremony_ratio quoting.cpp
#endif
// <fpp/tests.quoting.detail>
namespace tests::quoting::detail {
  enum class Flavor { SINGLE, DOUBLE };
  template<Flavor, typename> struct Quoting;
  template<typename TYPE> using Quote = Quoting<Flavor::SINGLE, TYPE>;
  template<typename TYPE> using QuoteQuote = Quoting<Flavor::DOUBLE, TYPE>;
  template<Flavor> struct Character;
}
// <hpp/tests.quoting.detail>
#include <ostream>
namespace tests::quoting::detail {
  template<Flavor FLAVOR, typename TYPE> inline auto operator<<(std::ostream &, Quoting<FLAVOR, TYPE> const &) -> std::ostream &;
  template<typename TYPE> inline auto q(TYPE const &v) -> Quoting<Flavor::SINGLE, TYPE>;
  template<typename TYPE> inline auto qq(TYPE const &v) -> Quoting<Flavor::DOUBLE, TYPE>;
}
template<tests::quoting::detail::Flavor FLAVOR, typename TYPE> struct tests::quoting::detail::Quoting {
  inline explicit Quoting(TYPE const &);
  TYPE const &value;
};
template<tests::quoting::detail::Flavor FLAVOR> struct tests::quoting::detail::Character {
  inline static auto literal() -> char;
};
namespace tests::quoting::detail {
  template<> auto tests::quoting::detail::Character<Flavor::SINGLE>::literal() -> char;
  template<> auto tests::quoting::detail::Character<Flavor::DOUBLE>::literal() -> char;
}
// <hpp/tests.quoting>
namespace tests::quoting {
  using detail::q;
  using detail::qq;
}
// <ipp/tests.quoting.detail>
template<tests::quoting::detail::Flavor FLAVOR, typename TYPE> tests::quoting::detail::Quoting<FLAVOR, TYPE>::Quoting(TYPE const &value)
  : value(value) {
  ;
}
template<> auto tests::quoting::detail::Character<tests::quoting::detail::Flavor::SINGLE>::literal() -> char {
  return '\'';
}
template<> auto tests::quoting::detail::Character<tests::quoting::detail::Flavor::DOUBLE>::literal() -> char {
  return '"';
}
template<tests::quoting::detail::Flavor FLAVOR, typename TYPE> auto tests::quoting::detail::operator<<(std::ostream &o, Quoting<FLAVOR, TYPE> const &v) -> std::ostream & {
  using character = Character<FLAVOR>;
  return o << character::literal() << v.value << character::literal();
}
// <ipp/tests.quoting>
template<typename TYPE> auto tests::quoting::detail::q(TYPE const &v) -> Quoting<Flavor::SINGLE, TYPE> {
  return Quoting<Flavor::SINGLE, TYPE>(v);
}
template<typename TYPE> auto tests::quoting::detail::qq(TYPE const &v) -> Quoting<Flavor::DOUBLE, TYPE> {
  return Quoting<Flavor::DOUBLE, TYPE>(v);
}
