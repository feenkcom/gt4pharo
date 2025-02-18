Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
RGMethodDefinition >> asBrMenu [
	^ GtPharoMethodCoderMenu new forMethod: self compiledMethod
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
RGMethodDefinition >> asBrMenuWithSelfObjectHolder: aSelfObjectHolder [
	^ GtPharoMethodCoderMenu new 
		forMethod: self compiledMethod;
		selfObjectHolder: aSelfObjectHolder
]
