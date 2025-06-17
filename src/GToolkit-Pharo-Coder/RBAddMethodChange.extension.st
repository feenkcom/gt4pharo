Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddMethodChange >> gtDiffChange [
	| oldSource newSource |
	oldSource := (self changeClass notNil
			ifTrue: [ self methodSourceFor: self selector ]) ifNil: [ '' ].
	newSource := self source.
	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddMethodChange >> gtDiffStyler [
	^ BrRBTextStyler new classOrMetaClass: self changeClass
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBAddMethodChange >> protocolName [
	<gtPharoPatch: #Pharo>
	^ self protocol
]
