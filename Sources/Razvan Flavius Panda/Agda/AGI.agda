module AGI where

open import Data.Maybe hiding (_>>=_) renaming (map to mapMaybe)
open import Data.List hiding (mapMaybe)
open import Data.Empty
open import Data.Nat
open import Data.Unit
open import Data.Product hiding (map)
open import IO.Primitive
open import Funcs


data Goal             : Set where
data Time             : Set where
data Action           : Set where
data ExternalState    : Set where
data WorldStateChange : Set where

data GoalType : Set where
  timeless-goal : GoalType
  finite-goal   : GoalType
  infinite-goal : GoalType

data GoalAchievementState : Set where
  achieved      : GoalAchievementState
  in-progress   : GoalAchievementState
  failed        : GoalAchievementState


mutual

  record InternalState : Set where
    inductive
    field
      goal       : Maybe Goal
      world-line : Maybe (List WorldState)

  record WorldState : Set where
    inductive
    field
      time           : Maybe Time
      external-state : Maybe ExternalState
      internal-state : Maybe InternalState

open InternalState
open WorldState

postulate

  -- |Merges information from sensors into provided WorldState
  mergeChangeIntoWorldState
    : WorldStateChange
    → WorldState
    → WorldState

  -- |Reads information from sensors
  readWorldStateChange
    : IO WorldStateChange

  allPossibleActions
    : WorldState
    → List Action

  simulateAction
    : Action
    → WorldState
    → WorldState

  -- |Returns the goal achievement state for the provided world state
  goalAchieved
    : WorldState
    → GoalAchievementState

  -- |Performs an action towards achieving a goal
  goalAction
    : Maybe Action
    → WorldState
    → IO WorldState


-- |Updates passed world state model with new world state model data coming from sensors
updateWorldState
  : WorldState
  → IO WorldState
updateWorldState previous-world-state = do
  world-state-change ← readWorldStateChange
  return $ mergeChangeIntoWorldState
    world-state-change previous-world-state

{-# TERMINATING #-}
goalProximity
  : WorldState
  → Maybe ℕ
goalProximity world-state =
  case goalAchieved world-state of λ
    { achieved    → just 0
    ; failed      → nothing
    ; in-progress → mapMaybe suc shortestPath
    }
  where
    shortestPath
      = listToMaybeℕ
      $ sort
      $ map (λ action →
        fromMaybeℕ
        $ goalProximity
        $ simulateAction action world-state
        )
      $ allPossibleActions world-state

findAction
  : WorldState
  → Maybe Action
findAction world-state =
  listToMaybe₂×
  $ sortOn₁ℕ
  $ map (λ action →
    fromMaybeℕ (goalProximity
      $ simulateAction action world-state
      ) , action
    )
  $ allPossibleActions world-state

{-# TERMINATING #-}
runAGI
  : WorldState
  → IO ⊤
runAGI previous-world-state = do
  current-world-state ← updateWorldState previous-world-state
  let action = findAction current-world-state
  next-world-state ← goalAction action current-world-state
  runAGI $ case goalAchieved current-world-state of λ
    { in-progress → next-world-state
    ; _           → current-world-state
    }
