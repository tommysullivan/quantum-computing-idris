module Tommy

data Boolean = True | False

BB : Type
BB = Boolean -> Boolean

not : Boolean -> Boolean
not True = False
not False = True

BBB : Type
BBB = Boolean -> BB

or : BBB
or False False = False
or _ _ = True

and:BBB
and True True = True
and _ _ = False

xor:BBB
xor True False = True
xor False True = True
xor _ _ = False

-- natural numbers

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


data TEither a b = TLeft a | TRight b

definitelyNatural : TEither Integer Natural -> Natural
definitelyNatural (TRight n) = n
definitelyNatural (TLeft n) = naturalFromInteger n


data TList itemType = EmptyList | NonEmptyList itemType (TList itemType)

head : TList a -> a
head (NonEmptyList a _) = a

ttail : TList a -> TList a
ttail (NonEmptyList _ t) = t

randomTlist : TList Integer
randomTlist = NonEmptyList 2 (NonEmptyList 1 EmptyList)

tmap : TList a -> (a -> b) -> TList b
tmap EmptyList _ = EmptyList
tmap (NonEmptyList a tail) f = NonEmptyList (f a) (tmap tail f)

tlength : TList _ -> Nat
tlength EmptyList = Z
tlength (NonEmptyList _ tail) = S(tlength tail)


-- data Vector' (dimension : Nat) scalarType = NullVector | NonEmptyVector' scalar (Vector' (dimension - 1) scalarType)

data Vector' : (dimension : Nat) -> (scalarType : Type) -> Type where
    NullVector : Vector' dimension scalarType
    NonEmptyVector : (scalar : scalarType) -> (Vector' (dimension-1) scalarType) -> Vector' dimension scalarType