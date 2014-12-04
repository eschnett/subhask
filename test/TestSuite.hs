-- {-# LANGUAGE CPP #-}
-- import SubHask
import SubHask.Algebra
import SubHask.Category
import SubHask.Internal.Prelude
import SubHask.Algebra.Group
import SubHask.Algebra.Container
-- import SubHask.Algebra.Trans.StringMetrics
-- import SubHask.Algebra.Trans.MiscMetrics
-- import SubHask.Algebra.Trans.Kernel
-- import SubHask.Algebra.Trans.CompensatedSum

import SubHask.TemplateHaskell.Deriving
import SubHask.TemplateHaskell.Test
-- import Language.Haskell.TH hiding (Match)

import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.QuickCheck hiding (NonNegative)
import Test.QuickCheck.Arbitrary

main = defaultMain
    [ testGroup "simple"
        [ testGroup "numeric"
            [ $( mkSpecializedClassTests [t| Int      |] [''Enum,''Ring, ''Bounded, ''MetricSpace] )
            , $( mkSpecializedClassTests [t| Integer  |] [''Enum,''Ring, ''Lattice, ''MetricSpace] )
            , $( mkSpecializedClassTests [t| Rational |] [''Ord,''Ring, ''Lattice, ''MetricSpace] )
-- --             , $( mkSpecializedClassTests [t| Float    |] [''Ord,''Field, ''Bounded] )
-- --             , $( mkSpecializedClassTests [t| Double   |] [''Ord,''Field, ''Bounded] )
--             , $( mkSpecializedClassTests [t| Uncompensated Int |] [ ''Ring ] )
            , testGroup "transformers"
                [ $( mkSpecializedClassTests [t| NonNegative Int  |] [''Enum,''Rig, ''Bounded, ''MetricSpace] )
                , $( mkSpecializedClassTests [t| Z 57             |] [''Ring] )
                , $( mkSpecializedClassTests [t| NonNegative (Z 57) |] [''Rig] )
                ]
            ]
        , testGroup "non-numeric"
            [ $( mkSpecializedClassTests [t| Bool      |] [''Enum,''Boolean] )
            , $( mkSpecializedClassTests [t| Char      |] [''Enum,''Bounded] )
--             , testGroup "transformers"
--                 [ $( mkSpecializedClassTests [t| BooleanRing Bool |] [''Ring] )
--                 ]
            ]
        ]
--     , testGroup "vectors"
        -- | FIXME: vector Arbitrary broken due to different sizes
        -- | FIXME: vector identity is different than x-x, so spurious failures
--         [ $( mkSpecializedClassTests [t| Vector Int |] [ ''Group, ''Ord, ''Lattice ] )
--         [ testGroup "metrics"
--             [ $( mkSpecializedClassTests [t| Vector Double |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| Polynomial 2 (Vector Double) |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| RBF 2 (Vector Double) |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| Sigmoid 2 (Vector Double) |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| Match                   Vector Double  |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| Xi2                     Vector Double  |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| HistogramIntersection   Vector Double  |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| JensenShannonDivergence Vector Double  |] [''MetricSpace] )
--             ]
--         ]
    , testGroup "containers"
        [ $( mkSpecializedClassTests [t| []            Char |] [ ''FreeMonoid ] )
        , $( mkSpecializedClassTests [t| Set           Char |] [ ''MinBound_ ] )
--         , $( mkSpecializedClassTests [t| Set           Char |] [ ''Monoid, ''Lattice, ''Container, ''Foldable, ''Unfoldable ] )
--         , $( mkSpecializedClassTests [t| Array         Char |] [ ''FreeMonoid ] )
--         , $( mkSpecializedClassTests [t| UnboxedArray  Char |] [ ''FreeMonoid ] )
--         , $( mkSpecializedClassTests [t| StorableArray Char |] [ ''FreeMonoid ] )
        , testGroup "transformers"
            [ $( mkSpecializedClassTests [t| Lexical     [Char] |] [''Ord,''MinBound_,''Lattice] )
--             , $( mkSpecializedClassTests [t| Hamming     [Char] |] [''MetricSpace] )
--             , $( mkSpecializedClassTests [t| Levenshtein [Char] |] [''MetricSpace] )
            ]
        ]
    ]