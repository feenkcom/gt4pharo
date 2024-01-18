Class {
	#name : #GtCoderNavigationPackagesTagsClassesElementExamples,
	#superclass : #GtCoderNavigationModelExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> addAndRemoveMethodUpdatesMethodList [
	<gtExample>
	| aScripter anElement |
	
	aScripter := self elementWithPackageTagAndClassSelection.
	anElement := aScripter element.
	
	self
		assert: (anElement methodList noneSatisfy: [ :meth | meth selector == #newMethod ]).
	[
		self classInPackageTag compile: 'newMethod ^self'.
		aScripter play.
		anElement methodList anySatisfy: [ :meth | meth selector == #newMethod ] ]
			ensure: [ self classInPackageTag removeSelector: #newMethod ].
	
	aScripter play.
	anElement methodList noneSatisfy: [ :meth | meth selector == #newMethod ].
	^ aScripter
]

{ #category : #asserting }
GtCoderNavigationPackagesTagsClassesElementExamples >> assertSelectionOfPackage: aRPackage tag: aRPackageTag class: aClass inElement: anElement [
	self assert: anElement selectedPackage equals: aRPackage.
	self assert: anElement selectedPackageTag equals: aRPackageTag.
	self assert: anElement selectedClass equals: aClass
]

{ #category : #'examples - basic' }
GtCoderNavigationPackagesTagsClassesElementExamples >> basicElement [
	<gtExample>
	| anElement |
	anElement := GtCoderNavigationPackagesTagsClassesElement new.
	self assert: anElement navigationModel isNil.
	^ anElement
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> classInPackage [
	<gtExample>
	^ BaselineOfGToolkitCoder
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> classInPackageTag [
	<gtExample>
	^ self class
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> classInUncategorizedPackageTag [
	<gtExample>
	^ GtCoderUncategorizedDummyClass
]

{ #category : #'examples - basic' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementNavigationModel [
	<gtExample>
	| anElement aModel |
	anElement := self basicElement.
	aModel := self basicPackageTagsClassesNavigation.
	anElement navigationModel: aModel.
	self assert: anElement navigationModel equals: aModel.
	self assert: anElement navigationModel announcer numberOfSubscriptions > 0.
	self assertSelectionOfPackage: nil tag: nil class: nil inElement: anElement.
	^ anElement
]

{ #category : #'examples - basic' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementNavigationModelInSpace [
	<gtExample>
	| anElement aScripter |
	anElement := self elementNavigationModel.
	
	aScripter := BlScripter new element: anElement.
	
	self assert: anElement navigationModel announcer numberOfSubscriptions equals: self numberOfSubscriptions.
	self assertSelectionOfPackage: nil tag: nil class: nil inElement: anElement.

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithExtensionPackageTagClassSelection [
	<gtExample>
	| aScripter |
	aScripter := self elementWithExtensionPackageTagSelection.

	aScripter
		doStep: [ :s | 
			s
				label: 'Select  Class';
				block: [ :anElement | anElement navigationModel selectClass: ByteString ] ].

	aScripter checks
		label: 'Check Class and Package Tag Selection';
		do: [ :anElement | 
			self
				assertSelectionOfPackage: nil
				tag: self extensionTag
				class: ByteString
				inElement: aScripter ].	"Should only contain the instance label and the extension methods protocol"
	aScripter checks
		label: 'Check list count is correct';
		satisfies: [ :anElement | anElement methodProtocolsList viewModel entityCount = 2 ];
		play.
	aScripter checks
		label: 'Check protocol name is correct';
		satisfies: [ :anElement | anElement selectedProtocol name = ('*' , self packageWithTagsAndExtensions name) ].

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithExtensionPackageTagSelection [
	<gtExample>
	| aScripter tag |
	aScripter := self scripterOnElementNavigationModelInSpace.
	tag := self extensionTag.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select Package Tag';
				block: [ :anElement | anElement navigationModel selectPackageTag: tag ] ].

	aScripter checks
		label: 'Check Package Tag Selection';
		do: [ :anElement | 
			self
				assertSelectionOfPackage: nil
				tag: tag
				class: nil
				inElement: anElement ];
		play.

	aScripter checks
		label: 'Check Method Protocol List not visible';
		satisfies: [ :anElement | anElement methodProtocolsList isVisible not ];
		play.
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageAndClassSelection [
	<gtExample>
	| aScripter anElement |
	
	aScripter := self elementNavigationModelInSpace.
	anElement := aScripter element.
	
	anElement navigationModel selectClass: self classInPackage.
	aScripter play.
	
	self
		assertSelectionOfPackage: self classInPackage package
		tag: nil
		class: self classInPackage
		inElement: anElement.
	self assert: anElement methodProtocolsList isVisible.
	
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageAndClassSelection_BeforeInSpace [
	<gtExample>
	| anElement aScripter |
	anElement := self elementNavigationModel.
	anElement navigationModel selectClass: self classInPackage.
	
	aScripter := BlScripter new element: anElement.
	
	self
		assertSelectionOfPackage: self classInPackage package
		tag: nil
		class: self classInPackage
		inElement: anElement.
		
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageTagAndClassSelection [
	<gtExample>
	| aScripter anElement |
	
	aScripter := self elementNavigationModelInSpace.
	anElement := aScripter element.
	
	anElement navigationModel selectClass: self classInPackageTag.
	aScripter play.
	
	self
		assertSelectionOfPackage: nil
		tag: self packageTag
		class: self classInPackageTag
		inElement: anElement.
	self assert: anElement methodProtocolsList isVisible.

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageTagAndClassSelection_BeforeInSpace [
	<gtExample>
	| anElement aScripter |
	anElement := self elementNavigationModel.
	anElement navigationModel selectClass: self classInPackageTag.
	
	aScripter := BlScripter new element: anElement.
	
	self 
		assertSelectionOfPackage: nil
		tag: self packageTag 
		class: self classInPackageTag 
		inElement: anElement.
	
	^ aScripter
]

{ #category : #'examples - package tag selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageTagSelection [
	<gtExample>
	| aScripter |
	aScripter := self scripterOnElementNavigationModelInSpace.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select Package Tag';
				block: [ :anElement | anElement navigationModel selectPackageTag: self packageTag ] ].

	aScripter checks
		label: 'Check Package Tag Selection';
		do: [ :anElement | 
			self
				assertSelectionOfPackage: nil
				tag: self packageTag
				class: nil
				inElement: anElement ];
		play.

	aScripter checks
		label: 'Check Method Protocol List not visible';
		satisfies: [ :anElement | anElement methodProtocolsList isVisible not ];
		play.
	^ aScripter
]

{ #category : #'examples - package selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageWithoutTagsAndExtensionsSelection [
	<gtExample>
	| aScripter |
	aScripter := self scripterOnElementNavigationModelInSpace.
	aScripter
		doStep: [ :s | 
			s
				label: 'Select Package';
				block: [ :anElement | anElement navigationModel selectPackage: self packageWithoutTagsAndExtensions ] ].

	aScripter checks
		label: 'Check Package Selection';
		do: [ :anElement | 
			self
				assertSelectionOfPackage: self packageWithoutTagsAndExtensions
				tag: nil
				class: nil
				inElement: anElement ];
		play.

	aScripter checks
		label: 'Check Method Protocol List not visible';
		satisfies: [ :anElement | anElement methodProtocolsList isVisible not ];
		play.

	^ aScripter
]

{ #category : #'examples - package selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithPackageWithoutTagsAndExtensionsSelection_Children [
	<gtExample>
	| aScripter aPackageNode |
	aScripter := self elementWithPackageWithoutTagsAndExtensionsSelection.
	aPackageNode := aScripter element selectedPackageNodeDo: [ :aNode | aNode ].
	self assert: aPackageNode isNotNil.
	self assert: aPackageNode childrenValues size equals: 0.
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithUncategorizedPackageTagAndClassSelection [
	<gtExample>
	| aScripter anElement |

	aScripter := self elementNavigationModelInSpace.
	anElement := aScripter element.
	
	anElement navigationModel selectClass: self classInUncategorizedPackageTag.
	aScripter play.
	
	self 
		assertSelectionOfPackage: 'GToolkit-Coder-Examples' asPackage
		tag: nil 
		class: self classInUncategorizedPackageTag 
		inElement: anElement.

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationPackagesTagsClassesElementExamples >> elementWithUncategorizedPackageTagAndClassSelection_BeforeInSpace [
	<gtExample>
	| anElement aScripter |
	anElement := self elementNavigationModel.
	anElement navigationModel selectClass: self classInUncategorizedPackageTag.
	
	aScripter := BlScripter new element: anElement.
	
	self 
		assertSelectionOfPackage: self classInUncategorizedPackageTag package
		tag: nil
		class: self classInUncategorizedPackageTag 
		inElement: anElement.

	^ aScripter
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> extensionTag [
	<gtExample>
	^ GtCoderPackageExtensionTag forPackage: self packageWithTagsAndExtensions.
]

{ #category : #accessing }
GtCoderNavigationPackagesTagsClassesElementExamples >> numberOfSubscriptions [
	<gtExample>
	| aMethodOne aMethodTwo theGlobalsOne theGlobalsTwo theGlobals |
	aMethodOne := GtCoderNavigationElement >> #subscribeToNavigationModel.
	theGlobalsOne := aMethodOne ast allVariables select: #isGlobal.
	aMethodTwo := GtCoderNavigationPackagesTagsClassesElement >> #subscribeToNavigationModel.
	theGlobalsTwo := aMethodTwo ast allVariables select: #isGlobal.
	theGlobals := theGlobalsOne, theGlobalsTwo.
	self assert: theGlobals size > 9.
	^ theGlobals size
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> packageTag [
	<gtExample>
	^ self packageWithTagsAndWithoutExtensions classTagNamed: 'Navigation'
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> packageWithTagsAndExtensions [
	<gtExample>
	^ 'GToolkit-Pharo-Coder-AddOns' asPackage 
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> packageWithTagsAndWithoutExtensions [
	<gtExample>
	^ 'GToolkit-Pharo-Coder-Examples' asPackage 
]

{ #category : #'examples - system items' }
GtCoderNavigationPackagesTagsClassesElementExamples >> packageWithoutTagsAndExtensions [
	<gtExample>
	^ 'GToolkit-Coder-Examples-SystemS1' asPackage 
]

{ #category : #'examples - basic' }
GtCoderNavigationPackagesTagsClassesElementExamples >> scripterOnElementNavigationModelInSpace [
	<gtExample>
	^ self elementNavigationModelInSpace
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
	aPackageTag := aPackage classTags detect: [ :eachTag | eachTag name = aPackage name ].
	aTag := GtCoderPackageUncategorizedTag forPackageTag: aPackageTag.
	self assert: (aTag = aPackageTag).
	self assert: (aTag = aPackage) not.
	self assert: (aTag = self packageTag) not.
	^ aTag
]
