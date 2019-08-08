using System;
using System.Collections.Generic;

namespace ArtificialGeneralIntelligence
{
    public abstract class ArtificialGeneralIntelligence
    {
        public abstract GoalAchievementState GoalAchieved(WorldState worldState);
        public abstract WorldState Action(WorldState worldState);
        public abstract void Run(WorldState startingWorldState);
    }

    public class ArtificialGeneralIntelligenceImplementation : ArtificialGeneralIntelligence
    {
        public override GoalAchievementState GoalAchieved(WorldState worldState)
        {
            throw new NotImplementedException();
        }

        public override WorldState Action(WorldState worldState)
        {
            throw new NotImplementedException();
        }

        public override void Run(WorldState startingWorldState)
        {
            var worldState = startingWorldState;
            while (GoalAchieved(worldState) == GoalAchievementState.Searching)
            {
                worldState = Action(worldState);
            }
        }
    }

    /// <summary>
    /// Contains the state of everything at a point in time: internal or external to the AGI
    /// </summary>
    public class WorldState
    {
        public Time Time;
        public ExternalState ExternalState;
        public InternalState InternalState;
    }

    public class Time { }

    public class ExternalState { }

    public class InternalState
    {
        public Goal Goal;
        public IList<WorldState> WorldLine;
    }

    /// <summary>
    /// A restriction of any complexity defined over any past, present or future world states
    /// </summary>
    public abstract class Goal { }

    public enum GoalAchievementState
    {
        Achieved,
        Failed,
        Searching
    }
}