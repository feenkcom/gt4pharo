Class {
	#name : #GtPharoMethodModificationIndicator,
	#superclass : #Object,
	#instVars : [
		'behaviorSource',
		'compiledMethod',
		'modifiedAst',
		'prospectiveSelector'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification Model'
}

{ #category : #accessing }
GtPharoMethodModificationIndicator >> behavior [
	^ behaviorSource ifNotNil: #behavior
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> behaviorName [
	^ self behavior ifNotNil: #name
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> behaviorSource [
	^ behaviorSource
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> behaviorSource: anObject [
	behaviorSource := anObject
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #printing }
GtPharoMethodModificationIndicator >> gtDisplayOn: aStream [
	self behaviorSource
		ifNotNil: [ :aSource | aSource gtDisplayOn: aStream ]
		ifNil: [ aStream nextPutAll: 'Unknown behavior: ' ].

	aStream nextPutAll: ' ('.
	self printIndicatorOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'api - testing' }
GtPharoMethodModificationIndicator >> isChangeIndicationRequired [
	"Return true if a user should be informed about the change, false otherwise."

	<return: #Boolean>
	^ false
]

{ #category : #converting }
GtPharoMethodModificationIndicator >> listItemElementClass [
	^ GtPharoMethodModificationSimpleIndicatorElement
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> modifiedAst [
	^ modifiedAst
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> modifiedAst: anObject [
	modifiedAst := anObject
]

{ #category : #printing }
GtPharoMethodModificationIndicator >> printIndicatorOn: aStream [
	aStream print: self class.
	aStream nextPutAll: ': '.
	aStream print: self prospectiveSelector
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> prospectiveSelector [
	^ prospectiveSelector
]

{ #category : #accessing }
GtPharoMethodModificationIndicator >> prospectiveSelector: anObject [
	prospectiveSelector := anObject
]
