module Tommy

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


