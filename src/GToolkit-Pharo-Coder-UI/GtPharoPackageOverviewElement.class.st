Class {
	#name : #GtPharoPackageOverviewElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'package',
		'extendedMethodsElement',
		'behaviorTypesList',
		'headerElement',
		'dependenciesShortElement',
		'whichBaselineElement',
		'aContainer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> announcementClassesStream [
	^ self classesStream select: [ :eachClass |
		(eachClass includesBehavior: Announcement)
			and: [ (eachClass includesBehavior: BlEvent) not
				and: [ (eachClass includesBehavior: BeaconSignal) not ] ] ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> beaconSignalClassesStream [
	^ self classesStream select: [ :eachClass | eachClass includesBehavior: BeaconSignal ]
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> behaviorGroupForStream: aStream named: aName ofType: aTypePluralName [
	^ BrGroup new
		domainObject: aName;
		stream: (self streamToCountStream: aStream);
		itemStencil: [
			BrButton new
				hMatchParent;
				aptitude: BrGlamorousLinkButtonWithLabelAptitude;
				action: [ :aButton | aButton phlow spawnObject: aButton model ] ];
		itemDataBinder: [ :aButton :eachItem |
			aButton
				model: aStream;
				label: eachItem asString, ' ', aTypePluralName ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> behaviorTypeGroupesStream [
	| theGroups |
	theGroups := OrderedCollection new.
	
	theGroups add: (self
		classGroupForStream: self classesStream
		named: 'Total classes').
		
	theGroups add: (self
		traitGroupForStream: self traitsStream
		named: 'Total traits').
	
	theGroups add: (self
		classGroupForStream: self userInterfaceClassesStream
		named: 'UI Elements').
		
	theGroups add: (self
		classGroupForStream: self userInterfaceEventClassesStream
		named: 'UI Events').
		
	theGroups add: (self
		classGroupForStream: self ffiClassesStream
		named: 'FFI classes').

	theGroups add: (self
		classGroupForStream: self announcementClassesStream
		named: 'Announcements').
		
	theGroups add: (self
		classGroupForStream: self beaconSignalClassesStream
		named: 'Beacon signals').

	theGroups add: (self
		classGroupForStream: self exampleClassesStream
		named: 'Examples').

	^ theGroups
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> buildPackageTagsIn: aContainer [
	aContainer addChild: (self
		createPackageTagNamed: 'UI'
		stream: self userInterfaceClassesStream).
		
	aContainer addChild: (self
		createPackageTagNamed: 'FFI'
		stream: self ffiClassesStream).
	
	aContainer addChild: (self
		createPackageTagNamed: 'Examples'
		stream: self exampleClassesStream).

	aContainer addChild: (self
		createPackageTagNamed: 'Extensions'
		stream: self extensionMethodsStream).

	aContainer addChild: (self
		createPackageTagNamed: 'Beacon'
		stream: self beaconSignalClassesStream).

	aContainer addChild: (self
		createPackageTagNamed: 'Metadata'
		stream: self metadataStream)
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> classGroupForStream: aStream named: aName [
	^ self
		behaviorGroupForStream: aStream
		named: aName
		ofType: 'classes'
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> classesAndTraitsStream [
	^ AsyncPackageBehaviorsStream forPackage: package
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> classesStream [
	^ self classesAndTraitsStream
		select: [ :eachBehavior | eachBehavior isClass ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createClassTypesList [
	^ BrGroupedList new
		hMatchParent;
		vFitContentLimited;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		background: Color white;
		padding: (BlInsets top: 0 bottom: 10 left: 10 right: 10);
		headerElementStencil: [ BrLabel new
			margin: (BlInsets top: 10);
			aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		headerDataBinder: [ :aLabel :eachItem | aLabel text: eachItem domainObject ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createExtensionMethodsStatistic [
	| aContainer anExtendedClassesElement anExtendedPackagesElement anExtendedMethodsElement |

	anExtendedClassesElement := BrButton new
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: (AsyncFoldSink
					inject: (AsyncMutex for: Set new)
					into: [ :aSetMutex :aMethod | aSetMutex lock: [ :aSet | aSet add: aMethod methodClass ]; yourself ]);
				whenUpdate: [ :aButton :aSink | aButton label: (aSink value lock: [ :aSet | aSet size ]) ] ];
		action: [ :aButton | aButton phlow spawnObject: (aButton asyncSink sink value lock: [ :aSet |
			aSet copy asArray sorted: [ :a :b | a name < b name ] ]) ];
		label: '0'.

	anExtendedPackagesElement := BrButton new
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: (AsyncFoldSink
					inject: (AsyncMutex for: Set new)
					into: [ :aSetMutex :aMethod | aSetMutex lock: [ :aSet | aSet add: aMethod methodClass package ]; yourself ]);
				whenUpdate: [ :aButton :aSink | aButton label: (aSink value lock: [ :aSet | aSet size ]) ] ];
		action: [ :aButton | aButton phlow spawnObject: (aButton asyncSink sink value lock: [ :aSet |
			aSet copy asArray sorted: [ :a :b | a name < b name ] ]) ];
		label: '0'.
		
	anExtendedMethodsElement := BrButton new
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: (AsyncFoldSink
					inject: (AsyncMutex for: Set new)
					into: [ :aSetMutex :aMethod | aSetMutex lock: [ :aSet | aSet add: aMethod ]; yourself ]);
				whenUpdate: [ :aButton :aSink | aButton label: (aSink value lock: [ :aSet | aSet size ]) ] ];
		action: [ :aButton | aButton phlow spawnObject: (aButton asyncSink sink value lock: [ :aSet |
			| anArrayOfMethods |
			anArrayOfMethods := aSet copy asArray sorted: GtMethodsSortFunction new.
			GtSearchFixedMethodsFilter new methods: anArrayOfMethods ]) ];
		label: '0'.

	aContainer := BrHorizontalFlow new.
	aContainer
		hMatchParent;
		vFitContent.

	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Extends ').
	aContainer addChild: anExtendedClassesElement.
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: ' classes in ').
	aContainer addChild: anExtendedPackagesElement.
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: ' packages with ').
	aContainer addChild: anExtendedMethodsElement.
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: ' methods.').

	aContainer withAsyncSinkDo: [ :anElementSink |
		anElementSink
			sink: (AsyncSpreadSink forSinks: {
				anExtendedClassesElement asyncSink.
				anExtendedPackagesElement asyncSink.
				anExtendedMethodsElement asyncSink }) ].

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageDependenciesStatistic [
	| aContainer theDependencyPackages |

	theDependencyPackages := BrButton new
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: (AsyncCollectionSink forCollection: AsyncSharedOrderedCollection new);
				whenUpdate: [ :aButton :aSink | aButton label: (aSink collection size) ] ];
		action: [ :aButton |
			| theDependencies |
			
			theDependencies := aButton asyncSink sink collection asArray
				sorted: [ :a :b | a dependencyPackageName < b dependencyPackageName ].
			aButton phlow spawnObject: (GtPackageDependencyStatuses new
				package: package;
				dependencies: theDependencies) ];
		label: '0'.

	aContainer := BrHorizontalFlow new.
	aContainer
		hMatchParent;
		vFitContent.

	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Depends on ').
	aContainer addChild: theDependencyPackages.
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: ' packages').

	aContainer withAsyncSinkDo: [ :anElementSink |
		anElementSink
			sink: (AsyncSpreadSink forSinks: { theDependencyPackages asyncSink }) ].

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageHeader [
	| aContainer |
	
	aContainer := BrVerticalPane new.
	aContainer hMatchParent; vFitContent.
	aContainer addChild: (BrLabel new
		id: #'package--header-label';
		beHugeSize;
		aptitude: BrGlamorousLabelAptitude new bold).
		
	aContainer addChild: (BrHorizontalFlow new
		margin: (BlInsets top: 10);
		id: #'package--header-tags';
		vFitContent;
		hMatchParent).
	
	^ aContainer
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createPackageTagNamed: aName stream: aStream [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new);
		beSmallSize;
		visibility: BlVisibility gone;
		geometry: BlStadiumGeometry new;
		background: self theme status neutralBackgroundColor;
		padding: (BlInsets top: 1 bottom: 1 left: 6 right: 6);
		margin: (BlInsets top: 0 bottom: 3 left: 0 right: 5);
		text: aName;
		in: [ :aLabel | aLabel viewModel model: aStream ];
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnObject: anEvent currentTarget viewModel model asyncSimilarCopy ];
		withAsyncFutureDo: [ :anElementFuture |
			anElementFuture
				future: aStream hasNext;
				whenSuccess: [ :aLabel :isNotEmpty |
					isNotEmpty
						ifTrue: [ aLabel visibility: BlVisibility visible ]
						ifFalse: [ aLabel visibility: BlVisibility gone ] ] ]
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createRoundedPaneElement [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		addAptitude: BrShadowAptitude;
		background: Color white;
		padding: (BlInsets all: 10);
		margin: (BlInsets all: 5)
]

{ #category : #'private - instance creation' }
GtPharoPackageOverviewElement >> createWhichBaselineElement [
	aContainer := BrHorizontalFlow new.
	aContainer
		hMatchParent;
		vFitContent.

	^ aContainer
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> exampleClassesStream [
	^ self classesStream select: [ :eachClass | eachClass gtExamples notEmpty ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> extensionMethodsStream [
	^ package extensionMethods asAsyncStream
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> ffiClassesStream [
	^ (self classesStream select: [ :eachClass |
		(eachClass instanceSide localMethods anySatisfy: [ :eachMethod | eachMethod isFFIMethod ])
			or: [ eachClass classSide localMethods anySatisfy: [ :eachMethod | eachMethod isFFIMethod ] ] ])
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> ffiMethodsStream [
	^ (self classesStream collect: [ :eachClass | AsyncBehaviorAllMethodsStream forBehavior: eachClass ]) flatten
		select: [ :eachMethod | eachMethod isFFIMethod ]
]

{ #category : #initialization }
GtPharoPackageOverviewElement >> initialize [
	super initialize.
	
	self background: Color white.

	self matchParent.
	self padding: (BlInsets top: 20 bottom: 20 left: 20 right: 20).
	
	self addChild: (headerElement := self createPackageHeader).
	
	self addChild: (BrHorizontalPane new
		matchParent;
		margin: (BlInsets top: 10);
		addChild: (self createRoundedPaneElement addChild: (behaviorTypesList := self createClassTypesList));
		addChild: (
			BrVerticalPane new
				matchParent;
				margin: (BlInsets left: 10);
				addChild: (self createRoundedPaneElement
					addChild: (extendedMethodsElement := self createExtensionMethodsStatistic));
				addChild: (self createRoundedPaneElement
					addChild: (dependenciesShortElement := self createPackageDependenciesStatistic));
				addChild: (self createRoundedPaneElement
					addChild: (whichBaselineElement := self createWhichBaselineElement))))
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> metadataStream [
	^ package packageManifestOrNil
		ifNil: [ AsyncEmptyStream new ]
		ifNotNil: [ :aManifest | { aManifest } asAsyncStream ]
]

{ #category : #accessing }
GtPharoPackageOverviewElement >> package: aPackage [
	package := aPackage.
	
	extendedMethodsElement asyncSink forwardStream: self extensionMethodsStream.
	dependenciesShortElement asyncSink forwardStream: self packageDependenciesStream.
	behaviorTypesList groups: self behaviorTypeGroupesStream.
	
	headerElement
		childWithId: #'package--header-label'
		ifFound: [ :aLabel | aLabel text: package name ].
		
	headerElement
		childWithId: #'package--header-tags'
		ifFound: [ :aTagsContainer |
			aTagsContainer removeChildren.
			self buildPackageTagsIn: aTagsContainer ].
		
	self updateWhichBaselines
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> packageDependenciesStream [
	^ [ package gtDependenciesStatusByAnalyzer asAsyncStream ] asAsyncFuture asAsyncStream flatten
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> streamToCountStream: aStream [
	^ ((aStream inject: 0 into: [ :aSum :each | aSum + 1 ]) map: [ :aValue |
			aValue isZero
				ifTrue: [ AsyncEmptyStream new ]
				ifFalse: [ { aValue } asAsyncStream ] ]) asAsyncStream flatten
]

{ #category : #'private - utilities' }
GtPharoPackageOverviewElement >> traitGroupForStream: aStream named: aName [
	^ self
		behaviorGroupForStream: aStream
		named: aName
		ofType: 'traits'
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> traitsStream [
	^ self classesAndTraitsStream
		select: [ :eachBehavior | eachBehavior isTrait ]
]

{ #category : #'private - updating' }
GtPharoPackageOverviewElement >> updateWhichBaselines [
	whichBaselineElement removeChildren.
	
	(GtDependencyAnalyzerForPackage baselinesForPackage: package)
		ifEmpty: [
			whichBaselineElement addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Does not belong to any baseline') ]
		ifNotEmpty: [ :theBaselines |
			whichBaselineElement addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Belongs to the following baseline(s):').
			theBaselines do: [ :eachBaseline |
				whichBaselineElement addChild: (BrButton new
					aptitude: BrGlamorousLinkButtonWithLabelAptitude;
					model: eachBaseline;
					action: [ :aButton | aButton phlow spawnTool: (GtClassCoderTool forClass: aButton model) ];
					label: eachBaseline name) ] ].
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> userInterfaceClassesStream [
	^ self classesStream select: [ :eachClass | eachClass includesBehavior: BlElement ]
]

{ #category : #'private - streams' }
GtPharoPackageOverviewElement >> userInterfaceEventClassesStream [
	^ self classesStream select: [ :eachClass | eachClass includesBehavior: BlEvent ]
]
