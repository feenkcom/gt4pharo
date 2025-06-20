Class {
	#name : #GtCoderNavigationPackagesTagsClassesElementExamples,
	#superclass : #GtCoderNavigationBasicPackagesTagsClassesElementExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> addAndRemoveMethodUpdatesMethodList [
	<gtExample>
	| aScripter anElement aMethodsElement aQuery |
	
	aScripter := self elementWithPackageTagAndClassSelection.
	anElement := aScripter element.
	aQuery := anElement query // GtCoderMethodsGroupedListElement.
	self assert: aQuery isEmpty not.
	self assert: aQuery result size equals: 1.
	aMethodsElement := aQuery result anyOne.
	
	self
		assert: (aMethodsElement methodList noneSatisfy: [ :meth | meth selector == #newMethod ]).
	[
		self classInPackageTag compile: 'newMethod ^self'.
		aScripter play.
		aMethodsElement methodList anySatisfy: [ :meth | meth selector == #newMethod ] ]
			ensure: [ self classInPackageTag removeSelector: #newMethod ].
	
	aScripter play.
	aMethodsElement methodList noneSatisfy: [ :meth | meth selector == #newMethod ].
	^ aScripter
]

{ #category : #'examples - basic' }
GtCoderNavigationPackagesTagsClassesElementExamples >> basicElement [
	<gtExample>
	| anElement |
	anElement := GtCoderNavigationPackagesTagsClassesElement new.
	self assert: anElement navigationModel isNil.
	^ anElement
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithExtensionPackageTagClassSelection [
	<gtExample>
	| aScripter |
	aScripter := super elementWithExtensionPackageTagClassSelection.

	"Contains: virtual protocols, instance protocols"
	aScripter checks
		label: 'Check list count is correct';
		value: [ :anElement | anElement methodProtocolsList viewModel entityCount ]
		equals: 4;
		play.
	aScripter checks
		label: 'Check protocol name is correct';
		satisfies: [ :anElement | anElement selectedProtocol name = ('*' , self packageWithTagsAndExtensions name) ].

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageAndClassSelection [
	<gtExample>
	| aScripter anElement |
	
	aScripter := super elementWithPackageAndClassSelection.
	anElement := aScripter element.
	
	self assert: anElement methodProtocolsList isVisible.
	
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageTagAndClassSelection [
	<gtExample>
	| aScripter anElement |
	
	aScripter := super elementWithPackageTagAndClassSelection.
	anElement := aScripter element.
	self assert: anElement methodProtocolsList isVisible.

	^ aScripter
]

{ #category : #accessing }
GtCoderNavigationPackagesTagsClassesElementExamples >> numberOfSubscriptions [
	<gtExample>
	| theGlobals aMethodThree theGlobalsThree aMethodFour theGlobalsFour aMethodFive theGlobalsFive |
	aMethodThree := GtCoderMethodsGroupedListElement>>#subscribeToNavigationModel.
	theGlobalsThree := aMethodThree ast allVariables select: #isGlobal.
	aMethodFour := GtCoderProtocolsGroupedListElement>>#subscribeToNavigationModel.
	theGlobalsFour := aMethodFour ast allVariables select: #isGlobal.
	aMethodFive := GtCoderSlotsGroupedListElement>>#subscribeToNavigationModel.
	theGlobalsFive := aMethodFive ast allVariables select: #isGlobal.
	theGlobals := theGlobalsThree, theGlobalsFour, theGlobalsFive.
	self assert: theGlobals size > 6.
	^ theGlobals size + super numberOfSubscriptions
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> simplePackage [
	<gtExample>
	^ 'GToolkit-Coder-Examples' asPackage 
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> uncategorizedPackageTag [
	<gtExample>
	| aPackage aPackageTag aTag |
	aPackage := self classInUncategorizedPackageTag package.
	aPackageTag := aPackage tags detect: [ :eachTag | eachTag isRoot ].
	aTag := GtCoderPackageUncategorizedTag forPackageTag: aPackageTag.
	self assert: (aTag = aPackageTag).
	self assert: (aTag = aPackage) not.
	self assert: (aTag = self packageTag) not.
	^ aTag
]
