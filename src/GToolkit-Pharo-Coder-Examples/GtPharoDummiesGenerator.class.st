Class {
	#name : #GtPharoDummiesGenerator,
	#superclass : #Object,
	#instVars : [
		'amountOfPackages',
		'amountOfClasses',
		'amountOfMethods',
		'amountOfPackageTags',
		'amountOfClassVariables',
		'amountOfClassSlots',
		'amountOfTraits'
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

{ #category : #generation }
GtPharoDummiesGenerator >> addDummyAccessorsToClass: aDummyClass [
	"Add a getter and a setter of each variable of aDummyClass, a generated class or trait: of its instance variables on the instance side, of its class variables and class slots on the class side. The generated methods do not refer to the variables; the accessors do"

	EpMonitor
		disableDuring: [ GtPharoCodeModifier current
				deferFlushDuring: [ aDummyClass
						addDummyMethods: (aDummyClass instVarNames
								flatCollect: [ :each | self compileDummyAccessorsOf: each in: aDummyClass realClass ]).
					aDummyClass
						addDummyClassMethods: (aDummyClass classVariableNames , aDummyClass classSlotNames
								flatCollect: [ :each | self compileDummyAccessorsOf: each in: aDummyClass realClass classSide ]) ] ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassHierarchyToPackage: aDummyPackage [
	| theDummyClasses currentClass index |
	currentClass := Object.
	index := 0.
	theDummyClasses := (self
			dummyClassNamesForPackageName: aDummyPackage packageName)
			collect: [ :eachClassName | 
				| aDummyClass ivars |
				ivars := (1 to: self fakeInstVarCount)
						collect: [ :i | 'instVar' , (index + i) printString ].
				index := index + self fakeInstVarCount.

				aDummyClass := GtPharoDummyClass new
						instVarNames: ivars;
						className: eachClassName;
						yourself.
				self
					createDummyClass: aDummyClass
					superclass: currentClass
					package: aDummyPackage packageName
					tag: nil
					traits: (self dummyTraitsOf: aDummyPackage forSuperclass: currentClass).

				self addDummyUnaryMethodsToClass: aDummyClass.
				self addDummyUnaryClassMethodsToClass: aDummyClass.
				self addDummyKeywordMethodsToClass: aDummyClass.

				currentClass := aDummyClass realClass.

				aDummyClass ].

	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassSiblingsToPackage: aDummyPackage [
	| theDummyClasses currentClass index |
	currentClass := Object.
	index := 0.
	theDummyClasses := (self
			dummyClassNamesForPackageName: aDummyPackage packageName)
			collect: [ :eachClassName | 
				| aDummyClass ivars |
				ivars := (1 to: self fakeInstVarCount)
						collect: [ :i | 'instVar' , (index + i) printString ].
				index := index + self fakeInstVarCount.

				aDummyClass := GtPharoDummyClass new
						instVarNames: ivars;
						className: eachClassName;
						yourself.
				self
					createDummyClass: aDummyClass
					superclass: currentClass
					package: aDummyPackage packageName
					tag: nil
					traits: (self dummyTraitsOf: aDummyPackage forSuperclass: currentClass).

				self addDummyUnaryMethodsToClass: aDummyClass.
				self addDummyUnaryClassMethodsToClass: aDummyClass.
				self addDummyKeywordMethodsToClass: aDummyClass.

				currentClass = Object ifTrue: [ currentClass := aDummyClass realClass ].

				aDummyClass ].

	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassesToPackage: aDummyPackage [
	| theDummyClasses |
	theDummyClasses := (self
			dummyClassNamesForPackageName: aDummyPackage packageName)
			collect: [ :eachClassName | 
				| aDummyClass |
				aDummyClass := GtPharoDummyClass new
						instVarNames: self fakeInstVarNames;
						className: eachClassName;
						yourself.
				self
					createDummyClass: aDummyClass
					superclass: Object
					package: aDummyPackage packageName
					tag: nil
					traits: (self dummyTraitsOf: aDummyPackage forSuperclass: Object).

				self addDummyUnaryMethodsToClass: aDummyClass.
				self addDummyUnaryClassMethodsToClass: aDummyClass.
				self addDummyKeywordMethodsToClass: aDummyClass.

				aDummyClass ].

	aDummyPackage dummyClasses: theDummyClasses
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyClassesToPackageTag: aDummyPackageTag [
	| theDummyClasses |
	theDummyClasses := (self
			dummyClassNamesForPackageName: aDummyPackageTag packageTagName)
			collect: [ :eachClassName | 
				| aDummyClass |
				aDummyClass := GtPharoDummyClass new
						instVarNames: self fakeInstVarNames;
						className: eachClassName;
						yourself.
				self
					createDummyClass: aDummyClass
					superclass: Object
					package: aDummyPackageTag packageName
					tag: aDummyPackageTag tagName
					traits: #().

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
	EpMonitor
		disableDuring: [ theDummyPackages := self dummyPackageNames
					collect: [ :eachPackageName | 
						| eachPackage eachDummyPackage |
						self
							assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
						eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
						eachDummyPackage := GtPharoDummyPackage new
								packageName: eachPackageName;
								realPackage: eachPackage.
						self amountOfTraits isZero
							ifFalse: [ self addDummyTraitsToPackage: eachDummyPackage ].
						self addDummyClassesToPackage: eachDummyPackage.
						self amountOfPackageTags isZero
							ifFalse: [ self addDummyPackageTagsToPackage: eachDummyPackage ].
						eachDummyPackage ].

			aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackagesWithClassHierarchyToEnvironment: aDummyEnvironment [
	| theDummyPackages |
	EpMonitor
		disableDuring: [ theDummyPackages := self dummyPackageNames
					collect: [ :eachPackageName | 
						| eachPackage eachDummyPackage |
						self
							assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
						eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
						eachDummyPackage := GtPharoDummyPackage new
								packageName: eachPackageName;
								realPackage: eachPackage.
						self amountOfTraits isZero
							ifFalse: [ self addDummyTraitsToPackage: eachDummyPackage ].
						self addDummyClassHierarchyToPackage: eachDummyPackage.
						eachDummyPackage ].

			aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyPackagesWithClassSiblingsToEnvironment: aDummyEnvironment [
	| theDummyPackages |
	EpMonitor
		disableDuring: [ theDummyPackages := self dummyPackageNames
					collect: [ :eachPackageName | 
						| eachPackage eachDummyPackage |
						self
							assert: (self packageOrganizer includesPackageNamed: eachPackageName) not.
						eachPackage := GtPharoCodeModifier createPackageNamed: eachPackageName.
						eachDummyPackage := GtPharoDummyPackage new
								packageName: eachPackageName;
								realPackage: eachPackage.
						self amountOfTraits isZero
							ifFalse: [ self addDummyTraitsToPackage: eachDummyPackage ].
						self addDummyClassSiblingsToPackage: eachDummyPackage.
						eachDummyPackage ].

			aDummyEnvironment dummyPackages: theDummyPackages ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> addDummyTraitsToPackage: aDummyPackage [
	"Add amountOfTraits traits, each with one slot, before the classes of the package that use them"

	| theDummyTraits |
	theDummyTraits := (1 to: self amountOfTraits)
			collect: [ :index | 
				| aTraitName aSlotName |
				aTraitName := ('T'
						, aDummyPackage packageName asCamelCase asValidSelector capitalized
						, 'Trait' , index printString) asSymbol.
				aSlotName := ('traitSlot' , index printString) asSymbol.
				GtPharoDummyClass new
					className: aTraitName;
					instVarNames: {aSlotName};
					realClass: (GtPharoCodeModifier current
							createTraitNamed: aTraitName
							slots: {aSlotName}
							package: aDummyPackage packageName
							tag: nil);
					yourself ].
	aDummyPackage dummyTraits: theDummyTraits
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
GtPharoDummiesGenerator >> amountOfClassSlots [
	"The number of class-side instance variables of each generated class, 0 by default"

	^ amountOfClassSlots
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfClassSlots: aNumber [
	amountOfClassSlots := aNumber
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfClassVariables [
	"The number of class variables of each generated class, 0 by default"

	^ amountOfClassVariables
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfClassVariables: aNumber [
	amountOfClassVariables := aNumber
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

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfTraits [
	"The number of traits of each generated package, 0 by default. Each trait has one slot, and the classes of the package whose superclass is Object use all of them"

	^ amountOfTraits
]

{ #category : #accessing }
GtPharoDummiesGenerator >> amountOfTraits: aNumber [
	amountOfTraits := aNumber
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> compileDummyAccessorsOf: aVariableName in: aBehavior [
	| aGetter aSetter |
	aGetter := aVariableName asString uncapitalized.
	aSetter := aGetter , ':'.
	^ {aGetter -> (aGetter , String cr , String tab , '^ ' , aVariableName).
		aSetter
			-> (aSetter , ' anObject' , String cr , String tab , aVariableName , ' := anObject')}
		collect: [ :each | 
			GtPharoCodeModifier current
				compileMethodSource: each value
				in: aBehavior
				protocol: 'accessing'.
			GtPharoDummyMethod new
				realMethod: aBehavior >> each key asSymbol;
				selector: each key asSymbol;
				protocol: 'accessing';
				yourself ]
]

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> createDummyClass: aDummyClass superclass: aClass package: aPackageName tag: aTagName traits: someTraits [
	"Create the real class of aDummyClass, with its class variables and class slots. Without class variables, class slots and traits, the class is created as before these options existed"

	| classVariables classSlots aNewClass |
	classVariables := (1 to: amountOfClassVariables)
			collect: [ :index | (aDummyClass className , 'ClassVar' , index printString) asSymbol ].
	classSlots := (1 to: amountOfClassSlots)
			collect: [ :index | (aDummyClass className uncapitalized , 'ClassSlot' , index printString) asSymbol ].
	aNewClass := (classVariables isEmpty
			and: [ classSlots isEmpty and: [ someTraits isEmpty ] ])
			ifTrue: [ aTagName
					ifNil: [ GtPharoCodeModifier current
							createSubclassOf: aClass
							named: aDummyClass className
							slots: aDummyClass instVarNames
							package: aPackageName ]
					ifNotNil: [ GtPharoCodeModifier current
							createSubclassOf: aClass
							named: aDummyClass className
							slots: aDummyClass instVarNames
							package: aPackageName
							tag: aTagName ] ]
			ifFalse: [ GtPharoCodeModifier current
					createSubclassOf: aClass
					named: aDummyClass className
					slots: aDummyClass instVarNames
					sharedVariables: classVariables
					classSlots: classSlots
					traits: someTraits
					package: aPackageName
					tag: aTagName ].
	aDummyClass
		realClass: aNewClass;
		classVariableNames: classVariables;
		classSlotNames: classSlots.
	^ aNewClass
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

{ #category : #'private - generation' }
GtPharoDummiesGenerator >> dummyTraitsOf: aDummyPackage forSuperclass: aClass [
	"The classes whose superclass is Object use the traits of their package; their subclasses inherit them"

	aClass = Object ifFalse: [ ^ #() ].
	^ (aDummyPackage ifNil: [ #() ] ifNotNil: [ :aPackage | aPackage dummyTraits ])
		collect: [ :each | each realClass ]
		as: Array
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
	amountOfClassVariables := 0.
	amountOfClassSlots := 0.
	amountOfTraits := 0
]

{ #category : #'private - set up' }
GtPharoDummiesGenerator >> renamedFakePackageName [
	^ (self fakePackageName, 'Renamed') asSymbol
]
