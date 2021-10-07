module React.Node (
	Node (
		StringNode,
		Tag,
		Component
		),
	Element( toReactElement ),
	Props,
	Childs,
	ToJSON,
	NoProps,
	NoChilds,
	noProps,
	noChilds,
	Fixable (toFixed),
	Multiplable ((<++>))
	) where
import SupplementData.FixedWidthTuple(
	Fixable (toFixed),
	Multiplable ((<++>))
	)
import Data.Aeson(ToJSON)
import GHC.Generics(Generic)

data ReactElement = ReactElement | EmptyReactElement
class Element x where
	toReactElement :: x -> ReactElement
instance Element (Maybe ()) where
	toReactElement x = EmptyReactElement
instance Element (Node x y z) where
	toReactElement = const ReactElement

data Node x y z where
	StringNode :: String -> Node String (Maybe ()) (Maybe ())
	Tag :: (Props props, Childs childs)=> String -> props -> childs -> Node String props childs
	Component :: (Props a, Childs childs) => (pr -> ch) -> a -> childs -> Node (pr -> ch) a childs

instance (Show x, Show y, Show z)=>Show (Node x y z) where
	show (StringNode str) = "StringNode " ++ str
	show (Tag str props childs) = "Tag " ++ str ++ " " ++ show props ++ " " ++  show childs
	show (Component f props childs) = show f ++ " "++ show props ++ " " ++ show childs

instance Show (a -> b) where
	show f = "a -> b"
class (ToJSON x) =>Props x
class Childs x
instance (Element a, Element b, Element c, Element d, Element e, Fixable x (a,b,c,d,e))=> Childs x
data NoProps = NoProps {__noProps :: Bool} deriving (Show, Generic)
instance ToJSON NoProps
instance Props NoProps

noProps :: NoProps
noProps = NoProps True

type NoChilds = (Maybe(), Maybe())
noChilds :: NoChilds
noChilds = (Nothing, Nothing)

