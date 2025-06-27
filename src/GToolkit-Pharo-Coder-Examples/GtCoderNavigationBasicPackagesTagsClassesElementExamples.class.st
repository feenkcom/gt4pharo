Class {
	#name : #GtCoderNavigationBasicPackagesTagsClassesElementExamples,
	#superclass : #GtCoderNavigationModelExamples,
	#category : #'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #asserting }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> assertSelectionOfPackage: aRPackage tag: aRPackageTag class: aClass inElement: anElement [
	self assert: anElement selectedPackage equals: aRPackage.
	self assert: anElement selectedPackageTag equals: aRPackageTag.
	self assert: anElement selectedClass equals: aClass
]

{ #category : #'examples - basic' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> basicElement [
	<gtExample>
	| anElement |
	anElement := GtCoderNavigationBasicPackagesTagsClassesElement new.
	self assert: anElement navigationModel isNil.
	^ anElement
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> classInPackage [
	<gtExample>
	^ BaselineOfGToolkitCoder
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> classInPackageTag [
	<gtExample>
	^ self class
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> classInUncategorizedPackageTag [
	<gtExample>
	^ GtCoderUncategorizedDummyClass
]

{ #category : #'examples - basic' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementNavigationModel [
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
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementNavigationModelInSpace [
	<gtExample>
	| anElement aScripter |
	anElement := self elementNavigationModel.
	
	aScripter := BlScripter new element: anElement.
	
	self assert: anElement navigationModel announcer numberOfSubscriptions equals: self numberOfSubscriptions.
	self assertSelectionOfPackage: nil tag: nil class: nil inElement: anElement.

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithExtensionPackageTagClassSelection [
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
				inElement: aScripter ].
	
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithExtensionPackageTagSelection [
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

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageAndClassSelection [
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
	
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageAndClassSelection_BeforeInSpace [
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
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageTagAndClassSelection [
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

	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageTagAndClassSelection_BeforeInSpace [
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
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageTagSelection [
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

	^ aScripter
]

{ #category : #'examples - package selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageWithoutTagsAndExtensionsSelection [
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

	^ aScripter
]

{ #category : #'examples - package selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithPackageWithoutTagsAndExtensionsSelection_Children [
	<gtExample>
	| aScripter aPackageNode |
	aScripter := self elementWithPackageWithoutTagsAndExtensionsSelection.
	aPackageNode := aScripter element selectedPackageNodeDo: [ :aNode | aNode ].
	self assert: aPackageNode isNotNil.
	self assert: aPackageNode childrenValues size equals: 0.
	^ aScripter
]

{ #category : #'examples - class selection' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithUncategorizedPackageTagAndClassSelection [
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
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> elementWithUncategorizedPackageTagAndClassSelection_BeforeInSpace [
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
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> extensionTag [
	<gtExample>
	^ GtCoderPackageExtensionTag forPackage: self packageWithTagsAndExtensions.
]

{ #category : #accessing }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> numberOfSubscriptions [
	<gtExample>
	| aMethodOne aMethodTwo theGlobalsOne theGlobalsTwo theGlobals  |
	aMethodOne := GtCoderNavigationElement >> #subscribeToNavigationModel.
	theGlobalsOne := aMethodOne ast allVariables select: #isGlobal.
	aMethodTwo := GtCoderNavigationBasicPackagesTagsClassesElement >> #subscribeToNavigationModel.
	theGlobalsTwo := aMethodTwo ast allVariables select: #isGlobal.
	theGlobals := theGlobalsOne, theGlobalsTwo.
	self assert: theGlobals size > 14.
	^ theGlobals size
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> packageTag [
	<gtExample>
	^ self packageWithTagsAndWithoutExtensions tagNamed: 'Navigation'
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> packageWithoutTagsAndExtensions [
	<gtExample>
	^ 'GToolkit-Coder-Examples-SystemS1' asPackage 
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> packageWithTagsAndExtensions [
	<gtExample>
	^ 'GToolkit-Pharo-Coder-AddOns' asPackage 
]

{ #category : #'examples - system items' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> packageWithTagsAndWithoutExtensions [
	<gtExample>
	^ 'GToolkit-Pharo-Coder-Examples' asPackage 
]

{ #category : #'examples - basic' }
GtCoderNavigationBasicPackagesTagsClassesElementExamples >> scripterOnElementNavigationModelInSpace [
	<gtExample>
	^ self elementNavigationModelInSpace
]
