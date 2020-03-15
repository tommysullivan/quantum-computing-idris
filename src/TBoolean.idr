module TBoolean

public export
data TBoolean = TTrue | TFalse

public export
BB : Type
BB = TBoolean -> TBoolean

public export BBB : Type
BBB = TBoolean -> BB

export
toString : TBoolean -> String
toString TTrue = "true"
toString TFalse = "false"

export
not : BB
not TTrue = TFalse
not TFalse = TTrue

export
or : BBB
or TFalse TFalse = TFalse
or _ _ = TTrue

export
and : BBB
and TTrue TTrue = TTrue
and _ _ = TFalse

export
xor : BBB
xor TTrue TFalse = TTrue
xor TFalse TTrue = TTrue
xor _ _ = TFalse