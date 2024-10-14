Class {
	#name : #GtStrictSymbolInstallation,
	#superclass : #Object,
	#instVars : [
		'statsSummary'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Installation'
}

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> initializeFfiCallout [

	FFICallout initializeTypeAliases.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> installFromFile: aFileReference [

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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> loadEqualityStatsFromFile: aFileReference [

	statsSummary := GtStrictSymbolSummaryGroup loadFromFile: aFileReference.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> refactorDictionaryReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: Dictionary;
		replacementClass: GtStringContentDictionary;
		refactorAll.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> refactorEqualityCalls [

	statsSummary refactorAll
]

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> refactorSetReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: Set;
		replacementClass: GtStringContentSet;
		refactorAll.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> refactorWeakSetReferences [

	GtStrictSymbolClassReplacement new 
		originalClass: WeakSet;
		replacementClass: GtStringContentWeakSet;
		refactorAll.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> registerStartup [

	GtStrictSymbolComparisonFlag initialize.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtStrictSymbolInstallation >> switchSymbolTables [
	"Switch the existing Symbol tables to use the StringContent version"

	GtStringContentWeakSet 
		adoptInstance: (Symbol classVarNamed: #NewSymbols);
		adoptInstance: (Symbol classVarNamed: #SymbolTable).
]
