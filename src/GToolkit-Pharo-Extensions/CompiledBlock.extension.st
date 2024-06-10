Extension { #name : #CompiledBlock }

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledBlock >> gtAllInnerCompiledBlocksDo: aBlock [
	aBlock value: self.
	self innerCompiledBlocksDo: [ :anInnerBlock |
		anInnerBlock gtAllInnerCompiledBlocksDo: aBlock ]
]
