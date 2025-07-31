Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> gtBigMethodCoder [
	<gtMethodCoder: 5>
	self isSourceSearchable
		and: [self sourceCode size > 10000 ifTrue: [^GtPharoBigMethodCoder]].
	^nil
]
