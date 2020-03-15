module TBoolean

public export
data TBoolean = TTrue | TFalse

export
toString : TBoolean -> String
toString TTrue = "true"
toString TFalse = "false"

export
not : TBoolean -> TBoolean
not TTrue = TFalse
not TFalse = TTrue

export
or : TBoolean -> TBoolean -> TBoolean
or TFalse TFalse = TFalse
or _ _ = TTrue

export
and : TBoolean -> TBoolean -> TBoolean
and TTrue TTrue = TTrue
and _ _ = TFalse

export
xor : TBoolean -> TBoolean -> TBoolean
xor TTrue TFalse = TTrue
xor TFalse TTrue = TTrue
xor _ _ = TFalse