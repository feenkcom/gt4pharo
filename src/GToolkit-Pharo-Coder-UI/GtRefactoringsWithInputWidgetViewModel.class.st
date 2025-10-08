Class {
	#name : #GtRefactoringsWithInputWidgetViewModel,
	#superclass : #GtRefactoringsViewModel,
	#instVars : [
		'inputElement',
		'refactoringsWithInputComputation'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Core'
}

{ #category : #'api - converting' }
GtRefactoringsWithInputWidgetViewModel >> asPreviewElement [
	^ GtRefactoringsWithInputWidgetElement new refactoringsViewModel: self
]

{ #category : #views }
GtRefactoringsWithInputWidgetViewModel >> gtOverview [
	^ super gtOverview
		, {GtPhlowOverviewItem new
					name: 'Input element';
					value: inputElement }
]

{ #category : #accessing }
GtRefactoringsWithInputWidgetViewModel >> inputElement [
	^ inputElement
]

{ #category : #accessing }
GtRefactoringsWithInputWidgetViewModel >> inputElement: anElement [
	self assert: [ anElement isNil or: [ anElement isKindOf: BlElement ] ].

	inputElement = anElement ifTrue: [ ^ self ].

	inputElement := anElement.
	self notifyInputElementChanged
]

{ #category : #'private - notifying' }
GtRefactoringsWithInputWidgetViewModel >> notifyInputElementChanged [
	| anAnnouncement |
	anAnnouncement := GtRefactoringsViewModelInputElementChanged new
			refactoringsViewModel: self;
			inputElement: self inputElement.

	self announce: anAnnouncement
]
