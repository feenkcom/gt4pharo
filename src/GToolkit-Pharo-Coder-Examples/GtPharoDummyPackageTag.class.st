Class {
	#name : #GtPharoDummyPackageTag,
	#superclass : #GtPharoDummy,
	#instVars : [
		'packageTagName',
		'realPackageTag',
		'dummyClasses'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #'api - classes' }
GtPharoDummyPackageTag >> amountOfClasses [
	^ self dummyClasses size
]

{ #category : #'api - classes' }
GtPharoDummyPackageTag >> anyDummyClass [
	^ self dummyClasses anyOne
]

{ #category : #'api - classes' }
GtPharoDummyPackageTag >> anyDummyKeywordMethod [
	<return: #GtPharoDummyMethod>
	^ self dummyClasses anyOne anyDummyKeywordMethod
]

{ #category : #'api - classes' }
GtPharoDummyPackageTag >> anyDummyUnaryClassMethod [
	<return: #GtPharoDummyMethod>
	^ self dummyClasses anyOne anyDummyUnaryClassMethod
]

{ #category : #'api - classes' }
GtPharoDummyPackageTag >> anyDummyUnaryMethod [
	<return: #GtPharoDummyMethod>
	^ self dummyClasses anyOne anyDummyUnaryMethod
]

{ #category : #accessing }
GtPharoDummyPackageTag >> dummyClasses [
	^ dummyClasses
]

{ #category : #accessing }
GtPharoDummyPackageTag >> dummyClasses: anObject [
	dummyClasses := anObject
]

{ #category : #'gt - extensions' }
GtPharoDummyPackageTag >> gtClassesFor: aView [
	<gtView>

	^ aView list
		title: 'Classes';
		priority: 7;
		items: [ self dummyClasses ];
		itemText: #className
]

{ #category : #'gt - extensions' }
GtPharoDummyPackageTag >> gtCoderFor: aView [
	<gtView>
	| aRealPackageTag |

	(aRealPackageTag := realPackageTag) ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Coder';
		priority: 5;
		stencil: [ GtCoderElement forPackageTag: aRealPackageTag ]
]

{ #category : #'gt - extensions' }
GtPharoDummyPackageTag >> gtPackagesViewChildren [
	^ self dummyClasses
]

{ #category : #'gt - extensions' }
GtPharoDummyPackageTag >> gtPackagesViewItemText [
	^ self packageTagName
]

{ #category : #initialization }
GtPharoDummyPackageTag >> initialize [
	super initialize.
	
	dummyClasses := OrderedCollection new
]

{ #category : #accessing }
GtPharoDummyPackageTag >> packageTagName [
	^ packageTagName
]

{ #category : #accessing }
GtPharoDummyPackageTag >> packageTagName: anObject [
	packageTagName := anObject
]

{ #category : #printing }
GtPharoDummyPackageTag >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self packageTagName.
	aStream nextPut: $)
]

{ #category : #accessing }
GtPharoDummyPackageTag >> realPackageTag [
	^ realPackageTag
]

{ #category : #accessing }
GtPharoDummyPackageTag >> realPackageTag: anObject [
	realPackageTag := anObject
]

{ #category : #removing }
GtPharoDummyPackageTag >> removeFromSystem [
	realPackageTag ifNil: [ ^ self ].

	dummyClasses do: [ :eachClass | eachClass removeFromSystem ].
	GtPharoCodeModifier removePackageTag: realPackageTag.
	realPackageTag := nil
]
