Class {
	#name : #GtPharoRenameSelectorPartHighlightChangeRequested,
	#superclass : #GtPharoRenameSelectorPartModelAnnouncement,
	#instVars : [
		'isHighlighted'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartHighlightChangeRequested >> isHighlighted [
	^ isHighlighted ifNil: [ true ]
]

{ #category : #accessing }
GtPharoRenameSelectorPartHighlightChangeRequested >> isHighlighted: aBoolean [
	isHighlighted := aBoolean
]
