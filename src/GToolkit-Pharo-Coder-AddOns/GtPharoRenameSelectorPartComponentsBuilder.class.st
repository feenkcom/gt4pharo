Class {
	#name : #GtPharoRenameSelectorPartComponentsBuilder,
	#superclass : #Object,
	#instVars : [
		'astNode',
		'validator',
		'filter',
		'styler'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartComponentsBuilder >> astNode [
	^ astNode
]

{ #category : #accessing }
GtPharoRenameSelectorPartComponentsBuilder >> astNode: anObject [
	astNode := anObject
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorPartComponentsBuilder >> build [
	astNode arguments
		ifNotEmpty: [ :aCollection | 
			aCollection size = 1
				ifTrue: [ self buildBinaryOrKeywordComponents ]
				ifFalse: [ self buildKeywordComponents ] ]
		ifEmpty: [ self buildUnaryMessageComponents ]
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorPartComponentsBuilder >> buildBinaryOrKeywordComponents [
	validator := GtPharoRenameSelectorBinaryOrKeywordPartValidator new.
	styler := GtSelectorStyler new forBinaryOrKeyword.
	filter := GtSelectorInputFilter forBinaryOrKeywordMessage
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorPartComponentsBuilder >> buildKeywordComponents [
	validator := GtPharoRenameSelectorKeywordPartValidator new.
	styler := GtSelectorStyler new forKeyword.
	filter := GtSelectorInputFilter forKeywordMessage
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorPartComponentsBuilder >> buildUnaryMessageComponents [
	validator := GtPharoRenameSelectorUnaryPartValidator new.
	styler := GtSelectorStyler new forUnary.
	filter := GtSelectorInputFilter forUnaryMessage
]

{ #category : #accessing }
GtPharoRenameSelectorPartComponentsBuilder >> filter [
	^ filter
]

{ #category : #accessing }
GtPharoRenameSelectorPartComponentsBuilder >> styler [
	^ styler
]

{ #category : #accessing }
GtPharoRenameSelectorPartComponentsBuilder >> validator [
	^ validator
]
