-- data Vector' (dimension : Nat) scalarType = NullVector | NonEmptyVector' scalar (Vector' (dimension - 1) scalarType)

data Vector' : (dimension : Nat) -> (scalarType : Type) -> Type where
    NullVector : Vector' dimension scalarType
    NonEmptyVector : (scalar : scalarType) -> (Vector' (dimension-1) scalarType) -> Vector' dimension scalarType