Extension { #name : #OCLiteralNode }

{ #category : #'*GToolkit-Pharo-Coder' }
OCLiteralNode >> gtLiteralsInto: aSet [ 
	aSet add: self value
]
