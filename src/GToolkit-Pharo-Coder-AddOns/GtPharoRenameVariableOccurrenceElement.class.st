"
I replace an occurrence of the renamed variable that the user does not edit. I display the current name of a {{gtClass:GtPharoRenameVariableModel}} and follow its changes.

# Example
{{gtExample:GtPharoRenameVariableElementsExamples>>#occurrenceElement | codeExpanded=false | previewExpanded | previewHeight=100}}
"
Class {
	#name : #GtPharoRenameVariableOccurrenceElement,
	#superclass : #BlElement,
	#instVars : [
		'variableModel',
		'labelElement'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #initialization }
GtPharoRenameVariableOccurrenceElement >> initialize [
	super initialize.

	self layout: BlFrameLayout new.
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	labelElement := BrLabel new
			aptitude: BrGlamorousLabelAptitude new;
			fitContent.
	self addChild: labelElement as: #labelElement
]

{ #category : #accessing }
GtPharoRenameVariableOccurrenceElement >> labelElement [
	^ labelElement
]

{ #category : #'event handling' }
GtPharoRenameVariableOccurrenceElement >> onGtPharoRenameVariableNameChanged: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].
	labelElement text: anAnnouncement currentName
]

{ #category : #accessing }
GtPharoRenameVariableOccurrenceElement >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableOccurrenceElement >> variableModel: aVariableModel [
	"The model is assigned only once."

	self assert: [ aVariableModel isNotNil ].
	self assert: [ variableModel isNil ].

	variableModel := aVariableModel.
	labelElement text: variableModel currentName.
	variableModel announcer weak
		when: GtPharoRenameVariableNameChanged
		send: #onGtPharoRenameVariableNameChanged:
		to: self
]
