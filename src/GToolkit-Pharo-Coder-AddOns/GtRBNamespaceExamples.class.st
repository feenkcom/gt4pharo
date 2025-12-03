Class {
	#name : #GtRBNamespaceExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #accessing }
GtRBNamespaceExamples >> convertToSiblingRefactoring [
	<gtExample>
	| model ref allChanges |
	model := GtRBNamespace new.
	ref := RBChildrenToSiblingsRefactoring
			model: model
			name: #Asdfdsa
			class: RBNamespace
			subclasses: {GtRBNamespace}.
	ref primitiveExecute.
	allChanges := model changes deepCollectAsSet: #changes.
	self
		assert: (allChanges
				anySatisfy: [ :each | (each isKindOf: RBCommentChange) and: [ each comment isNil ] ])
				not.
	^ model
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOn [
	<gtExample>
	| model implementers |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers notEmpty.
	implementers do: [ :each | self assert: (each isKindOf: RBClass) ].
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnInCustomEnvironment [
	<gtExample>
	| model implementers |
	model := GtRBNamespace
			onEnvironment: (RBSelectorEnvironment onMethods: #(printOn:) forClass: Object) not.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers size + 1 equals: self implementersOfPrintOn size.
	self assert: (implementers noneSatisfy: [ :each | each name = #Object ]).
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnTheSameAsDefault [
	<gtExample>
	| defaultEnvironment defaultImplementers gtImplementers difference1 difference2 |
	gtImplementers := self implementersOfPrintOn.
	defaultEnvironment := RBNamespace onEnvironment: RBBrowserEnvironment new.
	defaultImplementers := defaultEnvironment allImplementorsOf: #printOn:.
	difference1 := (defaultImplementers collect: #name) \ (gtImplementers collect: #name).
	difference2 := (gtImplementers collect: #name) \ (defaultImplementers collect: #name).
	self assert: defaultImplementers size = gtImplementers size.
	self assert: difference1 isEmpty.
	self assert: difference2 isEmpty.
	^ gtImplementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnWithNewClass [
	<gtExample>
	| model implementers |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	model
		defineClass: 'ProtoObject subclass: #Object1234
			instanceVariableNames: ''''
			classVariableNames: ''''
			poolDictionaries: ''''
			package: ''Kernel-Objects'''.
	(model classNamed: #Object1234)
		compile: 'printOn: aStream'
		classified: #printing.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers size - 1 equals: self implementersOfPrintOn size.
	self assert: (implementers anySatisfy: [ :each | each name = #Object1234 ]).
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnWithNewMethod [
	<gtExample>
	| model implementers |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: self class) compile: 'printOn: aStream' classified: #printing.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers size - 1 equals: self implementersOfPrintOn size.
	self assert: (implementers anySatisfy: [ :each | each name = self class name ]).
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnWithRecompiledMethod [
	<gtExample>
	| model implementers |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: Object) compile: 'printOn: aStream'.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers size equals: self implementersOfPrintOn size.
	self assert: (implementers anySatisfy: [ :each | each name = #Object ]).
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> implementersOfPrintOnWithRemovedMethod [
	<gtExample>
	| model implementers |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: Object) removeMethod: #printOn:.
	implementers := model allImplementorsOf: #printOn:.
	self assert: implementers size + 1 equals: self implementersOfPrintOn size.
	self assert: (implementers noneSatisfy: [ :each | each name = #Object ]).
	^ implementers
]

{ #category : #accessing }
GtRBNamespaceExamples >> rbClassesCategoriesMatchThoseInTheSystem [
	<gtExample>
	| model rb |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	Smalltalk allClassesAndTraits
		do: [ :each | 
			rb := (model createNewClassFor: each) first.
			self
				assert: (rb category = each category
						or: [ (rb category , '-' , rb category) = each category ]) ]
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToObject [
	<gtExample>
	| model references |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	references := OrderedCollection new.
	model
		allReferencesToClass: (model classFor: Object)
		do: [ :each | references add: each ].
	self assert: references notEmpty.
	references do: [ :each | self assert: (each isKindOf: RBMethod) ].
	^ references
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToObjectInCustomEnvironment [
	<gtExample>
	| model refs |
	model := GtRBNamespace
			onEnvironment: (RBSelectorEnvironment
					onMethods: {thisContext method selector}
					forClass: self class) not.
	refs := OrderedCollection new.
	model
		allReferencesToClass: (model classFor: Object)
		do: [ :each | refs add: each ].
	self assert: refs size + 1 equals: self referencesToObject size.
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToObjectTheSameAsDefault [
	<gtExample>
	| refs defaultRefs model |
	refs := (self referencesToObject
			collect: [ :each | 
				{each methodClass.
					each selector} ]) asSet.
	defaultRefs := Set new.
	(model := RBNamespace onEnvironment: RBBrowserEnvironment new)
		allReferencesToClass: (model classFor: Object)
		do: [ :each | 
			defaultRefs
				add: {each methodClass.
						each selector} ].
	self assert: refs size equals: defaultRefs size.
	self
		assert: (refs collect: [ :each | each first name , each last ]) asSortedCollection
		equals: (defaultRefs collect: [ :each | each first name , each last ])
				asSortedCollection.
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOn [
	<gtExample>
	| model references |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	references := model allReferencesTo: #printOn:.
	self assert: references notEmpty.
	references do: [ :each | self assert: (each isKindOf: RBMethod) ].
	^ references
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnInCustomEnvironment [
	<gtExample>
	| model refs |
	model := GtRBNamespace
			onEnvironment: (RBSelectorEnvironment onMethods: #(printStringLimitedTo:) forClass: Object) not.
	refs := model allReferencesTo: #printOn:.
	self assert: refs size + 1 equals: self referencesToPrintOn size.
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnTheSameAsDefault [
	<gtExample>
	| gtRefs defaultRefs |
	gtRefs := (self referencesToPrintOn
			collect: [ :each | 
				{each methodClass.
					each selector} ]) asSet.
	defaultRefs := (((RBNamespace onEnvironment: RBBrowserEnvironment new)
			allReferencesTo: #printOn:)
			collect: [ :each | 
				{each methodClass.
					each selector} ]) asSet.
	self assert: gtRefs size equals: defaultRefs size.
	self
		assert: (gtRefs collect: [ :each | each first name , each last ]) asSortedCollection
		equals: (defaultRefs collect: [ :each | each first name , each last ])
				asSortedCollection.
	^ gtRefs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnWithNewClass [
	<gtExample>
	| model refs |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	model
		defineClass: 'ProtoObject subclass: #Object1234
			instanceVariableNames: ''''
			classVariableNames: ''''
			poolDictionaries: ''''
			package: ''Kernel-Objects'''.
	(model classNamed: #Object1234)
		compile: 'asdf self printOn: aStream'
		classified: #printing.
	refs := model allReferencesTo: #printOn:.
	self assert: refs size - 1 equals: self referencesToPrintOn size.
	self assert: (refs anySatisfy: [ :each | each methodClass name = #Object1234 ]).
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnWithNewMethod [
	<gtExample>
	| model refs |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: self class)
		compile: 'someNewMethodName: aStream self printOn: aStream'
		classified: #printing.
	refs := model allReferencesTo: #printOn:.
	self assert: refs size - 1 equals: self referencesToPrintOn size.
	self
		assert: (refs
				anySatisfy: [ :each | 
					each methodClass name = self class name
						and: [ each selector = #someNewMethodName: ] ]).
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnWithRecompiledMethods [
	<gtExample>
	| model refs |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: Object) compile: 'printStringLimitedTo: a'.
	(model classFor: ProtoObject) compile: '== a self printOn: a'.
	refs := model allReferencesTo: #printOn:.
	self assert: refs size equals: self referencesToPrintOn size.
	self
		assert: (refs
				noneSatisfy: [ :method | 
					method methodClass name = #Object
						and: [ method selector = #printStringLimitedTo: ] ]).
	self
		assert: (refs
				anySatisfy: [ :method | method methodClass name = #ProtoObject and: [ method selector = #== ] ]).
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToPrintOnWithRemovedMethod [
	<gtExample>
	| model refs |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	(model classFor: Object) removeMethod: #printStringLimitedTo:.
	refs := model allReferencesTo: #printOn:.
	self assert: refs size + 1 equals: self referencesToPrintOn size.
	^ refs
]

{ #category : #accessing }
GtRBNamespaceExamples >> referencesToQQQZZZFromObsoleteClass [
	<gtExample>
	| model references cls method |
	cls := Object subclass: #QQQZZZReferences.
	[ method := cls
			compile: 'referencingQQQZZZ ^self QQQZZZ'
			classified: #accessing.
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	references := model privateReferencesTo: 'QQQZZZ' asSymbol.
	self assert: references notEmpty.
	references do: [ :each | self assert: (each isKindOf: RBMethod) ].
	cls removeFromSystem: false.	"Force it to not update the cache"
	self assert: (model privateReferencesTo: 'QQQZZZ' asSymbol) isEmpty ]
		ensure: [ GtPharoIndex current
				classRemoved: (self
						forPharo12AndNewer: [ ClassRemoved class: cls ]
						forPharo11: [ ClassRemoved class: cls category: cls category ]).
			cls removeSelector: 'referencingQQQZZZ' asSymbol.
			cls removeFromSystem ].
	self assert: (model privateReferencesTo: 'QQQZZZ' asSymbol) isEmpty.
	^ references
]
