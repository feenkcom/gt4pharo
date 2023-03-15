Class {
	#name : #GtCoderNavigationModelExamples,
	#superclass : #Object,
	#instVars : [
		'elements',
		'spaces'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #asserting }
GtCoderNavigationModelExamples >> assertSelectionOfPackage: aRPackage tag: aRPackageTag class: aClass inModel: aModel [

	self assert: aModel selectedPackage equals: aRPackage.
	self assert: aModel selectedTag equals: aRPackageTag.
	self assert: aModel selectedClass equals: aClass.
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> basicPackageTagsClassesNavigation [
	<gtExample>
	| aModel |
	aModel := GtCoderNavigationPackagesTagsClassesModel new.
	self assertSelectionOfPackage: nil tag: nil class: nil inModel: aModel.
	^ aModel
]

{ #category : #'examples - space' }
GtCoderNavigationModelExamples >> closeSpaces [
	elements do: #removeFromParent.
	spaces do: #close.
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> examplePackage [
	^ 'SUnit-Help' asPackage
]

{ #category : #initialization }
GtCoderNavigationModelExamples >> initialize [
	super initialize.
	elements := OrderedCollection new: 1.
	spaces := OrderedCollection new: 1.
]

{ #category : #'examples - space' }
GtCoderNavigationModelExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Documenter Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #'examples - space' }
GtCoderNavigationModelExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace root addChild: aBlElement.
	self registerSpace: aSpace element: aBlElement.
	^ aSpace
]

{ #category : #'examples - space' }
GtCoderNavigationModelExamples >> registerSpace: aSpace element: aBlElement [
	<gtExample>
	<after: #closeSpaces>
	spaces add: aSpace.
	elements add: aBlElement.
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectClassInDifferentPackageWithNoTagsNavigationExample [
	<gtExample>
	| aModel |
	aModel := self selectPackage.
	aModel selectClass: CustomHelp.
	self
		assertSelectionOfPackage: self examplePackage
		tag: nil
		class: CustomHelp
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectClassNavigationExample [
	<gtExample>
	| aModel aPackage |
	aModel := self basicPackageTagsClassesNavigation.
	aModel selectClass: GtCoderNavigationModelExamples.
	aPackage := 'GToolkit-Pharo-Coder-Examples' asPackage.
	self
		assertSelectionOfPackage: aPackage
		tag: (aPackage classTagNamed: 'Navigation')
		class: GtCoderNavigationModelExamples
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectPackage [
	<gtExample>
	| aModel |
	aModel := self basicPackageTagsClassesNavigation.
	aModel selectPackage: self examplePackage.
	self
		assertSelectionOfPackage: self examplePackage
		tag: nil
		class: nil
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectPackage: aRPackage in: aModel [
	<gtExample>
	aModel selectPackage: aRPackage.
	self assert: aModel selectedPackage equals: aRPackage.
	self assert: aModel selectedTag isNil.
	self assert: aModel selectedClass isNil.
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectPackageAndTag [
	<gtExample>
	| aModel aPackage aTag |
	aModel := self basicPackageTagsClassesNavigation.
	aPackage := 'GToolkit-Pharo-Coder-Examples' asPackage.
	aModel selectPackage: aPackage.
	aTag := aPackage classTagNamed: 'Navigation'.
	aModel selectPackageTag: aTag.
	self
		assertSelectionOfPackage: aPackage
		tag: aTag
		class: nil
		inModel: aModel.
	^ aModel
]
