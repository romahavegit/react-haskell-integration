module React.JS.ReactAndReactDOM ( 
	reactDOM_render,
	react_createElement
	) where
import Asterius.Types
import Control.Monad
import Foreign.StablePtr

type ReactElement = JSObject

foreign import javascript 
	"ReactDOM.render($1, document.querySelector($2))" reactDOM_render :: ReactElement -> JSString -> IO()

foreign import javascript 
	"React.createElement($1, $2, $3)" react_createElement :: JSVal -> JSVal -> JSVal -> IO ReactElement

