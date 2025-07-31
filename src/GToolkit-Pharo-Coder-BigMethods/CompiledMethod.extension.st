Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> gtBigMethodCoder [
	<gtMethodCoder: 5>
	self isSourceSearchable
		ifTrue: [ self sourceCode size > 10000 ifTrue: [ ^ GtPharoBigMethodCoder ] ].
	^ nil
]
