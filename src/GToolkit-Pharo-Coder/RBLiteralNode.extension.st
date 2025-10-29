Extension { #name : #RBLiteralNode }

{ #category : #'*GToolkit-Pharo-Coder' }
RBLiteralNode >> gtLiteralsInto: aSet [ 
	aSet add: self value
]
