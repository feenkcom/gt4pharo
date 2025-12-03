Class {
	#name : #GtUnnecessaryPeriodAdvice,
	#superclass : #GtMethodAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtUnnecessaryPeriodAdvice >> description [
	^ 'Extra periods between statements are non-portable. Some Smalltalks will not allow the method to be compiled.'
]

{ #category : #private }
GtUnnecessaryPeriodAdvice >> findExtraPeriodIn: aNode [
	aNode extraPeriodsDo: [ :each | ^ each ].
	^ nil
]

{ #category : #styling }
GtUnnecessaryPeriodAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveExtraPeriodsFixItAction forCoder: coderModel node: aNode}
]

{ #category : #styling }
GtUnnecessaryPeriodAdvice >> fixItLocationFor: aSmaCCNode [
	^ self findExtraPeriodIn: aSmaCCNode
]

{ #category : #styling }
GtUnnecessaryPeriodAdvice >> highlightPositionsFor: aSmaCCNode [
	| positions |
	positions := OrderedCollection new.
	aSmaCCNode extraPeriodsDo: [ :pos | positions add: (pos to: pos) ].
	^ positions
]

{ #category : #testing }
GtUnnecessaryPeriodAdvice >> matches: aNode from: aCriticRunner [
	aNode isSequence ifFalse: [ ^ false ].
	^ (self findExtraPeriodIn: aNode) notNil
]

{ #category : #accessing }
GtUnnecessaryPeriodAdvice >> name [
	^ 'Extra periods between statements'
]
