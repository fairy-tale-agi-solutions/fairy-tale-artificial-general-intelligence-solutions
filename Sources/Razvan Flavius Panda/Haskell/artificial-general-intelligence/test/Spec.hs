{-# LANGUAGE TemplateHaskell #-}

import           Hedgehog
import qualified Hedgehog.Gen   as Gen
import qualified Hedgehog.Range as Range

prop_reverse :: Property
prop_reverse =
  property $ do
    xs <- forAll $ Gen.list (Range.linear 0 100) Gen.alpha
    reverse (reverse xs) === xs

-- prop_findAction :: Property
-- prop_findAction =
--   property $ do
--     return expression

tests :: IO Bool
tests =
  checkParallel $$discover
