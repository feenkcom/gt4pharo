Class {
	#name : #GtSearchMethodCategoryFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'category'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchMethodCategoryFilter class >> forCategory: aSymbol [
	^ self new
		category: aSymbol;
		yourself
]

{ #category : #comparing }
GtSearchMethodCategoryFilter >> = anObject [
	^ self class = anObject class
		and: [ self category = anObject category ]
]

{ #category : #accessing }
GtSearchMethodCategoryFilter >> category [
	^ category
]

{ #category : #accessing }
GtSearchMethodCategoryFilter >> category: aSymbol [
	(Protocol isAllProtocolName: aSymbol)
		ifTrue: [ category := Protocol gtAllProtocolDefaultName ]
		ifFalse: [ category := aSymbol ]
]

{ #category : #accessing }
GtSearchMethodCategoryFilter >> filterValueString [
	^ self category
]

{ #category : #printing }
GtSearchMethodCategoryFilter >> gtDisplayOn: stream [
	stream
		nextPutAll: self category printString;
		nextPutAll: ' method category'
]

{ #category : #comparing }
GtSearchMethodCategoryFilter >> hash [
	^ self class hash bitXor: self category hash
]

{ #category : #testing }
GtSearchMethodCategoryFilter >> includesMethod: aCompiledMethod [
	category ifNil: [ ^ true ].

	"terrible hack :)"
	(Protocol isAllProtocolName: category) ifTrue: [ ^ true ].

	^ (self 
		forPharo12AndNewer: [
			aCompiledMethod methodClass 
				protocolNameOfSelector: aCompiledMethod selector] 
		forPharo11: [
			aCompiledMethod methodClass 
				whichCategoryIncludesSelector: aCompiledMethod selector ])
	sameContentAs: category
]

{ #category : #testing }
GtSearchMethodCategoryFilter >> isMethodProtocolFilter [
	^ true
]
