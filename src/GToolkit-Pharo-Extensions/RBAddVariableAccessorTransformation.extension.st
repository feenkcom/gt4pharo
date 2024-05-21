Extension { #name : #RBAddVariableAccessorTransformation }

{ #category : #'*GToolkit-Pharo-Extensions' }
RBAddVariableAccessorTransformation >> defineGetterMethod [
	<gtPharoPatch: #Pharo>
	
	getterMethod := self safeMethodNameFor: self definingClass basedOn: variableName asString.
	self definingClass 
		compile: ('<1s><r><t>^ <2s>' expandMacrosWith: getterMethod with: variableName)
		classified: #(#accessing).
	^ getterMethod
]

{ #category : #'*GToolkit-Pharo-Extensions' }
RBAddVariableAccessorTransformation >> defineSetterMethod [
	<gtPharoPatch: #Pharo>
	
	|  sourceCode |
	sourceCode := '<1s> anObject<r><t><2s> := anObject'.
	setterMethod := self safeMethodNameFor: self definingClass basedOn: variableName asString , ':'.
	self definingClass 
		compile: (sourceCode expandMacrosWith: setterMethod with: variableName)
		classified: #accessing.
	^setterMethod
]
