Trait {
	#name : #TGtPharoWithMethodModificationIndicator,
	#instVars : [
		'methodModificationIndicator'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification Model'
}

{ #category : #'api - method modification indicator' }
TGtPharoWithMethodModificationIndicator >> methodModificationIndicator [
	<return: #GtPharoMethodModificationIndicator>
	^ methodModificationIndicator
]

{ #category : #'api - method modification indicator' }
TGtPharoWithMethodModificationIndicator >> methodModificationIndicator: aMethodModificationIndicator [
	self assert: [ aMethodModificationIndicator isNotNil ].
	
	methodModificationIndicator = aMethodModificationIndicator ifTrue: [ ^ self ].
	methodModificationIndicator := aMethodModificationIndicator.
	self onMethodModificationIndicatorChanged
]

{ #category : #'api - method modification indicator' }
TGtPharoWithMethodModificationIndicator >> onMethodModificationIndicatorChanged [
]
