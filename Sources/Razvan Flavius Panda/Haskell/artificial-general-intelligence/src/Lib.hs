-- Project priority list
-- * code AGI that runs using unlimited resources for non trivial goals
-- * construct a goal that is good for humanity
-- * optimize the AGI code to run in a timely manner

{-# LANGUAGE TemplateHaskell #-}

module Lib where

import           Control.Monad              (join)
import           Data.List                  (find, sort, sortOn)
import           Data.Maybe                 (isJust, listToMaybe)
import           Development.Placeholders
import           Language.Haskell.TH.Syntax
import           Numeric.Natural            (Natural)

runAGIWithDefaults :: IO ()
runAGIWithDefaults = runAGI $ WorldState Nothing Nothing Nothing

-- |Runs the AGI starting with provided WorldState
runAGI :: WorldState -> IO ()
runAGI previousWorldState = do
  currentWorldState <- updateWorldState previousWorldState
  let action = findAction currentWorldState
  nextWorldState <- goalAction action currentWorldState
  runAGI $ case goalAchieved currentWorldState of
      InProgress -> nextWorldState
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
goalAction :: Maybe Action -> WorldState -> IO WorldState
goalAction action worldState = $notImplemented

findAction :: WorldState -> Maybe Action
findAction = findActionMockable allPossibleActions goalProximity simulateAction

findActionMockable ::
  (WorldState -> [Action]) ->
  (WorldState -> Maybe Natural) ->
  (Action -> WorldState -> WorldState) ->
  WorldState -> Maybe Action
findActionMockable allPossibleActions goalProximity simulateAction worldState =
  fmap snd . find (isJust . fst) $ sortOn fst $ mapAction <$> actions
  where
    actions = allPossibleActions worldState
    mapAction action = (goalProximity $ simulateAction action worldState, action)

-- TODO optimization: make it work as A*
goalProximity :: WorldState -> Maybe Natural
goalProximity worldState =
  case goalAchieved worldState of
       Achieved   -> Just 0
       Failed     -> Nothing
       InProgress -> (+1) <$> join shortestPath
  where
    shortestPath = listToMaybe $ sort $ mapAction <$> actions
    mapAction action = goalProximity $ simulateAction action worldState
    actions = allPossibleActions worldState

allPossibleActions :: WorldState -> [Action]
allPossibleActions worldState = $notImplemented

simulateAction :: Action -> WorldState -> WorldState
simulateAction action worldState = $notImplemented

-- |Reads information from sensors
readWorldStateChange :: IO WorldStateChange
readWorldStateChange = $notImplemented

-- |Merges information from sensors into provided WorldState
mergeChangeIntoWorldState :: WorldStateChange -> WorldState -> WorldState
mergeChangeIntoWorldState worldStateChange worldState = $notImplemented

data WorldStateChange = WorldStateChange

data WorldState = WorldState {
  time          :: Maybe Time,
  externalState :: Maybe ExternalState,
  internalState :: Maybe InternalState
}

data Time = Time

data ExternalState = ExternalState

data InternalState = InternalState {
  goal      :: Maybe Exp,
  worldLine :: Maybe [WorldState] -- TODO fix infinite(TM) recursivity
}

data GoalType = TimelessGoal | FiniteGoal | InfiniteGoal

data GoalAchievementState = Achieved | InProgress | Failed

data Action = Action
