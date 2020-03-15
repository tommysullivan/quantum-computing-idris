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