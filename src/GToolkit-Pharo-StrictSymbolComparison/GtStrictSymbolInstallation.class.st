Class {
	#name : #GtStrictSymbolInstallation,
	#superclass : #Object,
	#instVars : [
		'statsSummary'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Installation'
}

{ #category : #refactoring }
GtStrictSymbolInstallation >> createExtensionPackage [

	self packageOrganizer
		packageNamed: GtStrictSymbolRefactor refactoredPackageName
		ifAbsent: [ self packageOrganizer createPackageNamed:
			GtStrictSymbolRefactor refactoredPackageName ].
]

{ #category : #managing }
GtStrictSymbolInstallation >> enableStrictSymbolComparison [

	self refactorSymbol.
	self switchSymbolTables.
	self initializeFfiCallout.
	self registerStartup.
	self installStringAndSymbolEquals.
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> initializeFfiCallout [

	FFICallout initializeTypeAliases.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> installFromFile: aFileReference [

	"self createExtensionPackage."
	self loadEqualityStatsFromFile: aFileReference.
	self refactorEqualityCalls.
	"self refactorDictionaryReferences.
	self refactorSetReferences.
	self refactorWeakSetReferences."
	self refactorSymbol.
	self switchSymbolTables.
	self initializeFfiCallout.
	self registerStartup.
	"self replaceLepiterDatabase."
	self installStringAndSymbolEquals.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> installStringAndSymbolEquals [
	"Install String>>#= and Symbol>>#= that log the comparisons (GtStrictSymbolEqualityArgumentSignal)
	and that do not consider a String and a Symbol equal when Symbol strictComparison is true"

	String compile: self stringEqualsSource classified: 'gt-stringsymbol-patch'.
	Symbol compile: self symbolEqualsSource classified: 'gt-stringsymbol-patch'
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> loadEqualityStatsFromFile: aFileReference [

	statsSummary := GtStrictSymbolSummaryGroup loadFromFile: aFileReference.
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> patchIcebergPackageNames [
	| packagesToPatch |
	packagesToPatch := IceRepository registry flatCollect: [ :aRepository | 
		((aRepository packages) select: [:aPackage | 
			aPackage name class = ByteString ]) ].
		
	packagesToPatch do: [ :aPackage |
		aPackage package: (aPackage package ifNotNil: #asSymbol) ]
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> patchIcebergRepositories [
	self patchIcebergPackageNames.
	self patchIcebergWorkingCopyPackages.
	self patchIcebergWorkingCopyProperties.
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> patchIcebergWorkingCopyPackages [
	IceRepository registry  do: [ :aRepository |
		aRepository workingCopy 
			instVarNamed: #packages 
			put: (((aRepository workingCopy 
				instVarNamed: #packages) associations collect: [ :assoc |
				assoc key asSymbol -> assoc value]) 
					as: GtStringContentDictionary)]
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> patchIcebergWorkingCopyProperties [
	IceRepository registry  do: [ :aRepository |
		| project |
		project := aRepository workingCopy project.
		project isUnborn ifFalse:
			[ project properties: (
			aRepository workingCopy project properties 
				as: GtStringContentDictionary) ] ]
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorDictionaryReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: Dictionary;
		replacementClass: GtStringContentDictionary;
		refactorAll.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorEqualityCalls [

	statsSummary refactorAll
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorOCAbstractMethodScope [

	(OCAbstractMethodScope hasSlotNamed: #tempVectorName) ifFalse:
		[ OCAbstractMethodScope addSlot: #tempVectorName ].
	OCAbstractMethodScope 
		compile: 'id: int
	<gtPharoPatch: #StrictComparison>
	id := int.
	tempVectorName := (''0vector'', id asString) asSymbol.'
		classified: 'accessing'.
	OCAbstractMethodScope 
		compile: 'tempVectorName
	<gtPharoPatch: #StrictComparison>
	"the name of the tempVector is not a valid name of a temp variable
	 This way we avoid name clashes "
	^ tempVectorName ifNil: [ tempVectorName := (''0vector'', id asString) asSymbol ]'
		classified: 'temp vars - vector'
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorSetReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: Set;
		replacementClass: GtStringContentSet;
		refactorAll.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorSymbol [

	Symbol class compile:
'rehash
   "Symbol rehash"
	"Rebuild the hash table, reclaiming unreferenced Symbols."

	SymbolTable := GtStringContentWeakSet withAll: self allSubInstances.
	NewSymbols := GtStringContentWeakSet new.
	self resetSelectorTable'
		classified: 'gt-stringsymbol-patch'.

	Symbol class compile:
'shutDown: aboutToQuit

	SymbolTable addAll: NewSymbols.
	NewSymbols := GtStringContentWeakSet new'
		classified: 'gt-stringsymbol-patch'.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> refactorWeakSetReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: WeakSet;
		replacementClass: GtStringContentWeakSet;
		refactorAll.
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> registerStartup [

	GtStrictSymbolComparisonFlag initialize.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> replaceLepiterDatabase [
	| currentDatabase databaseProperties |

	currentDatabase := LeDatabasesRegistry default defaultLogicalDatabase.
	currentDatabase saveProperties.
	databaseProperties := currentDatabase properties.
	LeDatabasesRegistry default stopMonitoring.
	LeDatabasesRegistry default 
		defaultLogicalDatabase: databaseProperties logicalDatabase.
	GtWorld allOpenWorldsDo: [:each | each knowledgeBase: LeDatabasesRegistry defaultLogicalDatabase ].
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> stringEqualsSource [
	"The source of the String>>#= installed by #installStringAndSymbolEquals: the Pharo 13 method,
	plus the comparison logging and the strict comparison check"

	<return: #String>
	^ '= aString
	"Answer whether the receiver sorts equally as aString.
	The collation order is simple ascii (with case differences).
	Installed by GtStrictSymbolInstallation>>#installStringAndSymbolEquals:
	when Symbol strictComparison is true, a Symbol is not equal to a String."

	" ''abc'' = ''def'' >>> false"

	" ''abc'' = ''abc'' >>> true"

	" ''def'' = ''abc'' >>> false"

	GtStrictSymbolEqualityArgumentSignal left: self right: aString.
	(aString isSymbol and: [ Symbol strictComparison ]) ifTrue: [ ^ false ].
	(aString isString and: [ self size = aString size ]) ifFalse: [ ^ false ].
	^ (self compare: self with: aString) = 0'
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> switchSymbolTables [
	"Switch the existing Symbol tables to use the StringContent version"

	GtStringContentWeakSet 
		adoptInstance: (Symbol classVarNamed: #NewSymbols);
		adoptInstance: (Symbol classVarNamed: #SymbolTable).
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> symbolEqualsSource [
	"The source of the Symbol>>#= installed by #installStringAndSymbolEquals: the Pharo 13 method,
	plus the strict comparison check"

	<return: #String>
	^ '= aSymbol
	"Compare the receiver and aSymbol.
	Installed by GtStrictSymbolInstallation>>#installStringAndSymbolEquals:
	when Symbol strictComparison is true, a Symbol is only equal to itself."

	self == aSymbol ifTrue: [ ^ true ].
	Symbol strictComparison ifTrue: [ ^ false ].
	self class == aSymbol class ifTrue: [ ^ false ].
	"Use String comparison otherwise"
	^ super = aSymbol'
]
