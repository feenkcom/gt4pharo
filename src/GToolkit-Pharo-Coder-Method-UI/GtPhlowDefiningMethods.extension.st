Extension { #name : #GtPhlowDefiningMethods }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPhlowDefiningMethods >> asBrMenu [
	^ GtPharoMethodCoderMenu new forMethod: self compiledMethod
]
