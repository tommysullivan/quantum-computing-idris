data Natural = Zero | Successor Natural

naturalFromInteger : Integer -> Natural
naturalFromInteger 0 = Zero
naturalFromInteger n = Successor (naturalFromInteger (n - 1))

integerFromNatural : Natural -> Integer
integerFromNatural Zero = 0
integerFromNatural (Successor n) = 1 + integerFromNatural n

Show Natural where
    show n = show (integerFromNatural n)

plus : Natural -> Natural -> Natural
plus Zero y = y
plus (Successor x) y = Successor (plus x y)

lessThan : Natural -> Natural -> Boolean
lessThan Zero (Successor y) = True
lessThan (Successor x) (Successor y) = lessThan x y
lessThan _ _ = False

greaterThanOrEqualTo : Natural -> Natural -> Boolean
greaterThanOrEqualTo x y = not (lessThan x y)

--  Need to define my own Maybe and Nothing!!
minus : Natural -> Natural -> Maybe Natural
minus x Zero = Just x
minus (Successor x) (Successor y) = case x `lessThan` y of
                True => Nothing
                False => minus x y