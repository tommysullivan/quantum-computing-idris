4-- data Qubit

-- Qubit is a physical system containing only boolean observables - observables which
-- have only two discrete real elements in their spectrum. A rule about a system is that
-- if it has even one observable of dimension N, then it must have ALL POSSIBLE observables
-- of dimension N. Since any given observable can be represented as a hermitian matrix
-- having eigenvalues that are exactly the set of measurement outcomes associated with the observable,
-- and since any hermitian matrix of dimension 2 can be expressed as the linear combination,
-- with real coefficients, of the 3 pauli matrices and the Identity matrix, it follows that any
-- physical system that constitutes a qubit will necessarily have an infinite space of observables
-- whose 2 outcomes are all the pairs of real numbers in existence. We can also see that for any pair,
-- there can be more than one hermitian matrix whose eigenvalues are equal to that pair. For example,
-- all of the pauli matrices have eigenvalues 1 and -1.

data Qubit
data Observable
data Matrix
data RealNumber
data OrderedField
data VectorSpace --this has scalars - any field may provide scalars for a vector space.
data RationalNumber
data Set 

-- eigenvalues : Matrix -> (Set RealNumber)
-- eigenvalues m = 

-- what can i do with a qubit? We can regard the system as a fixed set of hermitian matrices with
-- an evolving state that is constrained so as to keep the algebra of the observables at any one
-- time intact.

data Vector -> Num -> Type