Class {
	#name : #GtPharoRenameSelectorKeywordModel,
	#superclass : #Object,
	#instVars : [
		'originalKeyword',
		'originalInterval',
		'originalIndex',
		'currentKeyword',
		'currentIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameSelectorKeywordModel class >> forSelectorPart: aSynbol interval: anInterval index: anIndex [
	^ self new
		initializeForSelectorPart: aSynbol
		interval: anInterval
		index: anIndex
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> currentIndex [
	^ currentIndex
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> currentKeyword [
	^ currentKeyword
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> currentName [
	^ self currentKeyword
]

{ #category : #initialization }
GtPharoRenameSelectorKeywordModel >> initializeForSelectorPart: aSymbol interval: anInterval index: anIndex [
	originalKeyword := aSymbol.
	originalInterval := anInterval.
	originalIndex := anIndex.
	
	currentKeyword := aSymbol.
	currentIndex := anIndex.
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> originalIndex [
	^ originalIndex
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> originalInterval [
	^ originalInterval
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> originalKeyword [
	^ originalKeyword
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> originalName [
	^ self originalKeyword
]

{ #category : #printing }
GtPharoRenameSelectorKeywordModel >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: originalKeyword asString;
		nextPutAll: ' [';
		print: (originalInterval ifNotNil: #first);
		nextPutAll: '..';
		print: (originalInterval ifNotNil: #last);
		nextPut: $];
		nextPut: $)
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordModel >> typeName [
	^ 'keyword'
]

{ #category : #'api - updating' }
GtPharoRenameSelectorKeywordModel >> updateCurrentIndex: anInteger [
	currentIndex := anInteger
]

{ #category : #'api - updating' }
GtPharoRenameSelectorKeywordModel >> updateCurrentName: aString [
	currentKeyword := aString
]
