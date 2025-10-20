Class {
	#name : #GtPharoDummyEnvironment,
	#superclass : #GtPharoDummy,
	#instVars : [
		'dummyPackages'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #'as yet unclassified' }
GtPharoDummyEnvironment class >> cleanUp: aggressive [
	"For better exploration, some examples do not clean up dummy environments.
	For that reason all dummy environments are cleaned up during this process."

	aggressive ifFalse: [ ^ self ].

	self allInstancesDo: [ :eachEnvironment | 
		[ eachEnvironment removeFromSystem ] 
			onErrorDo: [ :anError | anError return ] ]
]

{ #category : #'api - generation' }
GtPharoDummyEnvironment class >> withPackages: anAmountOfPackages classes: anAmountOfClasses [
	^ GtPharoDummiesGenerator withPackages: anAmountOfPackages classes: anAmountOfClasses
]

{ #category : #'api - modifications' }
GtPharoDummyEnvironment >> addRealPackage: aPackage [
	| aDummyPackage |
	aDummyPackage := GtPharoDummyPackage new
			packageName: aPackage name;
			realPackage: aPackage.
	self dummyPackages: {aDummyPackage}.
	^ aDummyPackage
]

{ #category : #'api - classes' }
GtPharoDummyEnvironment >> anyDummyClass [
	^ self anyDummyPackage anyDummyClass
]

{ #category : #'api - methods' }
GtPharoDummyEnvironment >> anyDummyKeywordMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyPackages anyOne anyDummyKeywordMethod
]

{ #category : #'api - classes' }
GtPharoDummyEnvironment >> anyDummyLeafClass [
	^ self anyDummyPackage dummyClasses detect: [ :each | each realClass subclasses isEmpty ]
]

{ #category : #'api - packages' }
GtPharoDummyEnvironment >> anyDummyPackage [
	^ self dummyPackages anyOne
]

{ #category : #'api - classes' }
GtPharoDummyEnvironment >> anyDummyPackageTag [
	^ self anyDummyPackage dummyPackageTags anyOne
]

{ #category : #'api - classes' }
GtPharoDummyEnvironment >> anyDummyRootClass [
	^ self anyDummyPackage dummyClasses detect: [ :each | each realClass superclass = Object ]
]

{ #category : #'api - methods' }
GtPharoDummyEnvironment >> anyDummyUnaryClassMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyPackages anyOne anyDummyUnaryClassMethod
]

{ #category : #'api - methods' }
GtPharoDummyEnvironment >> anyDummyUnaryMethod [
	<return: #GtPharoDummyMethod>

	^ self dummyPackages anyOne anyDummyUnaryMethod
]

{ #category : #'api - methods' }
GtPharoDummyEnvironment >> anyUnaryMethod [
	<return: #CompiledMethod>

	^ self anyDummyUnaryMethod realMethod
]

{ #category : #accessing }
GtPharoDummyEnvironment >> dummyPackages [
	^ dummyPackages
]

{ #category : #accessing }
GtPharoDummyEnvironment >> dummyPackages: anObject [
	dummyPackages addAll: anObject
]

{ #category : #'api - modifications' }
GtPharoDummyEnvironment >> ensureRealClass: aClass [
	| aPackage aDummyPackage |
	aPackage := aClass package.
	aDummyPackage := self ensureRealPackage: aPackage.
			
	^ aDummyPackage ensureRealClass: aClass
]

{ #category : #'api - modifications' }
GtPharoDummyEnvironment >> ensureRealPackage: aPackage [
	^ self dummyPackages
		detect: [ :eachDPackage | eachDPackage realPackage name = aPackage name ]
		ifFound: [ :aDPackage | aDPackage ]
		ifNone: [ self addRealPackage: aPackage ]
]

{ #category : #initialization }
GtPharoDummyEnvironment >> finalize [
	self removeFromSystem
]

{ #category : #accessing }
GtPharoDummyEnvironment >> gtClassesFor: aView [
	<gtView>
	^ aView list
		title: 'Classes';
		priority: 20;
		items: [ self dummyPackages
				flatCollect: [ :each | each dummyClasses , (each dummyPackageTags flatCollect: #dummyClasses) ] ];
		itemText: #className
]

{ #category : #accessing }
GtPharoDummyEnvironment >> gtMethodsFor: aView [
	<gtView>
	^ aView list
		title: 'Methods';
		priority: 30;
		items: [ (self dummyPackages flatCollect: #dummyClasses) flatCollect: #dummyMethods ];
		itemText: [ :aDummyMethod | aDummyMethod className , ' >> #' , aDummyMethod selector ]
]

{ #category : #accessing }
GtPharoDummyEnvironment >> gtPackageTagsFor: aView [
	<gtView>
	^ aView list
		title: 'Package tags';
		priority: 15;
		items: [ self dummyPackages flatCollect: #dummyPackageTags ];
		itemText: #packageTagName
]

{ #category : #accessing }
GtPharoDummyEnvironment >> gtPackagesFor: aView [
	<gtView>

	^ aView tree
		title: 'Packages';
		priority: 10;
		actionCollapseAndExpandButtons;
		items: [ self dummyPackages ];
		children: #gtPackagesViewChildren;
		itemText: #gtPackagesViewItemText
]

{ #category : #initialization }
GtPharoDummyEnvironment >> initialize [
	super initialize.
	
	dummyPackages := OrderedCollection new.
	
	"the copy of myself will be used as a finalization executor"
	self class finalizationRegistry add: self
]

{ #category : #'api - packages' }
GtPharoDummyEnvironment >> realPackages [
	^ self dummyPackages collect: [ :eachDummyPackage | eachDummyPackage realPackage ]
]

{ #category : #initialization }
GtPharoDummyEnvironment >> removeFromSystem [
	EpMonitor disableDuring: [
		GtPharoCodeModifier current deferFlushDuring: [
			self dummyPackages do: [ :each | each removeFromSystem ] ] ]
]
