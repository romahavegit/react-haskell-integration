module Main where
import Asterius.Types
import JS (toJSString)
foreign import javascript "'hi'" hi :: JSVal

foreign import javascript "alert($1)" sayHi :: JSVal ->  IO()

foreign import javascript "null" jsNull :: JSVal

main :: IO()
main = sayHi $ toJSString hi
