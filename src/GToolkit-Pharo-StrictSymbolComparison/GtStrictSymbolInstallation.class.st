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
	self refactorDictionaryReferences.
	self refactorSetReferences.
	self refactorWeakSetReferences.
	self switchSymbolTables.
	self initializeFfiCallout.
	self registerStartup.
	self replaceLepiterDatabase.
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
