"
Coordinates existing single-class conversions. Use classes: with a collection of classes, or model:classes: with classes from a supplied refactoring model. Target names remove a trailing Tests or Test suffix, when present, and append Examples. model:classMapping: remains available for custom target names. Every direct parent must be TestCase or included in the input; otherwise applicability preconditions abort. Orders sources parent first and stages conversions privately, then adds one composite change to the caller model. Sources and preexisting caller changes remain unchanged. Supplies mapped target superclasses to GtSUnitToExamplesRefactoring without changing its initializer selection or selector conversion policies. primitiveExecute previews; inherited execute applies changes.
"
Class {
	#name : #GtSUnitToExamplesHierarchyRefactoring,
	#superclass : #ReRefactoring,
	#instVars : [
		'classMapping'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtSUnitToExamplesHierarchyRefactoring class >> classes: classes [
	^ self model: GtRBNamespace new classes: classes
]

{ #category : #'instance creation' }
GtSUnitToExamplesHierarchyRefactoring class >> model: aModel classMapping: aMapping [
	^ self new initializeModel: aModel classMapping: aMapping
]

{ #category : #'instance creation' }
GtSUnitToExamplesHierarchyRefactoring class >> model: aModel classes: classes [
	| mapping |
	mapping := Dictionary new.
	classes
		do: [ :each | 
			| n baseName |
			n := each name asString.
			baseName := (n removeSuffix: 'Tests') removeSuffix: 'Test'.
			mapping at: n asSymbol put: (baseName , 'Examples') asSymbol ].
	^ self model: aModel classMapping: mapping
]

{ #category : #preconditions }
GtSUnitToExamplesHierarchyRefactoring >> applicabilityPreconditions [
	| conditions |
	conditions := OrderedCollection new.
	conditions
		add: ((RBCondition withBlock: [ classMapping notEmpty ])
				errorMacro: 'Select at least one class to convert').
	conditions
		add: ((RBCondition withBlock: [ classMapping values asSet size = classMapping size ])
				errorMacro: 'Target class names must be unique').
	classMapping
		keysAndValuesDo: [ :name :target | 
			| source |
			source := self model classNamed: name.
			conditions
				add: ((RBCondition withBlock: [ source notNil ])
						errorMacro: 'Source class does not exist: ' , name).
			conditions add: (RBCondition isValidClassName: target).
			conditions
				add: ((RBCondition withBlock: [ (self model includesGlobal: target) not ])
						errorMacro: 'Target class already exists: ' , target).
			source
				ifNotNil: [ conditions
						add: ((RBCondition
								withBlock: [ source superclass notNil
										and: [ source superclass name = #TestCase
												or: [ classMapping includesKey: source superclass name ] ] ])
								errorMacro: 'Superclass must be TestCase or included in the input: ' , name) ] ].
	^ self applicabilityPreconditionsFor: conditions
]

{ #category : #printing }
GtSUnitToExamplesHierarchyRefactoring >> gtDescription [
	^ 'Convert SUnit hierarchy to examples'
]

{ #category : #initialization }
GtSUnitToExamplesHierarchyRefactoring >> initializeModel: aModel classMapping: aMapping [
	self model: aModel.
	classMapping := Dictionary new.
	aMapping
		keysAndValuesDo: [ :source :target | classMapping at: source asSymbol put: target asSymbol ].
	^ self
]

{ #category : #private }
GtSUnitToExamplesHierarchyRefactoring >> orderedSourceNames [
	^ classMapping keys
		sorted: [ :a :b | 
			| aDepth bDepth |
			aDepth := (self model classNamed: a) allSuperclasses size.
			bDepth := (self model classNamed: b) allSuperclasses size.
			aDepth = bDepth
				ifTrue: [ a asString <= b asString ]
				ifFalse: [ aDepth < bDepth ] ]
]

{ #category : #transforming }
GtSUnitToExamplesHierarchyRefactoring >> privateTransform [
	| orderedNames staging composite |
	orderedNames := self orderedSourceNames.
	staging := self stagingModelFor: orderedNames.
	orderedNames
		do: [ :name | 
			| parentName converter |
			parentName := (staging classNamed: name) superclass name.
			converter := GtSUnitToExamplesRefactoring
					model: staging
					from: name
					to: (classMapping at: name)
					superclass: (parentName = #TestCase
							ifTrue: [ #Object ]
							ifFalse: [ classMapping at: parentName ]).
			self performCompositeRefactoring: converter ].	"Publish only after every conversion has succeeded in the private namespace."
	composite := RBCompositeRefactoryChange named: self gtDescription.
	self model
		performChange: composite
		around: [ orderedNames
				do: [ :name | 
					| target definition copy |
					target := staging classNamed: (classMapping at: name).
					definition := staging changes changes
							detect: [ :change | 
								(change isKindOf: GtRBAddClassChange)
									and: [ change changeClassName = target name ] ].
					self model defineClass: definition definitionString.
					copy := self model classNamed: target name.
					target localSelectors
						do: [ :selector | 
							copy
								compile: (target sourceCodeFor: selector)
								classified: (target protocolsFor: selector) ].
					target classSide localSelectors
						do: [ :selector | 
							copy classSide
								compile: (target classSide sourceCodeFor: selector)
								classified: (target classSide protocolsFor: selector) ] ] ]
]

{ #category : #private }
GtSUnitToExamplesHierarchyRefactoring >> stagingModelFor: orderedNames [
	| staging |
	staging := GtRBNamespace onEnvironment: self model environment.
	orderedNames
		do: [ :name | 
			| source copy |
			source := self model classNamed: name.
			staging defineClass: source gtDefinitionString.
			copy := staging classNamed: name.
			source localSelectors
				do: [ :selector | 
					copy
						compile: (source sourceCodeFor: selector)
						classified: (source protocolsFor: selector) ].
			source classSide localSelectors
				do: [ :selector | 
					copy classSide
						compile: (source classSide sourceCodeFor: selector)
						classified: (source classSide protocolsFor: selector) ] ].
	^ staging
]
