Extension { #name : #RBCreateAccessorsForVariableRefactoring }

{ #category : #'*GToolkit-Pharo-Extensions' }
RBCreateAccessorsForVariableRefactoring >> defineGetterMethod [
	self definingClass
		compile: (self format: ('<1s><r><t>^ <2s>' expandMacrosWith: self selector
						with: variableName))
		classified: #(#accessing).
	^selector
]

{ #category : #'*GToolkit-Pharo-Extensions' }
RBCreateAccessorsForVariableRefactoring >> defineSetterMethod [
	| definingClass string |
	definingClass := self definingClass.
	string := self needsReturnForSetter
				ifTrue: ['<1s> anObject<r><t>^ <2s> := anObject']
				ifFalse: ['<1s> anObject<r><t><2s> := anObject'].
	selector := self safeMethodNameFor: definingClass
				basedOn: variableName asString , ':'.
	definingClass compile: (self
				format: (string expandMacrosWith: selector with: variableName))
		classified: #accessing.
	^selector
]

{ #category : #'*GToolkit-Pharo-Extensions' }
RBCreateAccessorsForVariableRefactoring >> format: aString [
	| ast |
	ast := RBParser parseMethod: aString.
	^RBProgramNode formatterClass format: ast
]
