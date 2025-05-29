Class {
	#name : #GtPharoDummyPackage,
	#superclass : #GtPharoDummy,
	#instVars : [
		'packageName',
		'realPackage',
		'dummyClasses',
		'dummyPackageTags'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #'api - classes' }
GtPharoDummyPackage >> amountOfClasses [
	^ self dummyClasses size
]

{ #category : #'api - classes' }
GtPharoDummyPackage >> anyDummyClass [
	^ self dummyClasses anyOne
]

{ #category : #'api - methods' }
GtPharoDummyPackage >> anyDummyKeywordMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyClasses anyOne anyDummyKeywordMethod
]

{ #category : #'api - classes' }
GtPharoDummyPackage >> anyDummyPackageTag [
	^ self dummyPackageTags anyOne
]

{ #category : #'api - methods' }
GtPharoDummyPackage >> anyDummyUnaryClassMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyClasses anyOne anyDummyUnaryClassMethod
]

{ #category : #'api - methods' }
GtPharoDummyPackage >> anyDummyUnaryMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyClasses anyOne anyDummyUnaryMethod
]

{ #category : #accessing }
GtPharoDummyPackage >> dummyClasses [
	^ dummyClasses
]

{ #category : #accessing }
GtPharoDummyPackage >> dummyClasses: aCollectionOfDummyClasses [
	dummyClasses addAll: aCollectionOfDummyClasses.
	aCollectionOfDummyClasses do: [ :eachDummyClass | eachDummyClass dummyPackage: self ]
]

{ #category : #accessing }
GtPharoDummyPackage >> dummyPackageTags [
	<return: #OrderedCollection of: #GtPharoDummyPackageTag>
	^ dummyPackageTags
]

{ #category : #accessing }
GtPharoDummyPackage >> dummyPackageTags: anObject [
	dummyPackageTags := anObject
]

{ #category : #'gt-extensions' }
GtPharoDummyPackage >> gtClassesFor: aView [
	<gtView>

	^ aView list
		title: 'Classes';
		priority: 7;
		items: [ self dummyClasses ];
		itemText: #className
]

{ #category : #'gt-extensions' }
GtPharoDummyPackage >> gtCoderFor: aView [
	<gtView>
	| aRealPackage |

	(aRealPackage := realPackage) ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Coder';
		priority: 5;
		stencil: [ GtCoderElement forPackage: aRealPackage ]
]

{ #category : #'gt-extensions' }
GtPharoDummyPackage >> gtPackagesViewChildren [
	^ self dummyClasses , self dummyPackageTags
]

{ #category : #'gt-extensions' }
GtPharoDummyPackage >> gtPackagesViewItemText [
	^ self packageName
]

{ #category : #initialization }
GtPharoDummyPackage >> initialize [
	super initialize.
	
	dummyClasses := OrderedCollection new.
	dummyPackageTags := OrderedCollection new.
]

{ #category : #accessing }
GtPharoDummyPackage >> packageName [
	^ packageName
]

{ #category : #accessing }
GtPharoDummyPackage >> packageName: anObject [
	packageName := anObject
]

{ #category : #printing }
GtPharoDummyPackage >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self packageName.
	aStream nextPut: $)
]

{ #category : #accessing }
GtPharoDummyPackage >> realPackage [
	^ realPackage
]

{ #category : #accessing }
GtPharoDummyPackage >> realPackage: anObject [
	realPackage := anObject
]

{ #category : #removing }
GtPharoDummyPackage >> removeFromSystem [
	realPackage
		ifNil: [ ^ self ].
		
	dummyClasses do: [ :eachClass | eachClass removeFromSystem ].
	dummyPackageTags do: [ :eachPackageTag | eachPackageTag removeFromSystem ].
	GtPharoCodeModifier removePackage: realPackage.
	realPackage := nil
]
