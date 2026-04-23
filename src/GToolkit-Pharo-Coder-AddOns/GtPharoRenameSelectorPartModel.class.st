Class {
	#name : #GtPharoRenameSelectorPartModel,
	#superclass : #Object,
	#instVars : [
		'originalInterval',
		'originalIndex',
		'currentIndex',
		'announcer',
		'originalName',
		'currentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorPartModel class >> forSelectorPart: aSymbol interval: anInterval index: anIndex [
	^ self new
		initializeForSelectorPart: aSymbol
		interval: anInterval
		index: anIndex
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> announcer [
	^ announcer
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> currentIndex [
	^ currentIndex
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> currentKeyword [
	^ currentName
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> currentName [
	^ currentName
]

{ #category : #initialization }
GtPharoRenameSelectorPartModel >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #initialization }
GtPharoRenameSelectorPartModel >> initializeForSelectorPart: aSymbol interval: anInterval index: anIndex [
	originalName := aSymbol.
	originalInterval := anInterval.
	originalIndex := anIndex.
	
	currentName := aSymbol.
	currentIndex := anIndex.
]

{ #category : #testing }
GtPharoRenameSelectorPartModel >> isModified [
	^ self originalName ~= self currentName
		or: [ self originalIndex ~= self currentIndex ]
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> originalIndex [
	^ originalIndex
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> originalInterval [
	^ originalInterval
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> originalName [
	^ originalName
]

{ #category : #printing }
GtPharoRenameSelectorPartModel >> printOn: aStream [
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
GtPharoRenameSelectorPartModel >> typeName [
	^ 'keyword'
]

{ #category : #'api - updating' }
GtPharoRenameSelectorPartModel >> updateCurrentIndex: anInteger [
	currentIndex := anInteger
]

{ #category : #'api - updating' }
GtPharoRenameSelectorPartModel >> updateCurrentName: aString [
	currentName = aString ifTrue: [ ^ self ].

	currentName := aString.

	self announcer
		announce: (GtPharoRenameSelectorPartNameChanged new currentName: aString)
]
