{-# LANGUAGE TemplateHaskell #-}

module Lib where

import Control.Monad
import Development.Placeholders

runAGIWithDefaults :: IO ()
runAGIWithDefaults = runAGI $ WorldState Nothing Nothing Nothing

runAGI :: WorldState -> IO ()
runAGI previousWorldState = do
  currentWorldState <- updateWorldState previousWorldState
  runAGI $ case goalAchieved currentWorldState of
      InProgress -> goalAction currentWorldState
      _          -> currentWorldState

-- |Updates passed world state model with new world state model data coming from sensors
updateWorldState :: WorldState -> IO WorldState
updateWorldState previousWorldState = do
  worldStateChange <- readWorldStateChange
  return $ mergeChangeIntoWorldState worldStateChange previousWorldState

-- |Returns the goal achievement state for the provided world state
goalAchieved :: WorldState -> GoalAchievementState
goalAchieved worldState = $notImplemented

-- |Performs an action towards achieving a goal
goalAction :: WorldState -> WorldState
goalAction worldState = $notImplemented

-- |Reads information from sensors
readWorldStateChange :: IO WorldStateChange
readWorldStateChange = $notImplemented

-- |Merges information from sensors into provided WorldState
mergeChangeIntoWorldState :: WorldStateChange -> WorldState -> WorldState
mergeChangeIntoWorldState worldStateChange worldState = $notImplemented

data WorldStateChange = WorldStateChange

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

data GoalAchievementState = Achieved | InProgress | Failed