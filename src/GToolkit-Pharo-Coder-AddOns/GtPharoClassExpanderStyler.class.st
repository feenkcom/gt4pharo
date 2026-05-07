"
I expand direct class references
"
Class {
	#name : #GtPharoClassExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'attributesCache'
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

{ #category : #initialization }
GtPharoClassExpanderStyler >> initialize [
	super initialize.
	self initializeAttributesCache.
]

{ #category : #initialization }
GtPharoClassExpanderStyler >> initializeAttributesCache [
	attributesCache := AsyncSharedWeakIdentityKeyDictionary new
]

{ #category : #'visiting - variables' }
GtPharoClassExpanderStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	self class usedVersion = 5
		ifTrue: [ ^ self visitDeclaredGlobalVariable_05_marker: aNamedVariable ].
	self class usedVersion = 4
		ifTrue: [ ^ self visitDeclaredGlobalVariable_04_marker: aNamedVariable ].
	self class usedVersion = 3
		ifTrue: [ ^ self visitDeclaredGlobalVariable_03_cacheVersion: aNamedVariable ].
	self class usedVersion = 2
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
				newAttribute := GtPharoClassExpanderWithMarkerHidingElementAttribute
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
GtPharoClassExpanderStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.
	
	self class isStylerEnabled ifFalse: [ ^ self ].
	
	(self coderViewModel hasDeclaredGlobalNamed: aNamedVariable variableName)
		ifTrue: [ ^ self visitDeclaredGlobalVariable: aNamedVariable ]
]
