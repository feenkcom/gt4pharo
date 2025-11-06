Class {
	#name : #GtCopyClassFormExample,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #examples }
GtCopyClassFormExample >> checkConvertedDefinitions [
	<gtExample>
	| form newDefinition |
	form := GtCopyClassForm new for: Object.
	form superClassName: 'Association'.
	form newClassName: 'Test123'.
	form packageAndTag packageName: 'AAAAA'.
	form packageAndTag tagName: ''.
	^ #(#('ProtoObject subclass: #Object
			instanceVariableNames: ''ProtoObject''
			classVariableNames: ''Object''
			package: ''Kernel-Objects''' 'Association subclass: #Test123
			instanceVariableNames: ''ProtoObject''
			classVariableNames: ''Object''
			package: ''AAAAA''') #('ProtoObject subclass: #Object
			instanceVariableNames: ''''
			classVariableNames: ''DependentsFields''
			category: ''Kernel-Objects''' 'Association subclass: #Test123
			instanceVariableNames: ''''
			classVariableNames: ''DependentsFields''
			category: ''AAAAA''') #('ProtoObject << #Object
			slots: {#Object. #ProtoObject};
			tag: ''Objects'';
			package: ''Kernel''' 'Association << #Test123
			slots: {#Object. #ProtoObject};
			package: ''AAAAA''') #('ProtoObject << #Object' 'Association << #Test123
			package: ''AAAAA''') #('ProtoObject << #Object tag: ''Asdf''; package: ''FDSA''' 'Association << #Test123
			package: ''AAAAA''') #('ProtoObject variableSubclass: #Object
			instanceVariableNames: ''''
			classVariableNames: ''''
			package: ''Kernel-Objects''' 'Association variableSubclass: #Test123
			instanceVariableNames: ''''
			classVariableNames: ''''
			package: ''AAAAA'''))
		collect: [ :each | 
			newDefinition := form buildNewDefinitionFrom: each first.
			self
				assert: (RBParser parseExpression: newDefinition)
				equals: (RBParser parseExpression: each last).
			newDefinition ]
]

{ #category : #examples }
GtCopyClassFormExample >> checkConvertedDefinitionsWithTag [
	<gtExample>
	| form newDefinition |
	form := GtCopyClassForm new for: Object.
	form superClassName: 'Association'.
	form newClassName: 'Test123'.
	form packageAndTag packageName: 'AAAAA'.
	form packageAndTag tagName: 'BBB'.
	^ #(#('ProtoObject subclass: #Object
			instanceVariableNames: ''ProtoObject''
			classVariableNames: ''Object''
			package: ''Kernel-Objects''' 'Association subclass: #Test123
			instanceVariableNames: ''ProtoObject''
			classVariableNames: ''Object''
			package: ''AAAAA-BBB''') #('ProtoObject subclass: #Object
			instanceVariableNames: ''''
			classVariableNames: ''DependentsFields''
			category: ''Kernel-Objects''' 'Association subclass: #Test123
			instanceVariableNames: ''''
			classVariableNames: ''DependentsFields''
			category: ''AAAAA-BBB''') #('ProtoObject << #Object
			slots: {#Object. #ProtoObject};
			tag: ''Objects'';
			package: ''Kernel''' 'Association << #Test123
			slots: {#Object. #ProtoObject}; 
			tag: ''BBB'';
			package: ''AAAAA''') #('ProtoObject << #Object' 'Association << #Test123
			tag: ''BBB'';
			package: ''AAAAA''') #('ProtoObject << #Object tag: ''Asdf''; package: ''FDSA''' 'Association << #Test123
			tag: ''BBB'';
			package: ''AAAAA''') #('ProtoObject variableSubclass: #Object
			instanceVariableNames: ''''
			classVariableNames: ''''
			package: ''Kernel-Objects''' 'Association variableSubclass: #Test123
			instanceVariableNames: ''''
			classVariableNames: ''''
			package: ''AAAAA-BBB'''))
		collect: [ :each | 
			newDefinition := form buildNewDefinitionFrom: each first.
			self
				assert: (RBParser parseExpression: newDefinition)
				equals: (RBParser parseExpression: each last).
			newDefinition ]
]

{ #category : #examples }
GtCopyClassFormExample >> checkMethodsNotCopied [
	<gtExample>
	| copyClassForm originalTimestamp newTimestamp |
	self
		assert: (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass)
				isNil
		description: 'Target class already exists'.
	copyClassForm := GtCopyClassForm for: Association.
	copyClassForm newClassName: #GtCopyClassFormExampleCopiedClass.
	copyClassForm copyMethods: false.

	[ copyClassForm copyClass.
	self assert: #GtCopyClassFormExampleCopiedClass asClass selectors isEmpty ]
		ensure: [ EpMonitor current
				disableDuring: [ (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass)
						ifNotNil: [ :cls | cls removeFromSystem ] ] ]
]

{ #category : #examples }
GtCopyClassFormExample >> checkTimestampsAreDifferent [
	<gtExample>
	| copyClassForm originalTimestamp newTimestamp |
	self
		assert: (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass)
				isNil
		description: 'Target class already exists'.
	copyClassForm := GtCopyClassForm for: Association.
	copyClassForm newClassName: #GtCopyClassFormExampleCopiedClass.

	^ [ copyClassForm copyClass.
	originalTimestamp := (Association >> #value) gtLocalVersions first.
	newTimestamp := (#GtCopyClassFormExampleCopiedClass asClass >> #value)
			gtLocalVersions first.
	self assert: newTimestamp timeStamp ~= originalTimestamp timeStamp.
	newTimestamp ]
		ensure: [ EpMonitor current
				disableDuring: [ (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass)
						ifNotNil: [ :cls | cls removeFromSystem ] ] ]
]

{ #category : #examples }
GtCopyClassFormExample >> copyClassMethodEvents [
	"Ensure that Epicea events are created for methods when copying a class"
	<gtExample>
	<shouldLogWithEpicea>
	| copyClassForm epEntries epEvent |

	self assert: (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass) isNil
		description: 'Target class already exists'.
	copyClassForm := GtCopyClassForm for: Association.
	copyClassForm newClassName: #GtCopyClassFormExampleCopiedClass.

	[epEntries := GtEpiceaEventFactoryExamples epEntriesFrom: 
		[ copyClassForm copyClass ] ]
		ensure:
			[ EpMonitor current disableDuring: 
				[ (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass) ifNotNil:
					[ :cls | cls removeFromSystem ] ] ].
	self assert: epEntries isNotEmpty
		description: 'Failed to get entries'.
	epEvent := epEntries first content.
	self assert: epEvent class equals: EpClassAddition.
	self assert: epEvent behaviorAffectedName equals: #GtCopyClassFormExampleCopiedClass.
	self assert: (epEntries select: [ :entry | entry content class = EpMethodAddition ]) size equals: (Association selectors size + Association class selectors size).
]
