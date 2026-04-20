Class {
	#name : #GtPharoRenameSelectorParameterModel,
	#superclass : #Object,
	#instVars : [
		'originalName',
		'originalInterval',
		'originalIndex',
		'currentIndex',
		'currentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorParameterModel class >> forAstVariableNodeArgument: anAstVariableNode index: anIndex [
	^ self new initializeForAstVariableNode: anAstVariableNode index: anIndex
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> currentIndex [
	^ currentIndex
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> currentName [
	^ currentName
]

{ #category : #initialization }
GtPharoRenameSelectorParameterModel >> initializeForAstVariableNode: anAstVariableNode index: anIndex [
	originalName := anAstVariableNode name.
	originalInterval := anAstVariableNode start to: anAstVariableNode stop.
	originalIndex := anIndex.
	
	currentName := originalName.
	currentIndex := originalIndex.
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> originalIndex [
	^ originalIndex
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> originalInterval [
	^ originalInterval
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> originalName [
	^ originalName
]

{ #category : #printing }
GtPharoRenameSelectorParameterModel >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: originalName asString;
		nextPutAll: ' [';
		print: (originalInterval ifNotNil: #first);
		nextPutAll: '..';
		print: (originalInterval ifNotNil: #last);
		nextPut: $];
		nextPut: $)
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> typeName [
	^ 'parameter'
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorParameterModel >> updateCurrentIndex: anInteger [
	currentIndex := anInteger
]

{ #category : #'api - updating' }
GtPharoRenameSelectorParameterModel >> updateCurrentName: aString [
	currentName := aString
]
