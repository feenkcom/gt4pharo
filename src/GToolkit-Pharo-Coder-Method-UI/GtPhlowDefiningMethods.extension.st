Extension { #name : #GtPhlowDefiningMethods }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPhlowDefiningMethods >> asBrMenu [
	^ GtPharoMethodCoderMenu new forMethod: self compiledMethod
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPhlowDefiningMethods >> asBrMenuWithSelfObjectHolder: aSelfObjectHolder [
	^ GtPharoMethodCoderMenu new 
		forMethod: self compiledMethod;
		selfObjectHolder: aSelfObjectHolder
]
