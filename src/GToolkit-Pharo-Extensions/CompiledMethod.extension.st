Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtAllInnerCompiledBlocksDo: aBlock [
	self innerCompiledBlocksDo: [ :anInnerBlock |
		anInnerBlock gtAllInnerCompiledBlocksDo: aBlock ]
]
