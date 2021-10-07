module Main where
foreign import javascript "window.alert('ok')" sayHi :: IO()
main :: IO()
main = sayHi
