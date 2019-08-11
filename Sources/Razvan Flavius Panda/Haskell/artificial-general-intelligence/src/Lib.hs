{-# LANGUAGE TemplateHaskell #-}

module Lib where

import Data.List (sortOn)
import Data.Maybe (isJust)
import Development.Placeholders

runAGIWithDefaults :: IO ()
runAGIWithDefaults = runAGI $ WorldState Nothing Nothing Nothing

-- |Runs the AGI starting with provided WorldState, requires infinite resources
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
goalAction worldState =
  let action = findAction worldState in performAction action worldState

findAction :: WorldState -> Maybe Action
findAction worldState =
  if null proximitiesAndActions then Nothing else Just $ snd $ head proximitiesAndActions
  where
    actions = allPossibleActions worldState
    mapAction action = (goalProximity $ performAction (Just action) worldState, action)
    proximitiesAndActions = filter (isJust . fst) $ sortOn fst $ mapAction <$> actions

goalProximity :: WorldState -> Maybe Double
goalProximity worldState = $notImplemented

allPossibleActions :: WorldState -> [Action]
allPossibleActions worldState = $notImplemented

performAction :: Maybe Action -> WorldState -> WorldState
performAction action worldState = $notImplemented

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

data Goal = TimelessGoal | FiniteGoal | InfiniteGoal

data GoalAchievementState = Achieved | InProgress | Failed

data Action = Action