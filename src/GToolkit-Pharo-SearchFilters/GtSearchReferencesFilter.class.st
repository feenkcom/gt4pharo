Class {
	#name : #GtSearchReferencesFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'object',
		'specialSelectorIndex',
		'isVariable'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchReferencesFilter class >> canUseOptimizedSearch: anObject [
	^ anObject isSymbol
		ifTrue: [ anObject numArgs >= 0 ]
		ifFalse: [ anObject isKindOf: GlobalVariable ]
]

{ #category : #'instance creation' }
GtSearchReferencesFilter class >> literal: anObject [
	^ ((self canUseOptimizedSearch: anObject)
		ifTrue: [ GtCachedSearchReferencesFilter ]
		ifFalse: [ self ]) new
		object: anObject;
		yourself
]

{ #category : #comparing }
GtSearchReferencesFilter >> = anObject [
	^ self class = anObject class and: [ self object = anObject object ]
]

{ #category : #testing }
GtSearchReferencesFilter >> checkForArrayReference: anObject [
	anObject isArray
		ifFalse: [ ^ false ].
	^ anObject
		anySatisfy:
			[ :each | each == self object or: [ self checkForArrayReference: each ] ]
]

{ #category : #testing }
GtSearchReferencesFilter >> checkMethodSource: aCompiledMethod [
	| ast |
	ast := aCompiledMethod ast.
	ast
		nodesDo: [ :each | 
			(each isLiteralNode and: [ each value == self object ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
GtSearchReferencesFilter >> doesMethodIncludeBytecodeLiteral: aCompiledCode [
	| stream |
	stream := InstructionStream on: aCompiledCode.
	[ stream atEnd ]
		whileFalse:
			[ | instruction |
			instruction := stream nextInstruction.
			(#methodReturnConstant: = instruction selector and: [ instruction arguments first == self object ]) ifTrue: [ ^ true ].
			(#pushConstant: = instruction selector and: [ instruction arguments first == self object ])
				ifTrue: [ ^ self checkMethodSource: aCompiledCode ] ].
	aCompiledCode
		literalsDo:
			[ :each | 
			each == self object ifTrue: [ ^ self checkMethodSource: aCompiledCode ].
			(self checkForArrayReference: each) ifTrue: [ ^ true ] ].
	aCompiledCode
		innerCompiledBlocksDo:
			[ :each | (self doesMethodIncludeBytecodeLiteral: (each isClosure ifTrue: [ each compiledBlock ] ifFalse: [ each ])) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #ui }
GtSearchReferencesFilter >> gtDisplayOn: stream [
	self object gtDisplayOn: stream.
	stream nextPutAll: ' references'.
]

{ #category : #comparing }
GtSearchReferencesFilter >> hash [
	^ self class hash bitXor: self object hash
]

{ #category : #testing }
GtSearchReferencesFilter >> includesMethod: aCompiledMethod [
	(aCompiledMethod encoderClass specialLiterals includes: self object)
		ifTrue: [ ^ self doesMethodIncludeBytecodeLiteral: aCompiledMethod ].
	^ (aCompiledMethod hasSelector: self object specialSelectorIndex: specialSelectorIndex)
		or: [ isVariable and: [ aCompiledMethod hasSelector: self object name specialSelectorIndex: specialSelectorIndex ] ]
]

{ #category : #accessing }
GtSearchReferencesFilter >> object [
	^ object
]

{ #category : #accessing }
GtSearchReferencesFilter >> object: anObject [
	object := anObject.
	specialSelectorIndex := Smalltalk specialSelectorIndexOrNil: anObject.
	isVariable := object isKindOf: Variable
]

{ #category : #ui }
GtSearchReferencesFilter >> printOn: stream [
	self object gtDisplayOn: stream.
	stream nextPutAll: ' gtReferences'.
]
