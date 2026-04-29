Extension { #name : #RBLiteralNode }

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBLiteralNode >> gtLiteralsInto: aSet [ 
	aSet add: self value
]
