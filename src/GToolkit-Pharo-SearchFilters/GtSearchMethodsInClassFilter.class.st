Class {
	#name : #GtSearchMethodsInClassFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#instVars : [
		'includeSubclasses',
		'includeSuperclass',
		'upToSuperclass'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchMethodsInClassFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
		and: [ self filterClass = anObject filterClass
		and: [ self includeSubclasses = anObject includeSubclasses
		and: [ self includeSuperclass = anObject includeSuperclass
		and: [ self upToSuperclass = anObject upToSuperclass ] ] ] ]
]

{ #category : #storing }
GtSearchMethodsInClassFilter >> addStoreCreationCodeConfigurationMessagesTo: aCollection [
	"Subclasses can add configuration messages required to recreate their state."
]

{ #category : #accessing }
GtSearchMethodsInClassFilter >> defaultFilterScope [
	| theStreams isClassSide subclassesBlock |
	theStreams := OrderedCollection new.

	theStreams add: (AsyncBehaviorAllMethodsStream forBehavior: filterClass).

	includeSuperclass
		ifTrue: [ theStreams
				add: (filterClass allSuperclasses asAsyncStream
						map: [ :eachBehavior | AsyncBehaviorAllMethodsStream forBehavior: eachBehavior ])
						flatten ].

	includeSubclasses
		ifTrue: [ isClassSide := filterClass isClassSide.
			subclassesBlock := [ :each | each subclasses select: [ :sub | sub isClassSide = isClassSide ] ].
			theStreams
				add: ((AsyncDepthFirstTraversalStream new
						roots: (subclassesBlock value: filterClass)
						children: subclassesBlock)
						map: [ :eachBehavior | AsyncBehaviorAllMethodsStream forBehavior: eachBehavior ])
						flatten ].

	^ theStreams asAsyncStream flatten
]

{ #category : #printing }
GtSearchMethodsInClassFilter >> gtDisplayOn: stream [
	stream
		print: filterClass;
		nextPutAll: ' methodsInClass'
]

{ #category : #comparing }
GtSearchMethodsInClassFilter >> hash [
	^ self class hash
		bitXor: (self filterClass hash
				bitXor: (self includeSubclasses hash 
					bitXor: self includeSuperclass))
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includeSubclasses [
	^ includeSubclasses
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> includeSubclasses: anObject [
	includeSubclasses := anObject
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includeSuperclass [
	^ includeSuperclass
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> includeSuperclass: aBoolean [
	includeSuperclass := aBoolean
]

{ #category : #testing }
GtSearchMethodsInClassFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	filterClass ifNil: [ ^ false ].
	methodClass := aCompiledMethod methodClass.
	methodClass = filterClass ifTrue: [ ^ true ].
	^ (includeSubclasses and: [ methodClass includesBehavior: filterClass ])
		or: [ includeSuperclass
				and: [ (filterClass includesBehavior: methodClass)
						and: [ upToSuperclass isNil
								or: [ upToSuperclass superclass isNil
										or: [ (upToSuperclass superclass includesBehavior: methodClass) not ] ] ] ] ]
]

{ #category : #'initialize-release' }
GtSearchMethodsInClassFilter >> initialize [
	super initialize.
	includeSubclasses := false.
	includeSuperclass := false
]

{ #category : #enumerating }
GtSearchMethodsInClassFilter >> methodsDo: aBlock [
	filterClass methods do: aBlock.
	includeSuperclass
		ifTrue: [ filterClass superclass methods do: aBlock ].
	includeSubclasses
		ifTrue: [ (filterClass allSubclasses flatCollect: #methods) do: aBlock ]
]

{ #category : #storing }
GtSearchMethodsInClassFilter >> storeCreationCodeConfigurationMessages [
	| configurationMessages |
	configurationMessages := OrderedCollection new.
	self includeSubclasses ifTrue: [ configurationMessages add: 'withSubclasses' ].
	self upToSuperclass
		ifNotNil: [ :aClass |
			configurationMessages add: 'withSuperclassesUpTo: ', aClass name ]
		ifNil: [
			self includeSuperclass ifTrue: [
				configurationMessages add: 'withSuperclasses' ] ].
	self addStoreCreationCodeConfigurationMessagesTo: configurationMessages.
	^ configurationMessages
]

{ #category : #storing }
GtSearchMethodsInClassFilter >> storeCreationCodeInitialCode [
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self class name;
			nextPutAll: ' forClass: ';
			nextPutAll: self filterClass name ]
]

{ #category : #storing }
GtSearchMethodsInClassFilter >> storeCreationCodeOn: aStream [
	| configurationMessages |
	configurationMessages := self storeCreationCodeConfigurationMessages.
	configurationMessages
		ifEmpty: [ aStream nextPutAll: self storeCreationCodeInitialCode ]
		ifNotEmpty: [
			aStream
				nextPut: $(;
				nextPutAll: self storeCreationCodeInitialCode;
				nextPutAll: ') '.
			configurationMessages
				do: [ :each | aStream nextPutAll: each ]
				separatedBy: [ aStream nextPutAll: '; ' ] ].
]

{ #category : #accessing }
GtSearchMethodsInClassFilter >> upToSuperclass [
	^ upToSuperclass
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSubclasses [
	self includeSubclasses: true
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSuperclasses [
	self includeSuperclass: true
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withSuperclassesUpTo: aClass [
	self withSuperclasses.
	upToSuperclass := aClass
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withoutSubclasses [
	self includeSubclasses: false
]

{ #category : #scripting }
GtSearchMethodsInClassFilter >> withoutSuperclasses [
	self includeSuperclass: false
]
