{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE TypeFamilies #-}
module SupplementData.FixedWidthTuple (
		Multiplable ((<++>)),
		Downable (down),
		Fixable (toFixed)
		) where
import Data.Maybe

type FixedTuple = (,,,,)
class ToFixedWidthTuple a b | a -> b where
	toFixedWidthTuple :: a -> b
instance ToFixedWidthTuple (a,b) (Maybe a, Maybe b, Maybe a, Maybe a, Maybe a) where
	toFixedWidthTuple (a, b) = (,,,,) (Just a) (Just b) Nothing Nothing Nothing

toStringList :: (Show a, Show b, Show c, Show d, Show e) => (,,,,) a b c d e -> [String]
toStringList (a, b, c, d, e) = show a : show b : show c : show d : show e : []


class Multiplable a b c | a b -> c where
	(<++>) ::  a -> b -> c
	isLast :: a -> Bool
	isLast = const False
instance Multiplable (a,b,c,d,e) x (a,b,c,d,e) where
	(<++>) = const 
	isLast = const True
instance Multiplable (a,b,c,d) e (a,b,c,d,e) where
	(<++>) (a,b,c,d) = (,,,,) a b c d
instance Multiplable (a,b,c) d (a,b,c,d) where
	(<++>) (a,b,c) = (,,,) a b c
instance Multiplable (a, b) c (a,b,c) where
	(<++>) (a,b) = (,,) a b
instance Multiplable (a,a,a,a,a,a,a,a,a,a) b (a,b) where
	(<++>) (a,_,_,_,_,_,_,_,_,_) b = (a,b)
	
class (Multiplable a b c) => Downable c a b| c -> a b where
	down :: c -> (a,b)
	isSimplest :: c -> Bool
	isSimplest = const False
instance Downable (a,b) (a,a,a,a,a,a,a,a,a,a) b where
	down (a,b)= (,) ((,,,,,,,,,) a a a a a a a a a a) b
	isSimplest = const True
instance Downable (a,b,c) (a,b) c where
	down (a,b,c) = (,) (a,b) c
instance Downable (a,b,c,d) (a,b,c) d where
	down (a,b,c,d) = (,) (a,b,c) d
instance Downable (a,b,c,d,e) (a,b,c,d) e where
	down (a,b,c,d,e) = (,) (a,b,c,d) e


class Fixable a b | a -> b where
	toFixed :: a -> b
instance Fixable (a,b,c,d,e) (a,b,c,d,e) where
	toFixed = id
instance Fixable (a,b,c,d) (a,b,c,d,Maybe ()) where
	toFixed = helper
instance Fixable (a,b,c) (a,b,c,Maybe (), Maybe ()) where
	toFixed = helper
instance Fixable (a,b) (a,b,Maybe (),Maybe (), Maybe ()) where
	toFixed = helper

helper x = toFixed $ x <++> (Nothing :: Maybe ())




