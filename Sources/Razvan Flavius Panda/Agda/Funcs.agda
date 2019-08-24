module Funcs where

open import Data.Nat
open import Data.List
open import Data.Bool
open import Data.Maybe hiding (map)
open import Data.Product hiding (map)

_==_ : ℕ → ℕ → Bool
zero  == zero  = true
suc n == suc m = n == m
_     == _     = false

infixr 1 _$_
_$_ : ∀ {A B : Set} → (A → B) → A → B
f $ x = f x

case_of_ : ∀ {a b} {A : Set a} {B : Set b} → A → (A → B) → B
case x of f = f x

minimum : List ℕ → ℕ
minimum []       = 0
minimum (x ∷ xs) = x ⊓ minimum xs

sort : List ℕ → List ℕ
sort []         = []
sort l@(x ∷ xs) = minimum l ∷ sort xs

fromMaybeℕ : Maybe ℕ → ℕ
fromMaybeℕ (just n) = n
fromMaybeℕ _        = 0

listToMaybeℕ : List ℕ → Maybe ℕ
listToMaybeℕ []      = nothing
listToMaybeℕ (x ∷ _) = just x

listToMaybe₂× : ∀ {A B : Set} → List (A × B) → Maybe B
listToMaybe₂× []      = nothing
listToMaybe₂× (x ∷ _) = just $ proj₂ x

{-# TERMINATING #-}
-- TODO: reimplement to pass termination checking without using a pragma
sortOn₁ℕ : ∀ {B : Set} → List (ℕ × B) → List (ℕ × B)
sortOn₁ℕ [] = []
sortOn₁ℕ l@(x ∷ xs) with x
... | a , b with minimum (map proj₁ l) == a
...            | true  = x ∷ sortOn₁ℕ xs
...            | false = sortOn₁ℕ $ xs ++ [ x ]
