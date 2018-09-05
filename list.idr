

data TList a = EmptyList | NonEmptyList a (TList a)

head : TList a -> a
head (NonEmptyList a _) = a

ttail : TList a -> TList a
ttail (NonEmptyList _ t) = t

tlist : TList Integer
tlist = NonEmptyList 2 (NonEmptyList 1 EmptyList)

-- mmap : TList a -> (f: a -> b) -> TList b


tmap : TList a -> (a -> b) -> TList b
tmap EmptyList _ = EmptyList
tmap (NonEmptyList a tail) f = NonEmptyList (f a) (tmap tail f)