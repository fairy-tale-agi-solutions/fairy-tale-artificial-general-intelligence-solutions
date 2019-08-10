{-# LANGUAGE TemplateHaskell #-}

module Lib where

import Control.Monad
import Development.Placeholders

runAGI :: WorldState -> IO ()
runAGI startingWorldState = do
  currentWorldState <- updateWorldState startingWorldState
  let goalState = goalAchieved currentWorldState
  runAGI $ if goalState == Searching
    then goalAction currentWorldState
    else currentWorldState

-- |Updates passed world state model with new world state model data coming from sensors
updateWorldState :: WorldState -> IO WorldState
updateWorldState previousWorldState = $notImplemented

-- |Returns the goal achievement state for the provided world state
goalAchieved :: WorldState -> GoalAchievementState
goalAchieved worldState = $notImplemented

-- |Performs an action towards achieving a goal
goalAction :: WorldState -> WorldState
goalAction worldState = $notImplemented

data WorldState = WorldState {
  time :: Maybe Time,
  externalState :: Maybe ExternalState,
  internalState :: Maybe InternalState
}

data Time = Time

data ExternalState = ExternalState

data InternalState = InternalState {
  goal :: Maybe Goal,
  worldLine :: Maybe [WorldState] -- TODO fix infinite(TM) recursivity
}

data Goal = Goal

data GoalAchievementState = Achieved | Failed | Searching deriving Eq