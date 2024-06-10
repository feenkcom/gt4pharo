Extension { #name : #CleanBlockClosure }

{ #category : #'*GToolkit-Pharo-Extensions' }
CleanBlockClosure >> gtAllInnerCompiledBlocksDo: aBlock [
	aBlock value: self.
	^self innerCompiledBlocksDo: aBlock
]
