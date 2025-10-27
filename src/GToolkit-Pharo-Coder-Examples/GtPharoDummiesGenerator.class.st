Class {
	#name : #GtPharoDummiesGenerator,
	#superclass : #Object,
	#instVars : [
		'amountOfPackages',
		'amountOfClasses',
		'amountOfMethods',
		'amountOfPackageTags'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #'api - generation' }
GtPharoDummiesGenerator class >> withPackages: anAmountOfPackages classHierarchy: anAmountOfClasses [
	^ self new
		amountOfPackages: anAmountOfPackages;
		amountOfClasses: anAmountOfClasses;
		generateHierarchy
]

{ #category : #'api - generation' }
GtPharoDummiesGenerator class >> withPackages: anAmountOfPackages classes: anAmountOfClasses [
	^ self new
		amountOfPackages: anAmountOfPackages;
		amountOfClasses: anAmountOfClasses;
		generate
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassHierarchyToPackage: aDummyPackage [
	| theDummyClasses currentClass index |
	currentClass := Object.
	index := 0.
	theDummyClasses := (self dummyClassNamesForPackageName: aDummyPackage packageName) collect: [ :eachClassName |
		| aNewClass aDummyClass ivars |

		ivars := (1 to: self fakeInstVarCount) collect: [ :i | 'instVar' , (index + i) printString ].
		index := index + self fakeInstVarCount.

		aNewClass := GtPharoCodeModifier current
			createSubclassOf: currentClass
			named: eachClassName
			slots: ivars
			package: aDummyPackage packageName.

		aDummyClass := GtPharoDummyClass new
			instVarNames: ivars;
			realClass: aNewClass;
			className: eachClassName.
		
		self addDummyUnaryMethodsToClass: aDummyClass.
		self addDummyUnaryClassMethodsToClass: aDummyClass.
		self addDummyKeywordMethodsToClass: aDummyClass.
		
		currentClass := aNewClass.
		
		aDummyClass ].
	
	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassSiblingsToPackage: aDummyPackage [
	| theDummyClasses currentClass index |
	currentClass := Object.
	index := 0.
	theDummyClasses := (self dummyClassNamesForPackageName: aDummyPackage packageName) collect: [ :eachClassName |
		| aNewClass aDummyClass ivars |

		ivars := (1 to: self fakeInstVarCount) collect: [ :i | 'instVar' , (index + i) printString ].
		index := index + self fakeInstVarCount.

		aNewClass := GtPharoCodeModifier current
			createSubclassOf: currentClass
			named: eachClassName
			slots: ivars
			package: aDummyPackage packageName.

		aDummyClass := GtPharoDummyClass new
			instVarNames: ivars;
			realClass: aNewClass;
			className: eachClassName.
		
		self addDummyUnaryMethodsToClass: aDummyClass.
		self addDummyUnaryClassMethodsToClass: aDummyClass.
		self addDummyKeywordMethodsToClass: aDummyClass.
		
		currentClass = Object ifTrue: [ currentClass := aNewClass ].
		
		aDummyClass ].
	
	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassesToPackage: aDummyPackage [
	| theDummyClasses |
	theDummyClasses := (self dummyClassNamesForPackageName: aDummyPackage packageName) collect: [ :eachClassName |
		| aNewClass aDummyClass |

		aNewClass := GtPharoCodeModifier current
			createSubclassOf: Object
			named: eachClassName
			slots: self fakeInstVarNames
			package: aDummyPackage packageName.

		aDummyClass := GtPharoDummyClass new
			instVarNames: self fakeInstVarNames;
			realClass: aNewClass;
			className: eachClassName.
		
		self addDummyUnaryMethodsToClass: aDummyClass.
		self addDummyUnaryClassMethodsToClass: aDummyClass.
		self addDummyKeywordMethodsToClass: aDummyClass.

		aDummyClass ].
	
	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassesToPackageTag: aDummyPackageTag [
	| theDummyClasses |
	theDummyClasses := (self dummyClassNamesForPackageName: aDummyPackageTag packageTagName) collect: [ :eachClassName |
		| aNewClass aDummyClass |

		aNewClass := GtPharoCodeModifier current
			createSubclassOf: Object
			named: eachClassName
			slots: self fakeInstVarNames
			package: aDummyPackageTag packageName
			tag: aDummyPackageTag tagName.

		aDummyClass := GtPharoDummyClass new
			instVarNames: self fakeInstVarNames;
			realClass: aNewClass;
			className: eachClassName.
		
		self addDummyUnaryMethodsToClass: aDummyClass.
		self addDummyUnaryClassMethodsToClass: aDummyClass.
		self addDummyKeywordMethodsToClass: aDummyClass.

		aDummyClass ].
	
	aDummyPackageTag dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyKeywordMethodsToClass: aDummyClass [
	| theDummyMethods |
	
	theDummyMethods := self fakeKeywordMethodNames collect: [ :eachMethodName |
		| eachProtocol aDummyMethod |
		
		eachProtocol := self fakeCategoryForFakeMethodName: eachMethodName.
		
		GtPharoCodeModifier current
			compileMethodSource: (eachMethodName asString, ' anObject')
			in: aDummyClass realClass
			protocol: eachProtocol.
		
		aDummyMethod := GtPharoDummyMethod new
			realMethod: aDummyClass realClass >> eachMethodName;
			selector: eachMethodName;
			protocol: eachProtocol.

		aDummyMethod ].

	aDummyClass addDummyMethods: theDummyMethods
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackageTagsToPackage: aDummyPackage [
	| dummyTags |
	dummyTags := self dummyPackageTagNames collect: [ :aTagName |
		| newTag dummyPackageTag |

		newTag := GtPharoCodeModifier current
			createPackageTagOf: aDummyPackage realPackage
			named: aTagName.

		dummyPackageTag := GtPharoDummyPackageTag new
			realPackageTag: newTag;
			packageName: aDummyPackage packageName;
			tagName: aTagName;
			packageTagName: (aDummyPackage packageName, '-', aTagName).
		
		self addDummyClassesToPackageTag: dummyPackageTag.

		dummyPackageTag ].
	
	aDummyPackage dummyPackageTags: dummyTags
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackagesToEnvironment: aDummyEnvironment [
	| theDummyPackages |

	EpMonitor disableDuring: [
	theDummyPackages := self dummyPackageNames collect: [ :eachPackageName |
		| eachPackage eachDummyPackage |
		self assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
		eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
		eachDummyPackage := GtPharoDummyPackage new
			packageName: eachPackageName;
			realPackage: eachPackage.
		self addDummyClassesToPackage: eachDummyPackage.
		self amountOfPackageTags isZero ifFalse: [ 
			self addDummyPackageTagsToPackage: eachDummyPackage ].
		eachDummyPackage ].
	
	aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackagesWithClassHierarchyToEnvironment: aDummyEnvironment [
	| theDummyPackages |

	EpMonitor disableDuring: [
	theDummyPackages := self dummyPackageNames collect: [ :eachPackageName |
		| eachPackage eachDummyPackage |
		self assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
		eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
		eachDummyPackage := GtPharoDummyPackage new
			packageName: eachPackageName;
			realPackage: eachPackage.
		self addDummyClassHierarchyToPackage: eachDummyPackage.
		eachDummyPackage ].
	
	aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackagesWithClassSiblingsToEnvironment: aDummyEnvironment [
	| theDummyPackages |

	EpMonitor disableDuring: [
	theDummyPackages := self dummyPackageNames collect: [ :eachPackageName |
		| eachPackage eachDummyPackage |
		self assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
		eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
		eachDummyPackage := GtPharoDummyPackage new
			packageName: eachPackageName;
			realPackage: eachPackage.
		self addDummyClassSiblingsToPackage: eachDummyPackage.
		eachDummyPackage ].
	
	aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyUnaryClassMethodsToClass: aDummyClass [
	| theDummyMethods |
	theDummyMethods := self dummyUnaryClassMethodNames collect: [ :eachMethodName |
		| eachProtocol aDummyMethod |
		
		eachProtocol := self fakeCategoryForFakeMethodName: eachMethodName.
		
		GtPharoCodeModifier current
			compileMethodSource: eachMethodName
			in: aDummyClass realClass class
			protocol: eachProtocol.
		
		aDummyMethod := GtPharoDummyMethod new
			realMethod: aDummyClass realClass class >> eachMethodName;
			selector: eachMethodName;
			protocol: eachProtocol.
			
		aDummyMethod ].
	
	aDummyClass addDummyClassMethods: theDummyMethods
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyUnaryMethodsToClass: aDummyClass [
	| theDummyMethods |
	theDummyMethods := self dummyUnaryMethodNames collect: [ :eachMethodName |
		| eachProtocol aDummyMethod |
		
		eachProtocol := self fakeCategoryForFakeMethodName: eachMethodName.
		
		GtPharoCodeModifier current
			compileMethodSource: eachMethodName
			in: aDummyClass realClass
			protocol: eachProtocol.
			
		aDummyMethod := GtPharoDummyMethod new
			realMethod: aDummyClass realClass >> eachMethodName;
			selector: eachMethodName;
			protocol: eachProtocol.
			
		aDummyMethod ].
	
	aDummyClass addDummyMethods: theDummyMethods
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfClasses [
	^ amountOfClasses
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfClasses: anObject [
	amountOfClasses := anObject
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfMethods [
	^ amountOfMethods
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfMethods: anObject [
	amountOfMethods := anObject
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfPackageTags [
	^ amountOfPackageTags
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfPackageTags: anObject [
	amountOfPackageTags := anObject
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfPackages [
	^ amountOfPackages
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfPackages: anObject [
	amountOfPackages := anObject
]

{ #category : #'private - names' }
GtPharoDummiesGenerator >> dummyClassNamesForPackageName: aPackageName [	
	^ (1 to: amountOfClasses) collect: [ :index | (aPackageName asCamelCase asValidSelector capitalized, 'Class', index asString) asSymbol ]
]

{ #category : #'private - names' }
GtPharoDummiesGenerator >> dummyPackageNamePrefix [
	^ 'TemporaryPackage'
]

{ #category : #'private - names' }
GtPharoDummiesGenerator >> dummyPackageNames [
	<script: #'self new dummyPackageNames inspect'>
	| thePackageNames |
	
	thePackageNames := OrderedCollection new.
	[ thePackageNames size < amountOfPackages ] whileTrue: [
		| aGeneratedPackageName |
		
		aGeneratedPackageName := (self dummyPackageNamePrefix, '-', (UUID new asString36 last: 8) capitalized) asSymbol.

		(self packageOrganizer includesPackageNamed: aGeneratedPackageName)
			ifFalse: [ thePackageNames add: aGeneratedPackageName ] ].

	^ thePackageNames
]

{ #category : #'private - names' }
GtPharoDummiesGenerator >> dummyPackageTagNames [
	amountOfPackageTags isZero ifTrue: [ ^ #() ].
	^ (1 to: amountOfPackageTags) collect: [ :index | ('Tag', index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> dummyUnaryClassMethodNames [
	<script: 'self new dummyUnaryClassMethodNames inspect'>
	
	^ (1 to: self fakeMethodCount) collect: [ :index | (#classMethod, index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> dummyUnaryMethodNames [
	<script: 'self new dummyUnaryMethodNames inspect'>
	
	^ (1 to: self fakeMethodCount) collect: [ :index | (#method, index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeCategoryForFakeMethod: aCompiledMethod [
	^ 'api - ', aCompiledMethod selector
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeCategoryForFakeMethodName: aMethodName [
	^ 'api - ', aMethodName
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeClassCount [
	^ 2
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeClassNamed: aFakeClassName [
	^ self class environment at: aFakeClassName
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeClassNamesForPackage: aPackage [
	^ self fakeClassNamesForPackageName: aPackage name
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeClassNamesForPackageName: aPackageName [	
	^ (1 to: self fakeClassCount) collect: [ :index | (aPackageName asCamelCase asValidSelector capitalized, 'Class', index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeClassesInFakePackage: aPackage [
	^ (self fakeClassNamesForPackage: aPackage) collect: [ :eachClassName | self fakeClassNamed: eachClassName ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeInstVarCount [
	^ 2
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeInstVarNames [
	<script: 'self new fakeInstVarNames inspect'>
	
	^ (1 to: self fakeInstVarCount) collect: [ :index | ('instVar', index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeKeywordMethodNames [
	<script: 'self new fakeKeywordMethodNames inspect'>
	
	^ (1 to: self fakeMethodCount) collect: [ :index | (#method, index asString, ':') asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeKeywordMethodsInFakeClass: aFakeClass [
	^ self fakeKeywordMethodNames collect: [ :each | aFakeClass >> each ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeMethodCount [
	^ self amountOfMethods
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeMethodNames [
	<script: 'self new fakeMethodNames inspect'>
	
	^ self fakeUnaryMethodNames, self fakeKeywordMethodNames
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeMethodsInFakeClass: aFakeClass [
	^ self fakeMethodNames collect: [ :each | aFakeClass >> each ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeMethodsInFakeClass: aFakeClass inFakePackage: aPackage [
	^ self fakeMethodNames collect: [ :each | aFakeClass >> each ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeMethodsInFakeClassNamed: aFakeClassName inFakePackage: aPackage [
	| aClass |

	aClass := self fakeClassNamed: aFakeClassName.
	^ self fakeMethodNames collect: [ :each | aClass >> each ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeRegisteredPackage [
	| aFakePackageName aPackage |
	
	EpMonitor disableDuring: [
		self cleanUp.
		
		amountOfPackages timesCollect: [  ].

		aFakePackageName := self fakePackageName.
		self assert: (self packageOrganizer includesPackageNamed: aFakePackageName) not.
		
		aPackage := self packageOrganizer createPackageNamed: aFakePackageName.
		self addFakeClassesToPackage: aPackage ].
	
	^ aPackage
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeUnaryMethodNames [
	<script: 'self new fakeUnaryMethodNames inspect'>
	^ (1 to: self fakeMethodCount)
		collect: [ :index | (#method , index asString) asSymbol ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeUnaryMethodsInFakeClass: aFakeClass [
	^ self fakeUnaryMethodNames collect: [ :each | aFakeClass >> each ]
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> fakeUnregisteredPackage [
	| aFakePackageName aPackage |

	self cleanUp.
	
	aFakePackageName := self fakePackageName.
	
	self assert: (self packageOrganizer includesPackageNamed: aFakePackageName) not.
	
	aPackage := self packageOrganizer packageClass named: aFakePackageName.
	
	^ aPackage
]

{ #category : #'api - generation' }
GtPharoDummiesGenerator >> generate [
	<script: #'self new generate inspect'>
	| aDummyEnvironment |
	
	aDummyEnvironment := GtPharoDummyEnvironment new.

	EpMonitor disableDuring: [
		GtPharoCodeModifier current deferFlushDuring: [
			self addDummyPackagesToEnvironment: aDummyEnvironment ] ]. 

	^ aDummyEnvironment
]

{ #category : #'api - generation' }
GtPharoDummiesGenerator >> generateHierarchy [
	| aDummyEnvironment |
	
	aDummyEnvironment := GtPharoDummyEnvironment new.

	EpMonitor disableDuring: [
		GtPharoCodeModifier current deferFlushDuring: [
			self addDummyPackagesWithClassHierarchyToEnvironment: aDummyEnvironment ] ]. 

	^ aDummyEnvironment
]

{ #category : #'api - generation' }
GtPharoDummiesGenerator >> generateSiblings [
	| aDummyEnvironment |
	
	aDummyEnvironment := GtPharoDummyEnvironment new.

	EpMonitor disableDuring: [
		GtPharoCodeModifier current deferFlushDuring: [
			self addDummyPackagesWithClassSiblingsToEnvironment: aDummyEnvironment ] ]. 

	^ aDummyEnvironment
]

{ #category : #initialization }
GtPharoDummiesGenerator >> initialize [
	super initialize.
	
	amountOfPackages := 2.
	amountOfPackageTags := 0.
	amountOfClasses := 2.
	amountOfMethods := 2.
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> renamedFakePackageName [
	^ (self fakePackageName, 'Renamed') asSymbol
]
