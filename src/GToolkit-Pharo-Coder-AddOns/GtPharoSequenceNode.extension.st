Extension { #name : #GtPharoSequenceNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSequenceNode >> extraPeriodsDo: aBlock [
	| pIndex sIndex |
	self periods size < self statements size ifTrue: [ ^ self ].
	pIndex := 1.
	sIndex := 1.
	[ pIndex <= self periods size and: [ sIndex <= self statements size ] ]
		whileTrue: [ (self periods at: pIndex) startPosition
				< (self statements at: sIndex) startPosition
				ifTrue: [ aBlock value: (self periods at: pIndex) stopPosition ]
				ifFalse: [ sIndex := sIndex + 1 ].
			pIndex := pIndex + 1 ].
	pIndex
		to: self periods size
		do: [ :i | aBlock value: (self periods at: i) stopPosition ]
]
