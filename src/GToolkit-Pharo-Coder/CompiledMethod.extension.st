Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder' }
CompiledMethod >> gtBigMethodCoder [
	<gtMethodCoder: 5>
	^ self sourceCode size > 10000 ifTrue: [ GtPharoBigMethodCoder ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
CompiledMethod >> gtMethodCoder [
	<gtMethodCoder: 1>
	^GtPharoMethodCoder
]
