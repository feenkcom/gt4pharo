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

	RPackageOrganizer default
		packageNamed: GtStrictSymbolRefactor refactoredPackageName
		ifAbsent: [ RPackageOrganizer default createPackageNamed:
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

	String compile:
'= aString
	"Answer whether the receiver sorts equally as aString.
	The collation order is simple ascii (with case differences)."
	" ''abc'' = ''def'' >>> false"
	" ''abc'' = ''abc'' >>> true"
	" ''def'' = ''abc'' >>> false"

	GtStrictSymbolEqualityArgumentSignal left: self right: aString.
	(Symbol strictComparison and: [ aString isSymbol ]) ifTrue: [ ^ false ].
	(aString isString and: [self size = aString size]) ifFalse: [^false].
	^ (self compare: self with: aString collated: AsciiOrder) = 2'
		classified: 'gt-stringsymbol-patch'.

	Symbol compile:
'= aSymbol
	"Compare the receiver and aSymbol."
	
	self == aSymbol ifTrue: [^ true].
	self class == aSymbol class ifTrue: [^ false].
	"Use String comparison otherwise"
	^ super = aSymbol'
		classified: 'gt-stringsymbol-patch'.
]

{ #category : #refactoring }
GtStrictSymbolInstallation >> loadEqualityStatsFromFile: aFileReference [

	statsSummary := GtStrictSymbolSummaryGroup loadFromFile: aFileReference.
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
	GtWorld allInstances do: [:each | each knowledgeBase: LeDatabasesRegistry defaultLogicalDatabase ].
]

{ #category : #'managing - steps' }
GtStrictSymbolInstallation >> switchSymbolTables [
	"Switch the existing Symbol tables to use the StringContent version"

	GtStringContentWeakSet 
		adoptInstance: (Symbol classVarNamed: #NewSymbols);
		adoptInstance: (Symbol classVarNamed: #SymbolTable).
]
