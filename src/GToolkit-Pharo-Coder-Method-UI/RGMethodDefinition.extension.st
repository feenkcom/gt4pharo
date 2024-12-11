Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
RGMethodDefinition >> asBrMenu [
	^ GtPharoMethodCoderMenu new forMethod: self compiledMethod
]
