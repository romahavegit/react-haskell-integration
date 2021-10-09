module JS (
	toJSVal,
	toJSString,
	toJSObject,
	toJSArray,
	null
)where

foreign import javascript
	"null" null :: JSVal
foreign import javascript 
	"$1" toJSVal :: (ToJSVal x) => x -> JSVal
foreign import javascript
	"$1" toJSString :: (ToJSString x) => x -> JSString
foreign import javascript 
	"$1" toJSObject :: (ToJSObject x) => x -> JSObject
foreign import javascript
	"$1" toJSArray :: (ToJSArray x) => x -> JSArray

class ToJSVal x
class ToJSString x
class ToJSObject x
class ToJSArray x

instance ToJSVal JsObject
instance ToJSVal JSString
instance ToJSVal JsArray
instance ToJSVal JSVal

instance ToJSString JSVal
instance ToJSString JSString

instance ToJSObject JSVal
instance ToJSObject JSArray
instance ToJSObject JSObject

instance ToJSArray JSVal
instance ToJSArray JSArray


