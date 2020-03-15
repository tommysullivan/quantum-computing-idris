data TEither a b = TLeft a | TRight b

definitelyNatural : TEither Integer Natural -> Natural
definitelyNatural (TRight n) = n
definitelyNatural (TLeft n) = naturalFromInteger n
