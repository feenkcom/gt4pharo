Extension { #name : #RBCreateAccessorsWithLazyInitializationForVariableRefactoring }

{ #category : #'*GToolkit-Pharo-Extensions' }
RBCreateAccessorsWithLazyInitializationForVariableRefactoring >> defineGetterMethod [
	self definingClass
		compile: (self format: ('<1s><r><t>^ <2s> ifNil: [ <2s> := <3s> ]'
						expandMacrosWith: self selector
						with: variableName
						with: self defaultValue))
		classified: #(#accessing).
	^selector
]
