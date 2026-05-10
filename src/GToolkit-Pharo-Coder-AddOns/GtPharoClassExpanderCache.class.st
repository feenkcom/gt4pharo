Class {
	#name : #GtPharoClassExpanderCache,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'dictionary'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #converting }
GtPharoClassExpanderCache >> asArray [
	^ monitor critical: [ dictionary asArray ]
]

{ #category : #accessing }
GtPharoClassExpanderCache >> associations [
	^ monitor critical: [ dictionary associations ]
]

{ #category : #'api - cache' }
GtPharoClassExpanderCache >> attributesForAstNode: anAstNode class: aClass ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ monitor
		critical: [ dictionary
				at: aClass
				ifPresent: [ :existingItem | 
					| itemAttributes |
					itemAttributes := existingItem
							attributesForAstNode: anAstNode
							ifPresent: [ :anItemAttributes | 
								aPresentBlock value: anItemAttributes ]
							ifAbsentPut: anAbsentBlock.
					itemAttributes attributes ]
				ifAbsent: [ | newAttributes newItem |
					newAttributes := anAbsentBlock value.
					newItem := GtPharoClassExpanderCacheItem new
							behavior: aClass;
							astNode: anAstNode attributes: newAttributes.
					dictionary at: aClass put: newItem.
					newAttributes ] ]
]

{ #category : #views }
GtPharoClassExpanderCache >> gtDictionaryFor: aView [
	<gtView>
	dictionary ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items';
		items: [ dictionary associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #initialization }
GtPharoClassExpanderCache >> initialize [
	super initialize.

	monitor := Mutex new.
	dictionary := WeakKeyDictionary new
]

{ #category : #accessing }
GtPharoClassExpanderCache >> numberOfItemAttributes [
	^ monitor
		critical: [ dictionary sum: [ :eachItem | eachItem numberOfItemAttributes ] ]
]

{ #category : #'api - cache' }
GtPharoClassExpanderCache >> resetIndexing [
	monitor
		critical: [ dictionary valuesDo: [ :eachValue | eachValue resetIndex ] ]
]
