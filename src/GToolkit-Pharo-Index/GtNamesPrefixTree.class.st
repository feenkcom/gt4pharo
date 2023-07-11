Class {
	#name : #GtNamesPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'names'
	],
	#category : #'GToolkit-Pharo-Index-GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtNamesPrefixTree >> addName: aSymbol [
	names
		ifNil: [ names := aSymbol ]
		ifNotNil: [ names class == OrderedCollection
				ifFalse: [ names := names isArray
							ifTrue: [ names := names asOrderedCollection ]
							ifFalse: [ OrderedCollection with: names ] ].
			names add: aSymbol ]
]

{ #category : #accessing }
GtNamesPrefixTree >> compressData [
	super compressData.
	(names isCollection and: [ names isString not ])
		ifTrue: [ names := names asArray ]
]

{ #category : #accessing }
GtNamesPrefixTree >> gtLocalSizeInMemory [
	^ super gtLocalSizeInMemory
		+ ((names isArray or: [ names class == OrderedCollection ])
				ifTrue: [ names gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #accessing }
GtNamesPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild names: names.
	names := nil
]

{ #category : #accessing }
GtNamesPrefixTree >> names [
	^ names
]

{ #category : #accessing }
GtNamesPrefixTree >> names: anObject [
	names := anObject
]

{ #category : #accessing }
GtNamesPrefixTree >> namesCollection [
	^ names
		ifNil: [ #() ]
		ifNotNil: [ names isString ifTrue: [ ^ {names} ] ifFalse: [ names asSet ] ]
]

{ #category : #accessing }
GtNamesPrefixTree >> removeName: aMethod [
	names ifNil: [ ^ self ].
	names == aMethod ifTrue: [ ^ names := nil ].
	names isArray ifTrue: [ names := names asOrderedCollection ].
	names class == OrderedCollection ifFalse: [ ^ self ].
	names remove: aMethod ifAbsent: [  ]
]
