Time: 2017-09-23 14:32:20 UTC+00:00

Participants:
* [Brian McKenna (Puffnfresh)](https://www.linkedin.com/in/puffnfresh/)
* [Răzvan Flavius Panda](https://www.linkedin.com/in/razvan-flavius-panda/)

Topic: Designing solutions for creating safe artificial general intelligence

Summary of main ideas discussed:
* To achieve true general intelligence one must learn how to properly set up recording software before performing the recording action in an unsafe and wrong way that almost completely mutes one of the participants :) Maybe one of the first sub-goals we should work on would be to create a piece of software that reconstructs as much spoken symbols out of the information available to it from a badly recorded video - for example: there is some barely audible audio echo + lip reading which might be enough to allow reconstruction
* Agda or Idris have powerful enough type systems so that tests are not needed because bugs can be caught at compile time
* ToDo: We need a high level diagram of how a Safe AGI would work and then write some high level code based on it - then we need to go deeper and deeper until we completely implement all the parts
* ToDo: We need to find a way to define as unambiguously as possible what `Safe` means - also as simple and elegantly as possible. If we do not clearly know what `Safe` means than we can't insure that invariant in code at compile time.
* ToDo: We need to implement reinforcement learning algorithms in Haskell / Idris / Agda that would allow for at least 2 goals to be met: the top goal should always be minimized and the sub-goal must be the actual thing we wish to optimize besides the top-goal. For example:
    - top goal -> human safety
    - bottom goal -> win at Go
* The system in the above example must never sacrifice human safety optimization for the sake of becoming better at playing Go

Some of the stuff Răzvan Flavius Panda said while being muted and apparently doing random funny gestures:
* All life forms are recursive self-improvement systems (RSIs)
* Life at some point started extracting symbols out of reality/data (similar to unsupervised machine learning) - there were no symbols before life existed
* Example of symbols: programming language code, words that form words in natural languages, etc.
* Symbols are highly condensed/compressed references to "things"
* We humans seem to have our highest level decisions based on a symbolic system sitting on top of other systems which are a mix of symbolic and non-symbolic - such as some neural network module which does speech-to-symbol, video-to-symbol, etc.
* Although not necessarily the optimal idea since it appears that symbolic as the decisions maker works fine we might want to investigate further into whether this would be an idea for also re-designing life on no-biological substrate
* If we design the AGI using symbols as the top level decision module then we can much easily prove with very high certainty the decision making logic will maintain some properties under all possible futures - such as maintaining human safety during its run time
* Restricting non-symbolic sub-modules to not be part of taking the most important decisions would guarantee better safety
* General Intelligence is about the same as just Intelligence - we humans set the General Intelligence right bellow where we are located on the intelligence spectrum - maybe just to feel special? heh :)
* more humans working together manifest some properties that the parts themselves do not posses which makes humanity similar to a Super Biological General Intelligence
* Languages with powerful type systems such as Haskell, Idris, Agda, etc. should be able to ensure that a large amount of bad things can be prevented from happening at compile time
* AI systems that work using a lot of computation power to achieve single goals such as winning at go or winning at DotA without having a top level goal of being human safe could end up being potentially dangerous for humanity
* Death by aging is the way evolution worked around the issue of bypassing the problem of a continuously changing environment and the fact that brains stop evolving after some time - they get saturated so that new born entities would be much more efficient at adapting to the changes in environment
* Death by aging and many diseases could be solved by a safe AGI since it would be much more efficient than us at doing generally intelligent things

Video recording: TODO exporting in progress