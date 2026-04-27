Class {
	#name : #GtPharoRenameSelectorParameterModel,
	#superclass : #Object,
	#instVars : [
		'originalName',
		'originalInterval',
		'originalIndex',
		'currentIndex',
		'currentName',
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorParameterModel class >> forAstVariableNodeArgument: anAstVariableNode index: anIndex [
	^ self new initializeForAstVariableNode: anAstVariableNode index: anIndex
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> announcer [
	^ announcer
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
GtPharoRenameSelectorParameterModel >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #initialization }
GtPharoRenameSelectorParameterModel >> initializeForAstVariableNode: anAstVariableNode index: anIndex [
	originalName := anAstVariableNode name.
	originalInterval := anAstVariableNode start to: anAstVariableNode stop.
	originalIndex := anIndex.
	
	currentName := originalName.
	currentIndex := originalIndex.
]

{ #category : #testing }
GtPharoRenameSelectorParameterModel >> isModified [
	^ self originalName ~= self currentName
		or: [ self originalIndex ~= self currentIndex ]
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

{ #category : #'api - ui' }
GtPharoRenameSelectorParameterModel >> requestHighlightChange: isHighlighted source: aSource [
	self announcer
		announce: (GtPharoRenameSelectorParameterHighlightChangeRequested new
				parameterModel: self;
				isHighlighted: isHighlighted;
				source: aSource)
]

{ #category : #accessing }
GtPharoRenameSelectorParameterModel >> typeName [
	^ 'parameter'
]

{ #category : #'api - updating' }
GtPharoRenameSelectorParameterModel >> updateCurrentIndex: anInteger source: aSource [
	currentIndex := anInteger.

	self announcer
		announce: (GtPharoRenameSelectorParameterIndexChanged new
				parameterModel: self;
				currentIndex: anInteger;
				source: aSource)
]

{ #category : #'api - updating' }
GtPharoRenameSelectorParameterModel >> updateCurrentName: aString source: aSource [
	currentName = aString ifTrue: [ ^ self ].

	currentName := aString.

	self announcer
		announce: (GtPharoRenameSelectorParameterNameChanged new
				parameterModel: self;
				currentName: aString;
				source: aSource)
]
