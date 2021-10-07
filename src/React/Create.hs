module React.Create where
import React.Node(
		Props,
		NoChilds,
		Childs,
		Node(StringNode, Tag, Component),
		noChilds,
		noProps,
		Fixable
	)
import Data.Functor(Functor)
class Create content where
	(/&) :: (Props props) => content -> props -> Node content props NoChilds

instance Create String where
	(/&) tag props = Tag tag props noChilds
instance Create (a -> b) where
	(/&) f props = Component f props noChilds

class LoadChilds f x where
	(<<>) :: (Childs newChilds)=> f x -> newChilds -> f newChilds


instance (Props props)=> LoadChilds (Node String props) NoChilds where
	(<<>) (Tag tag props _) = Tag tag props
instance (Props props)=> LoadChilds (Node (a -> b)props) NoChilds where
	(<<>) (Component f props _) = Component f props


