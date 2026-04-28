Class {
	#name : #GtPharoRenameSelectorParameterHighlightChangeRequested,
	#superclass : #GtPharoRenameSelectorParameterModelAnnouncement,
	#instVars : [
		'isHighlighted'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorParameterHighlightChangeRequested >> isHighlighted [
	^ isHighlighted ifNil: [ true ]
]

{ #category : #accessing }
GtPharoRenameSelectorParameterHighlightChangeRequested >> isHighlighted: aBoolean [
	isHighlighted := aBoolean
]
