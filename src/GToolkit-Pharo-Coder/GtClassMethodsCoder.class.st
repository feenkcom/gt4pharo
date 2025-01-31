Class {
	#name : #GtClassMethodsCoder,
	#superclass : #GtFilteredMethodsCoder,
	#instVars : [
		'class',
		'object',
		'filteredClasses'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtClassMethodsCoder class >> forClass: aBehavior [
	^ self new
		forClass: aBehavior;
		yourself
]

{ #category : #'instance creation' }
GtClassMethodsCoder class >> forObject: anObject [
	^ self new
		forObject: anObject;
		yourself
]

{ #category : #actions }
GtClassMethodsCoder >> addMethodsForClass: aClass [
	(filteredClasses includes: aClass)
		ifTrue: [ ^ self ].
	filteredClasses add: aClass.
	self updateMethods.
	self updateCoders
]

{ #category : #actions }
GtClassMethodsCoder >> addNewCoder [
	| aCoder |
	aCoder := GtPharoMethodCoder forNewMethod: self newMethodClass.
	aCoder protocol: #accessing.
	aCoder coders: self.
	self addFirstCoder: aCoder.
	^ aCoder
]

{ #category : #private }
GtClassMethodsCoder >> classesFilter [
	| filter |
	filter := nil.
	filteredClasses
		do: [ :each | 
			| classFilter |
			classFilter := GtSearchMethodsInInstanceAndClassSideFilter forClass: each.
			filter := filter isNil
				ifTrue: [ classFilter ]
				ifFalse: [ filter | classFilter ] ].
	^ filter
]

{ #category : #accessing }
GtClassMethodsCoder >> classOrMetaClass [
	^ class
]

{ #category : #accessing }
GtClassMethodsCoder >> codeGeneratorsAvailableFor: aMethodsCoderViewModel [
	^ (self codeGeneratorsFor: aMethodsCoderViewModel) size > 0
]

{ #category : #elements }
GtClassMethodsCoder >> codeGeneratorsFor: aMethodsCoderUIModel [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtCodeGenerator;
		context: aMethodsCoderUIModel;
		collect
]

{ #category : #private }
GtClassMethodsCoder >> combinedFilter [
	| combined |
	combined := super combinedFilter.
	^ self classesFilter
		ifNil: [ combined ]
		ifNotNil:
			[ :filter | combined ifNil: [ filter ] ifNotNil: [ filter & combined ] ]
]

{ #category : #testing }
GtClassMethodsCoder >> filteredClass: aBehavior [
	^ filteredClasses includes: aBehavior
]

{ #category : #elements }
GtClassMethodsCoder >> filterTypes [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtFilterTypes;
		collect
]

{ #category : #initialize }
GtClassMethodsCoder >> forClass: aBehavior [
	class := aBehavior.
	filteredClasses := Set with: aBehavior.
	self forFilter: (GtSearchMethodsInInstanceAndClassSideFilter forClass: class)
]

{ #category : #initialize }
GtClassMethodsCoder >> forObject: anObject [
	object := anObject.
	self forClass: anObject class
]

{ #category : #printing }
GtClassMethodsCoder >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: class name;
		nextPutAll: ' methods'
]

{ #category : #testing }
GtClassMethodsCoder >> hasFilter [
	^ filteredClasses notEmpty
]

{ #category : #initialize }
GtClassMethodsCoder >> initialize [
	super initialize.
	filteredClasses := Set new
]

{ #category : #testing }
GtClassMethodsCoder >> isForClass [
	^ true
]

{ #category : #private }
GtClassMethodsCoder >> newCoderFor: aMethod [
	^ super newCoderFor: aMethod
]

{ #category : #private }
GtClassMethodsCoder >> newMethodClass [
	| methodClass |
	methodClass := filteredClasses anyOne.
	filteredClasses
		do: [ :each | 
			(methodClass includesBehavior: each)
				ifFalse: [ methodClass := each ] ].
	^ methodClass
]

{ #category : #accessing }
GtClassMethodsCoder >> object [
	^ object
]

{ #category : #actions }
GtClassMethodsCoder >> removeMethodsForClass: aClass [
	| oldCoders |
	(filteredClasses includes: aClass)
		ifFalse: [ ^ self ].
	filteredClasses remove: aClass.
	self updateMethods.
	oldCoders := coders.
	coders := coders
		reject: [ :each | 
			(each classOrMetaClass = aClass
				or: [ each classOrMetaClass = aClass classSide ])
				and: [ each isModified not ] ].
	self
		announce:
			(GtCodersCodersChanged new
				coders: self;
				oldCoders: oldCoders;
				newCoders: coders;
				yourself)
]

{ #category : #private }
GtClassMethodsCoder >> shouldSort: a before: b [
	a selector isNil
		ifTrue: [ ^ b selector notNil
				or: [ a classOrMetaClass allSuperclasses size
						>= b classOrMetaClass allSuperclasses size ] ].
	b selector isNil
		ifTrue: [ ^ false ].
	a selector < b selector
		ifTrue: [ ^ true ].
	a selector > b selector
		ifTrue: [ ^ false ].
	^ a behavior allSuperclasses size >= b behavior allSuperclasses size
]
