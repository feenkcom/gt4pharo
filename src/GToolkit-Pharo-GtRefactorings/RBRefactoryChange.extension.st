Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol [
	attributes isNil ifTrue: [ ^ nil ].
	^ attributes at: aSymbol ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol ifAbsent: aBlock [
	^ self attributes at: aSymbol ifAbsent: aBlock
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol ifAbsentPut: aBlock [
	^ self attributes at: aSymbol ifAbsentPut: aBlock
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol put: aValue [
	^ self attributes at: aSymbol put: aValue
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributes [
	^ attributes ifNil: [ attributes := IdentityDictionary new ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtBasicChanges [
	| changes |
	changes := OrderedCollection new.
	self gtBasicChangesInto: changes.
	^ changes
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtBasicChangesInto: changes [
	self isBasicChange ifTrue: [ changes add: self ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeEmpty
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> isBasicChange [
	^ true
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> postCopy [
	super postCopy.
	attributes := attributes ifNotNil: [ attributes copy ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> transformation [
	^ self attributeNamed: #transformations
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> transformation: aTransformation [
	self attributeNamed: #transformations put: aTransformation
]
