Class {
	#name : #GtCoderNavigationModelExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Navigation'
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

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> examplePackage [
	^ 'GToolkit-Examples-Dummies-Package1' asPackage
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectClassInDifferentPackageWithNoTagsNavigationExample [
	<gtExample>
	| aModel aPackage |
	aModel := self selectPackageWithExtension.
	aModel selectClass: GtExampleAnnouncement.
	aPackage := 'GToolkit-Examples' asPackage.
	self
		assertSelectionOfPackage: aPackage
		tag: (aPackage tagNamed: 'Announcements')
		class: GtExampleAnnouncement
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
		tag: (aPackage tagNamed: 'Navigation')
		class: GtCoderNavigationModelExamples
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectExtendedClass [
	<gtExample>
	| aModel aPackage |
	aModel := self basicPackageTagsClassesNavigation.
	aPackage := 'GToolkit-Pharo-Coder' asPackage.
	aModel selectPackage: aPackage.
	aModel selectClass: RBRenameClassChange.
	self
		assertSelectionOfPackage: aPackage
		tag: (GtCoderPackageExtensionTag forPackage: aPackage)
		class: RBRenameClassChange
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectExtendedClassInSamePackage [
	<gtExample>
	| aModel aPackage |
	aModel := self selectExtendedClass.
	aPackage := aModel selectedPackage.
	aModel selectClass: RBAddClassChange.
	self
		assertSelectionOfPackage: aPackage
		tag: (GtCoderPackageExtensionTag forPackage: aPackage)
		class: RBAddClassChange
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
	aTag := aPackage tagNamed: 'Navigation'.
	aModel selectPackageTag: aTag.
	self
		assertSelectionOfPackage: aPackage
		tag: aTag
		class: nil
		inModel: aModel.
	^ aModel
]

{ #category : #'examples - navigation model' }
GtCoderNavigationModelExamples >> selectPackageWithExtension [
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
GtCoderNavigationModelExamples >> selectSuperclassInDifferentPackage [
	<gtExample>
	| aModel aPackage aTag |
	aModel := self selectExtendedClass.
	aPackage := 'Refactoring-Changes' asPackage.
	aTag := (aPackage tagNamed: 'Changes-Classes').
	aModel selectClass: RBRemoveClassChange.
	self
		assertSelectionOfPackage: aPackage
		tag: aTag
		class: RBRemoveClassChange
		inModel: aModel.
	^ aModel
]
