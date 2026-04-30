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
		'filter',
		'isMustBeKeyword'
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

{ #category : #private }
GtPharoRenameSelectorPartModel >> adoptIncomingCurrentName: aString [
	| aNewString |
	aString ifEmpty: [ ^ aString ].
	
	isMustBeKeyword ifFalse: [ (self isValid: aString) ifTrue: [ ^ aString ] ].

	aString last = $: ifTrue: [ ^ aString ].

	aNewString := aString , ':'.
	^ (self isValid: aNewString) ifTrue: [ aNewString ] ifFalse: [ aString ]
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> announcer [
	^ announcer
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> currentDisplayName [
	^ self currentName withoutSuffix: ':'
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
	announcer := Announcer new.
	isMustBeKeyword := false.
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

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> isMustBeKeyword [

	^ isMustBeKeyword
]

{ #category : #accessing }
GtPharoRenameSelectorPartModel >> isMustBeKeyword: aBoolean [

	isMustBeKeyword := aBoolean
]

{ #category : #testing }
GtPharoRenameSelectorPartModel >> isValid [
	^ self isValid: self currentName
]

{ #category : #private }
GtPharoRenameSelectorPartModel >> isValid: aString [
	^ validator
		ifNotNil: [ :aValidator | aValidator validateSelectorPart: aString ]
		ifNil: [ true ]
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

{ #category : #'api - ui' }
GtPharoRenameSelectorPartModel >> requestHighlightChange: isHighlighted source: aSource [
	self announcer
		announce: (GtPharoRenameSelectorPartHighlightChangeRequested new
				selectorPartModel: self;
				isHighlighted: isHighlighted;
				source: aSource)
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
	| aNewString |
	aNewString := self adoptIncomingCurrentName: aString.
	currentName = aNewString ifTrue: [ ^ self ].

	currentName := aNewString.

	self announcer
		announce: (GtPharoRenameSelectorPartNameChanged new
				selectorPartModel: self;
				currentName: currentName;
				displayName: self currentDisplayName;
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
