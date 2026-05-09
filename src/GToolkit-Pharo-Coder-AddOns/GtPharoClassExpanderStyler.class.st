"
I expand direct class references
"
Class {
	#name : #GtPharoClassExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'attributesCache',
		'behaviorCache',
		'lastIndex',
		'usedVersion'
	],
	#classInstVars : [
		'isStylerEnabled',
		'usedVersion'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #accessing }
GtPharoClassExpanderStyler class >> isStylerEnabled [
	^ isStylerEnabled ifNil: [ true ]
]

{ #category : #accessing }
GtPharoClassExpanderStyler class >> isStylerEnabled: aBoolean [
	isStylerEnabled := aBoolean
]

{ #category : #accessing }
GtPharoClassExpanderStyler class >> usedVersion [
	^ usedVersion ifNil: [ 1 ]
]

{ #category : #accessing }
GtPharoClassExpanderStyler class >> usedVersion: anInteger [
	usedVersion := anInteger
]

{ #category : #private }
GtPharoClassExpanderStyler >> attributesCache [
	attributesCache ifNil: [ self initializeAttributesCache ].

	^ attributesCache
]

{ #category : #private }
GtPharoClassExpanderStyler >> coderCache [
	behaviorCache ifNil: [ self initializeCoderCache ].
	^ behaviorCache
]

{ #category : #views }
GtPharoClassExpanderStyler >> gtAttributesCacheFor: aView [
	<gtView>
	^ aView forward
		title: 'AST cache';
		object: [ attributesCache ];
		view: #gtItemsFor:
]

{ #category : #views }
GtPharoClassExpanderStyler >> gtBehaviorCacheFor: aView [
	<gtView>
	^ aView forward
		title: 'Behavior cache';
		object: [ behaviorCache ];
		view: #gtDictionaryFor:
]

{ #category : #initialization }
GtPharoClassExpanderStyler >> initialize [
	super initialize.
	
	lastIndex := 0.
	
	self initializeAttributesCache.
	self initializeCoderCache.
]

{ #category : #initialization }
GtPharoClassExpanderStyler >> initializeAttributesCache [
	attributesCache := AsyncSharedWeakIdentityKeyDictionary new
]

{ #category : #initialization }
GtPharoClassExpanderStyler >> initializeCoderCache [
	behaviorCache := GtPharoClassExpanderCache new
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> nextIndex [
	^ lastIndex := (lastIndex ifNil: [ 0 ]) + 1
]

{ #category : #development }
GtPharoClassExpanderStyler >> privateAttributesCache [
	"Development (examples) purpose only"

	^ attributesCache
]

{ #category : #development }
GtPharoClassExpanderStyler >> privateBehaviorCache [
	"Development (examples) purpose only"

	^ behaviorCache
]

{ #category : #'api - styling' }
GtPharoClassExpanderStyler >> style: aText ast: theAst [
	behaviorCache ifNotNil: [ :aCache | aCache resetIndexing ].
	lastIndex := 0.

	self usedVersion = 6
		ifFalse: [ super style: aText ast: theAst ]
		ifTrue: [ text := aText.
			[ self accept: theAst ] ensure: [ text := nil ] ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> usedVersion [
	^ usedVersion ifNil: [ usedVersion := self class usedVersion ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	self usedVersion = 6
		ifTrue: [ ^ self visitDeclaredGlobalVariable_06_extraCache: aNamedVariable ].
	self usedVersion = 5
		ifTrue: [ ^ self visitDeclaredGlobalVariable_05_marker: aNamedVariable ].
	self usedVersion = 4
		ifTrue: [ ^ self visitDeclaredGlobalVariable_04_marker: aNamedVariable ].
	self usedVersion = 3
		ifTrue: [ ^ self visitDeclaredGlobalVariable_03_cacheVersion: aNamedVariable ].
	self usedVersion = 2
		ifTrue: [ ^ self visitDeclaredGlobalVariable_02_cacheVersion: aNamedVariable ].

	self visitDeclaredGlobalVariable_01_originalVersion: aNamedVariable
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_01_originalVersion: aNamedVariable [
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].
	text
		attribute: (GtPharoClassExpanderAttribute
				forClass: (self class environment at: aNamedVariable variableName))
		from: aNamedVariable stopPosition
		to: aNamedVariable stopPosition
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_02_cacheVersion: aNamedVariable [
	"Just care about the cached attribute"

	| anAttribute |
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].

	anAttribute := attributesCache
			at: aNamedVariable
			ifPresent: [ :existingAttribute | existingAttribute ]
			ifAbsentPut: [ GtPharoClassExpanderAttribute
					forClass: (self class environment at: aNamedVariable variableName) ].

	text
		attribute: anAttribute
		from: aNamedVariable stopPosition
		to: aNamedVariable stopPosition
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_03_cacheVersion: aNamedVariable [
	"Care about the cached attribute and expanded attributes"

	| attributeOrAttributes |
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].

	attributeOrAttributes := attributesCache
			at: aNamedVariable
			ifPresent: [ :existingAttribute | 
				Array
					streamContents: [ :aStream | 
						aStream nextPut: existingAttribute.
						existingAttribute createdAttributesInto: aStream ] ]
			ifAbsentPut: [ GtPharoClassExpanderAttribute
					forClass: (self class environment at: aNamedVariable variableName) ].

	attributeOrAttributes asCollection
		do: [ :eachAttribute | 
			text
				attribute: eachAttribute
				from: aNamedVariable stopPosition
				to: aNamedVariable stopPosition ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_04_marker: aNamedVariable [
	"Care about the cached attribute and expanded attributes.
	Use marker to define where to put expanded attributes."

	| someAttributes |
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].

	someAttributes := self attributesCache
			at: aNamedVariable
			ifPresent: [ :aCollection | 
				| existingMarker existingAttribute |
				existingMarker := aCollection first.
				existingAttribute := aCollection second.
				existingAttribute isExpanded
					ifTrue: [ Array
							streamContents: [ :aStream | 
								aStream nextPutAll: aCollection.
								existingAttribute createdAttributesInto: aStream ] ]
					ifFalse: [ aCollection ] ]
			ifAbsentPut: [ | newAttribute newMarker |
				newMarker := BrTextInvisibleMarkerAttribute new beNotOverwritableByStyler.
				newAttribute := GtPharoClassExpanderWithMarkerAttribute
						forClass: (self class environment at: aNamedVariable variableName).
				newAttribute markerAttribute: newMarker.
				{newMarker.
					newAttribute} ].

	someAttributes
		do: [ :eachAttribute | 
			text
				attribute: eachAttribute
				from: aNamedVariable stopPosition
				to: aNamedVariable stopPosition ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_05_marker: aNamedVariable [
	"Care about the cached attribute and expanded attributes.
	Use marker to define where to put expanded attributes.
	Hide/show collapsed/expanded elements, instead of removing attributes."

	| someAttributes |
	(self class environment at: aNamedVariable variableName) isBehavior
		ifFalse: [ ^ self ].

	someAttributes := self attributesCache
			at: aNamedVariable
			ifPresent: [ :aCollection | 
				| existingMarker existingAttribute |
				existingMarker := aCollection first.
				existingAttribute := aCollection second.
				existingAttribute isExpanded
					ifTrue: [ Array
							streamContents: [ :aStream | 
								aStream nextPutAll: aCollection.
								existingAttribute createdAttributesInto: aStream ] ]
					ifFalse: [ aCollection ] ]
			ifAbsentPut: [ | newAttribute newMarker newIndex |
				newMarker := BrTextInvisibleMarkerAttribute new beNotOverwritableByStyler.
				newAttribute := GtPharoClassExpanderWithMarkerHidingElementAttribute
						forClass: (self class environment at: aNamedVariable variableName).
				newIndex := self nextIndex.
				newAttribute id: (GtPharoBehaviorExpanderId indexed: newIndex).
				newAttribute expandedId: (GtPharoExpandedBehaviorId indexed: newIndex).
				newAttribute markerAttribute: newMarker.
				{newMarker.
					newAttribute} ].

	someAttributes
		do: [ :eachAttribute | 
			text
				attribute: eachAttribute
				from: aNamedVariable stopPosition
				to: aNamedVariable stopPosition ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable_06_extraCache: aNamedVariable [
	"Care about the cached attribute and expanded attributes.
	Use marker to define where to put expanded attributes.
	Hide/show collapsed/expanded elements, instead of removing attributes.
	Preserve expander attribute even when the AST node is lost to display the same widget
	again when a similar AST not appears."

	| someAttributes shouldAddCreatedAttributes aBehavior |
	(aBehavior := self class environment at: aNamedVariable variableName)
		isBehavior ifFalse: [ ^ self ].

	shouldAddCreatedAttributes := false.
	someAttributes := self attributesCache
			at: aNamedVariable
			ifPresent: [ :aCollection | 
				shouldAddCreatedAttributes := true.
				aCollection ]
			ifAbsentPut: [ | newAttribute newMarker |
				self coderCache
					attributesForAstNode: aNamedVariable
					class: aBehavior
					ifPresent: [ :aCollection | 
						shouldAddCreatedAttributes := true.
						aCollection ]
					ifAbsentPut: [ | newIndex |
						newMarker := BrTextInvisibleMarkerAttribute new beNotOverwritableByStyler.
						newAttribute := GtPharoClassExpanderWithMarkerHidingElementAttribute
								forClass: aBehavior.
						newIndex := self nextIndex.
						newAttribute id: (GtPharoBehaviorExpanderId indexed: newIndex).
						newAttribute expandedId: (GtPharoExpandedBehaviorId indexed: newIndex).
						newAttribute markerAttribute: newMarker.

						{newMarker.
							newAttribute} ] ].

	shouldAddCreatedAttributes
		ifTrue: [ someAttributes := Array
				streamContents: [ :aStream | 
					aStream nextPutAll: someAttributes.
					someAttributes second createdAttributesInto: aStream ] ].

	someAttributes
		do: [ :eachAttribute | 
			text
				attribute: eachAttribute
				from: aNamedVariable stopPosition
				to: aNamedVariable stopPosition ]
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.
	
	self class isStylerEnabled ifFalse: [ ^ self ].
	
	(self coderViewModel hasDeclaredGlobalNamed: aNamedVariable variableName)
		ifTrue: [ ^ self visitDeclaredGlobalVariable: aNamedVariable ]
]
