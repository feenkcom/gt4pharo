Class {
	#name : #GtPharoRenameSelectorPartModel,
	#superclass : #Object,
	#instVars : [
		'originalInterval',
		'originalIndex',
		'currentIndex',
		'announcer',
		'originalName',
		'currentName',
		'validator',
		'styler',
		'filter'
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

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> filter [
	^ filter
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> filter: anObject [
	filter := anObject
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
]

{ #category : #'api - ui' }
GtPharoRenameSelectorPartModel >> notifyFocusRequested [
	self announcer
		announce: (GtPharoRenameSelectorPartFocusRequested new selectorPartModel: self)
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
		nextPutAll: currentName asString;
		nextPutAll: ' [';
		print: (originalInterval ifNotNil: #first);
		nextPutAll: '..';
		print: (originalInterval ifNotNil: #last);
		nextPut: $];
		nextPut: $)
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> styler [
	^ styler
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> styler: anObject [
	styler := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> typeName [
	^ 'keyword'
]

{ #category : #'api - updating' }
GtPharoRenameSelectorPartModel >> updateCurrentIndex: anInteger source: aSource [
	currentIndex := anInteger
]

{ #category : #'api - updating' }
GtPharoRenameSelectorPartModel >> updateCurrentName: aString source: aSource [
	currentName = aString ifTrue: [ ^ self ].

	currentName := aString.

	self announcer
		announce: (GtPharoRenameSelectorPartNameChanged new
				selectorPartModel: self;
				currentName: aString;
				isModified: self isModified;
				source: aSource)
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> validator [
	^ validator
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> validator: anObject [
	validator := anObject
]
